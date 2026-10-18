#!/usr/bin/env python3
"""Refresh the Core 2 release index and a real binary-package dependency tree.

The tree uses Depends and Pre-Depends read from the latest published .deb for
each source package. It only expands dependency edges when the target binary is
also in this repository's current Core 2 package set; stock Debian dependencies
outside that set are intentionally omitted.
"""
import concurrent.futures
import html
import json
import pathlib
import re
import subprocess
import sys
import tempfile
import urllib.request

USER_AGENT = "core2-dependency-index/1.0"
DEBUG_SUFFIXES = ("-dbg", "-dbgsym")
CORE2_STAMP = re.compile(r"\+core2\.\d+[.~]\d{14}$")
PACKAGE_NAME_RE = re.compile(r"^\s*([a-z0-9][a-z0-9+.-]*)(?::[a-z0-9-]+)?", re.I)


def flatten_releases(payload):
    return [item for page in payload for item in page] if payload and isinstance(payload[0], list) else payload


def package_and_version(release):
    title = (release.get("name") or "").strip()
    for prefix in ("Core 2 optimized ", "Core 2 system ", "Core 2 source-built "):
        if title.lower().startswith(prefix.lower()):
            description = title[len(prefix):].strip()
            match = re.match(r"^(.*?)\s+(\S+)$", description)
            if match:
                return match.group(1).strip(), match.group(2).strip()

    tag = str(release.get("tag_name") or "core2-package")
    tag = re.sub(r"^core2-", "", tag)
    match = re.match(r"^(.+?)-(?=\d)", tag)
    if match:
        return match.group(1).replace("-", " "), ""
    return title or tag, ""


def source_release_set(releases):
    """Latest published release per source package, matching install.py's default."""
    newest = {}
    for release in releases:
        if release.get("draft") or release.get("prerelease"):
            continue
        if not str(release.get("tag_name") or "").startswith("core2-"):
            continue
        if not any(str(a.get("name") or "").lower().endswith(".deb") for a in release.get("assets", [])):
            continue
        source, _ = package_and_version(release)
        source = source.strip().lower()
        if not source:
            continue
        stamp = str(release.get("published_at") or release.get("created_at") or "")
        previous = newest.get(source)
        old_stamp = str((previous or {}).get("published_at") or (previous or {}).get("created_at") or "")
        if previous is None or stamp > old_stamp:
            newest[source] = release
    return newest


def is_debug_binary(name):
    if not str(name).lower().endswith(".deb"):
        return False
    binary = str(name).split("_", 1)[0].lower()
    return binary.endswith(DEBUG_SUFFIXES)


def visible_deb_assets(release):
    assets = []
    for asset in release.get("assets") or []:
        name = str(asset.get("name") or "")
        if not name.lower().endswith(".deb") or is_debug_binary(name):
            continue
        if not asset.get("browser_download_url") or not asset.get("id"):
            continue
        assets.append(asset)
    return assets


def parse_control(text):
    fields = {}
    current = None
    for line in text.splitlines():
        if line[:1] in (" ", "\t") and current:
            fields[current] = fields.get(current, "") + " " + line.strip()
        elif ": " in line:
            key, value = line.split(": ", 1)
            current = key.strip().lower()
            fields[current] = value.strip()
    return fields


def read_deb_metadata(asset, release):
    url = asset["browser_download_url"]
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with tempfile.TemporaryDirectory(prefix="core2-deb-meta-") as temporary:
        path = pathlib.Path(temporary) / str(asset.get("name") or "package.deb")
        with urllib.request.urlopen(request, timeout=120) as response, path.open("wb") as output:
            while True:
                chunk = response.read(1024 * 1024)
                if not chunk:
                    break
                output.write(chunk)
        result = subprocess.run(
            ["dpkg-deb", "-f", str(path)],
            text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=False
        )
        if result.returncode:
            raise RuntimeError(f"dpkg-deb failed for {asset.get('name')}: {result.stderr.strip()}")
        fields = parse_control(result.stdout)
    required = ("package", "version", "architecture")
    missing = [key for key in required if not fields.get(key)]
    if missing:
        raise RuntimeError(f"Missing {', '.join(missing)} metadata in {asset.get('name')}")
    if fields["architecture"] not in ("amd64", "all"):
        return None
    return {
        "asset_id": str(asset["id"]),
        "asset_name": str(asset.get("name") or ""),
        "package": fields["package"],
        "version": fields["version"],
        "architecture": fields["architecture"],
        "pre_depends": fields.get("pre-depends", ""),
        "depends": fields.get("depends", ""),
        "provides": fields.get("provides", ""),
        "source": package_and_version(release)[0].strip().lower(),
        "release_tag": str(release.get("tag_name") or ""),
        "published_at": str(release.get("published_at") or release.get("created_at") or ""),
    }


def split_relations(value, delimiter):
    """Split Depends syntax only outside version constraints and architecture/profile groups."""
    output = []
    start = 0
    paren = bracket = angle = 0
    for index, char in enumerate(value or ""):
        if char == "(":
            paren += 1
        elif char == ")":
            paren = max(0, paren - 1)
        elif char == "[":
            bracket += 1
        elif char == "]":
            bracket = max(0, bracket - 1)
        elif char == "<":
            angle += 1
        elif char == ">":
            angle = max(0, angle - 1)
        elif char == delimiter and paren == 0 and bracket == 0 and angle == 0:
            output.append(value[start:index].strip())
            start = index + 1
    tail = (value or "")[start:].strip()
    if tail:
        output.append(tail)
    return [part for part in output if part]


def relationship_names(value):
    """Return package names in dependency order, keeping alternative order."""
    names = []
    for clause in split_relations(value, ","):
        for alternative in split_relations(clause, "|"):
            match = PACKAGE_NAME_RE.match(alternative)
            if match:
                name = match.group(1).lower()
                if name not in names:
                    names.append(name)
    return names


def display_version(version):
    return CORE2_STAMP.sub("", str(version or ""))


def build_tree_rows(nodes):
    """Build a readable spanning forest; mark repeated DAG dependencies as shared."""
    by_name = {}
    for node in nodes:
        name = str(node.get("package") or "").lower()
        if not name:
            continue
        previous = by_name.get(name)
        stamp = str(node.get("published_at") or "")
        old_stamp = str((previous or {}).get("published_at") or "")
        if previous is None or stamp >= old_stamp:
            by_name[name] = node

    edges = {}
    for name, node in by_name.items():
        relationships = []
        for field in ("pre_depends", "depends"):
            relationships.extend(relationship_names(node.get(field, "")))
        children = []
        for dependency in relationships:
            if dependency in by_name and dependency != name and dependency not in children:
                children.append(dependency)
        edges[name] = sorted(children)

    referenced = {child for children in edges.values() for child in children}
    roots = sorted(name for name in by_name if name not in referenced)
    rows = []
    expanded = set()

    def walk(name, prefix, is_last, path):
        node = by_name[name]
        connector = "└── " if is_last else "├── "
        left = prefix + connector + name
        already_shown = name in expanded
        cycle = name in path
        if already_shown:
            left += " [shared dependency]"
        elif cycle:
            left += " [dependency cycle]"
        rows.append((left, display_version(node.get("version", ""))))
        if already_shown or cycle:
            return
        expanded.add(name)
        children = edges.get(name, [])
        next_prefix = prefix + ("    " if is_last else "│   ")
        for index, child in enumerate(children):
            walk(child, next_prefix, index == len(children) - 1, path | {name})

    for index, root in enumerate(roots):
        walk(root, "", index == len(roots) - 1, frozenset())

    # A dependency cycle has no root; emit any remaining component so no
    # published binary package silently disappears from the tree.
    remaining = sorted(set(by_name) - expanded)
    for index, name in enumerate(remaining):
        walk(name, "", index == len(remaining) - 1, frozenset())

    max_label = max((len(label) for label, _ in rows), default=0)
    return [(label.ljust(max_label + 2) + version) for label, version in rows], len(by_name)



PACKAGE_CATEGORIES = (
    ("Graphics", re.compile(r"(mesa|libdrm|pixman|xorg|xserver|wayland|libgl|libegl|libgbm|libgles|libxcb|libx11|libxext|libxi|libxrandr|libxrender|libinput|cairo|vulkan|drm)", re.I)),
    ("Audio & video", re.compile(r"(ffmpeg|gstreamer|gst-|pipewire|pulseaudio|alsa|libav|libvpx|opus|lame|flac|mpd|mpv|sox|wavpack|vorbis|codec2|x265)", re.I)),
    ("Development", re.compile(r"(-dev(?:$|[- ])|gcc|g\+\+|binutils|cmake|meson|ninja|pkg-config|python|perl|ruby|rust|golang|gdb|make)", re.I)),
    ("System & libraries", re.compile(r"(libc6|glibc|systemd|bash|dash|coreutils|util-linux|kmod|udev|apt|dpkg|sudo|pam|openssl|openssh|busybox|procps|grep|sed|tar|gzip|xz-utils|zstd|bzip2|mount|ntfs|btrfs|login|shadow|initramfs)", re.I)),
)
DEFAULT_CATEGORY = "Applications & utilities"


def package_category(name, node):
    label = (str(name or "") + " " + str(node.get("source") or "")).lower()
    for category, pattern in PACKAGE_CATEGORIES:
        if pattern.search(label):
            return category
    return DEFAULT_CATEGORY


def markdown_asset_label(value):
    return str(value or "download").replace("\\", "\\\\").replace("[", "\\[").replace("]", "\\]").replace("\n", " ").strip()


def build_tree_markdown(nodes):
    """Render an expandable GitHub-README tree with a direct download per package."""
    by_name = {}
    for node in nodes:
        name = str(node.get("package") or "").lower()
        if not name:
            continue
        stamp = str(node.get("published_at") or "")
        version = str(node.get("version") or "")
        previous = by_name.get(name)
        old_stamp = str((previous or {}).get("published_at") or "")
        download = {
            "asset_name": str(node.get("asset_name") or ""),
            "download_url": str(node.get("download_url") or ""),
            "architecture": str(node.get("architecture") or ""),
            "release_url": str(node.get("release_url") or ""),
        }
        if previous is None or stamp > old_stamp:
            record = dict(node)
            record["downloads"] = [download] if download["download_url"] else []
            by_name[name] = record
        elif stamp == old_stamp and version == str(previous.get("version") or ""):
            known_urls = {item.get("download_url") for item in previous.get("downloads", [])}
            if download["download_url"] and download["download_url"] not in known_urls:
                previous.setdefault("downloads", []).append(download)

    edges = {}
    for name, node in by_name.items():
        relationships = []
        for field in ("pre_depends", "depends"):
            relationships.extend(relationship_names(node.get(field, "")))
        edges[name] = sorted({
            dependency for dependency in relationships
            if dependency in by_name and dependency != name
        })

    referenced = {child for children in edges.values() for child in children}
    roots = sorted(name for name in by_name if name not in referenced)
    output = []
    expanded = set()
    package_width = max(28, min(44, max((len(name) for name in by_name), default=28)))
    version_width = max((len(display_version(node.get("version", ""))) for node in by_name.values()), default=1)

    def render_package(name, path):
        node = by_name[name]
        cycle = name in path
        shared = name in expanded
        marker = " <em>[dependency cycle]</em>" if cycle else (
            " <em>[shared dependency]</em>" if shared else ""
        )
        package = html.escape(name, quote=True)
        raw_version = display_version(node.get("version", ""))
        version = html.escape(raw_version, quote=True)
        name_padding = "&nbsp;" * max(2, package_width - len(name))
        version_padding = "&nbsp;" * max(0, version_width - len(raw_version))
        downloads = node.get("downloads") or []

        # A repeated dependency links directly to its .deb instead of repeating
        # a full spoiler and release link every time a shared library is used.
        if shared or cycle:
            flag = "dependency cycle" if cycle else "shared dependency"
            for item in sorted(downloads, key=lambda entry: (entry.get("asset_name", "").lower(), entry.get("architecture", ""))):
                url = item.get("download_url") or ""
                arch = html.escape(item.get("architecture") or "binary", quote=True)
                if url:
                    output.append(f"- [{package} — {version} ({flag}; {arch})]({url})")
            if not downloads:
                output.append(f"- {package} — {version} ({flag})")
            return

        output.extend([
            "<details>",
            f"<summary><code>{package}{name_padding}{version_padding}{version}</code></summary>",
            "",
            "**Download files**",
        ])

        if downloads:
            for item in sorted(downloads, key=lambda entry: (entry.get("asset_name", "").lower(), entry.get("architecture", ""))):
                label = markdown_asset_label(item.get("asset_name"))
                url = item.get("download_url") or ""
                arch = html.escape(item.get("architecture") or "binary", quote=True)
                if url:
                    output.append(f"- [{label}]({url}) (architecture: {arch})")
            release_urls = sorted({item.get("release_url") for item in downloads if item.get("release_url")})
            for url in release_urls:
                output.append(f"- [Release page]({url})")
        else:
            output.append("- _No direct binary download URL is available._")

        if not shared and not cycle:
            expanded.add(name)
            children = edges.get(name, [])
            if children:
                output.extend(["", "**Dependencies**", ""])
                for child in children:
                    render_package(child, path | {name})
                    output.append("")
        output.append("</details>")

    def render_category(category, names):
        if not names:
            return
        output.extend([
            "<details>",
            f"<summary>{html.escape(category)} ({len(names)} top-level packages)</summary>",
            "",
        ])
        for name in names:
            if name not in expanded:
                render_package(name, frozenset())
                output.append("")
        output.extend(["</details>", ""])

    category_names = {}
    for name in roots:
        category_names.setdefault(package_category(name, by_name[name]), []).append(name)
    category_order = [item[0] for item in PACKAGE_CATEGORIES] + [DEFAULT_CATEGORY]
    for category in category_order:
        render_category(category, sorted(category_names.get(category, [])))

    # Cyclic components have no top-level node. Render each remaining component once.
    remaining = sorted(set(by_name) - expanded)
    if remaining:
        output.extend([
            "<details>",
            f"<summary>Dependency cycles / remaining packages ({len(remaining)} packages)</summary>",
            "",
        ])
        for name in remaining:
            if name not in expanded:
                render_package(name, frozenset())
                output.append("")
        output.extend(["</details>", ""])

    return output, len(by_name)


def make_tree(release_set, metadata):
    active = {}
    current_asset_ids = set()
    for source, release in release_set.items():
        for asset in visible_deb_assets(release):
            asset_id = str(asset["id"])
            current_asset_ids.add(asset_id)
            record = metadata.get(asset_id)
            if not record:
                raise RuntimeError(f"Missing .deb control metadata for asset {asset_id} ({asset.get('name')})")
            if record.get("architecture") not in ("amd64", "all"):
                continue
            record = dict(record)
            record["source"] = source
            record["release_tag"] = str(release.get("tag_name") or "")
            record["published_at"] = str(release.get("published_at") or release.get("created_at") or "")
            record["asset_name"] = str(asset.get("name") or "")
            record["download_url"] = str(asset.get("browser_download_url") or "")
            record["release_url"] = str(release.get("html_url") or "")
            active[asset_id] = record

    tree_lines, count = build_tree_markdown(list(active.values()))
    output = [
        "",
        "Expand a category, then a package, to reveal direct .deb downloads. Expand dependency packages to continue following the real Debian Pre-Depends and Depends tree.",
        "The tree uses the latest published Core 2 release for each source package. Dependencies not present in this Core 2 release set are supplied by stock Debian and are omitted.",
        "Displayed versions omit this repository's +core2 build timestamp. Shared dependencies keep their own download link but are not expanded repeatedly.",
        "Use your browser's Find command (Ctrl+F) to locate a package name; GitHub README files cannot run a custom search box.",
        "",
        *tree_lines,
        f"**Unique binary packages indexed:** {count}.",
        "",
    ]
    return output, current_asset_ids



    active = {}
    current_asset_ids = set()
    for source, release in release_set.items():
        for asset in visible_deb_assets(release):
            asset_id = str(asset["id"])
            current_asset_ids.add(asset_id)
            record = metadata.get(asset_id)
            if not record:
                raise RuntimeError(f"Missing .deb control metadata for asset {asset_id} ({asset.get('name')})")
            if record.get("architecture") not in ("amd64", "all"):
                continue
            record = dict(record)
            record["source"] = source
            record["release_tag"] = str(release.get("tag_name") or "")
            record["published_at"] = str(release.get("published_at") or release.get("created_at") or "")
            active[asset_id] = record

    nodes = list(active.values())
    rows, count = build_tree_rows(nodes)
    tick = chr(96) * 3
    output = [
        "",
        "Latest published binary packages, grouped by real Debian Pre-Depends and Depends relationships.",
        "Only dependencies that are also present in the current Core 2 release set are expanded; dependencies supplied by stock Debian are omitted.",
        "Displayed versions omit the repository's +core2 build timestamp and retain the underlying Debian version.",
        "",
        tick + "text",
        *rows,
        tick,
        "",
        f"Binary packages shown: {count}. Shared dependencies are marked [shared dependency] instead of expanding repeatedly.",
        "",
    ]
    return output, current_asset_ids


def main():
    if len(sys.argv) != 4:
        raise SystemExit("Usage: update-index.py README.md dependency-metadata.json releases.json")
    readme_path = pathlib.Path(sys.argv[1])
    metadata_path = pathlib.Path(sys.argv[2])
    releases_path = pathlib.Path(sys.argv[3])

    payload = json.loads(releases_path.read_text(encoding="utf-8"))
    releases = flatten_releases(payload)
    releases = [r for r in releases if str(r.get("tag_name", "")).startswith("core2-")]

    current_sources = source_release_set(releases)
    cache_document = json.loads(metadata_path.read_text(encoding="utf-8"))
    cache = cache_document.setdefault("assets", {})

    needed = []
    for release in current_sources.values():
        for asset in visible_deb_assets(release):
            asset_id = str(asset["id"])
            if asset_id not in cache:
                needed.append((asset, release))

    if needed:
        print(f"Reading Debian control metadata from {len(needed)} new package assets...")
        failures = []
        with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:
            futures = {pool.submit(read_deb_metadata, asset, release): (asset, release) for asset, release in needed}
            for future in concurrent.futures.as_completed(futures):
                asset, release = futures[future]
                try:
                    record = future.result()
                    if record is not None:
                        cache[str(asset["id"])] = record
                except Exception as exc:
                    failures.append(f"{asset.get('name')}: {exc}")
        if failures:
            raise RuntimeError("Could not index package dependencies:\n" + "\n".join(failures[:20]))
        print(f"Cached metadata for {len(needed)} new package assets.")

    tree_lines, active_ids = make_tree(current_sources, cache)
    # Prune metadata for releases no longer selected as latest for their source.
    cache_document["schema"] = 1
    cache_document["assets"] = {key: value for key, value in cache.items() if key in active_ids}
    metadata_path.write_text(json.dumps(cache_document, indent=2, sort_keys=True) + "\n", encoding="utf-8")

    start_tree = "<!-- CORE2-PACKAGE-DEPENDENCY-TREE:START -->"
    end_tree = "<!-- CORE2-PACKAGE-DEPENDENCY-TREE:END -->"
    start_index = "<!-- CORE2-PACKAGE-RELEASE-INDEX:START -->"
    end_index = "<!-- CORE2-PACKAGE-RELEASE-INDEX:END -->"

    document = readme_path.read_text(encoding="utf-8")
    for marker in (start_tree, end_tree, start_index, end_index):
        if document.count(marker) != 1:
            raise SystemExit(f"Expected exactly one {marker} marker in README")

    tree_start = document.index(start_tree) + len(start_tree)
    tree_end = document.index(end_tree, tree_start)
    document = document[:tree_start] + "\n" + "\n".join(tree_lines).rstrip() + "\n" + document[tree_end:]

    # Preserve the existing detailed per-release asset index.
    lines = []
    install_command_written = set()
    releases.sort(key=lambda r: r.get("published_at") or r.get("created_at") or "", reverse=True)
    for release in releases:
        raw_date = release.get("published_at") or release.get("created_at") or ""
        published = raw_date.replace("T", " ").replace("Z", " UTC").strip()
        package, version = package_and_version(release)
        package = package.replace("|", "\\|").replace("\\n", " ").strip() or "package"
        selector = package.strip().lower()
        release_kind = "system" if str(release.get("tag_name") or "").startswith("core2-system-") else "optimized"

        if version:
            lines.append(f"### {package} ({release_kind})")
            lines.append(f"Version: {chr(96)}{version}{chr(96)} · Published: {published}")
        else:
            lines.append(f"### {package} ({release_kind})")
            if published:
                lines.append(f"Published: {published}")

        if selector not in install_command_written:
            command = f"curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - {selector}"
            lines.append(f"Install/update latest: {chr(96)}{command}{chr(96)}")
            install_command_written.add(selector)

        def source_archive(name):
            lower = name.lower()
            return (
                lower.endswith(".dsc")
                or ".orig.tar." in lower
                or ".debian.tar." in lower
                or lower.endswith((".diff.gz", ".tar.gz", ".tar.xz", ".tar.bz2", ".tar.zst"))
            )

        assets = sorted(
            [
                a for a in (release.get("assets") or [])
                if not source_archive(str(a.get("name") or ""))
                and not is_debug_binary(str(a.get("name") or ""))
            ],
            key=lambda a: (a.get("name") or "").lower(),
        )
        lines.append("")
        lines.append(f"<details><summary>Files ({len(assets)})</summary>")
        lines.append("")
        for asset in assets:
            name = (asset.get("name") or "download").replace("[", "\\[").replace("]", "\\]")
            url = asset.get("browser_download_url")
            if url:
                lines.append(f"- [{name}]({url})")
        if not assets:
            lines.append("- _No release assets attached._")
        if release.get("html_url"):
            lines.append(f"- [Release page]({release['html_url']})")
        lines.extend(["", "</details>", ""])

    if not lines:
        lines = ["_No Core 2 package releases have been published yet._", ""]
    start = document.index(start_index) + len(start_index)
    end = document.index(end_index, start)
    replacement = "\n" + "\n".join(lines).rstrip() + "\n"
    readme_path.write_text(document[:start] + replacement + document[end:], encoding="utf-8")


if __name__ == "__main__":
    main()
