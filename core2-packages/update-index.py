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


def release_metadata(release):
    body = str(release.get("body") or "")
    match = re.search(r"(?m)^<!-- core2-release-metadata: (\{.*\}) -->$", body)
    if not match:
        return {}
    try:
        value = json.loads(match.group(1))
    except (json.JSONDecodeError, TypeError):
        return {}
    return value if isinstance(value, dict) else {}


def package_and_version(release):
    metadata = release_metadata(release)
    if metadata.get("source_package"):
        return (
            str(metadata["source_package"]).strip(),
            str(metadata.get("package_version") or metadata.get("source_version") or "").strip(),
        )
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

def relationship_clauses(value):
    """Keep each Debian dependency clause and its alternatives with version constraints."""
    clauses = []
    for clause in split_relations(value, ","):
        alternatives = []
        for alternative in split_relations(clause, "|"):
            match = PACKAGE_NAME_RE.match(alternative)
            if match:
                alternatives.append({
                    "name": match.group(1).lower(),
                    "label": alternative.strip(),
                })
        if alternatives:
            clauses.append(alternatives)
    return clauses


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
    """Render compact, clickable runtime-dependency trees grouped by category."""
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
    output = [
        "",
        "Expand a category to see one compact dependency tree per top-level binary package.",
        "Every Pre-Depends and Depends relationship is shown with its version constraint. Links point to matching Core 2 .deb builds; dependencies not rebuilt in this repository are shown as Debian Bookworm leaves.",
        "Alternatives are marked as choices. Shared dependencies link back to where their subtree was first expanded, avoiding a huge repeated tree. Use Ctrl+F to locate a package or dependency.",
        "",
    ]
    expanded = set()
    first_path = {}
    package_width = max(28, min(44, max((len(name) for name in by_name), default=28)))
    version_width = max((len(display_version(node.get("version", ""))) for node in by_name.values()), default=1)

    def dependency_url(dependency):
        target = by_name.get(dependency)
        if not target:
            return ""
        # Avoid repeating the long .deb URL on every dependency edge.
        return str(target.get("release_url") or "")

    def package_label(name, node):
        version = display_version(node.get("version", ""))
        description = ""
        if str(node.get("primary_binary") or "").lower() == name:
            description = str(node.get("release_description") or "").strip()
        label = f"{name} {version}"
        if description:
            label += f" — {description}"
        return label

    def display_relation_label(value):
        # Keep package-specific versions readable without repeating the build timestamp.
        return re.sub(r"(\\+core2\\.\\d+)[.~]\\d{14}", r"\\1~BUILD", str(value or ""))

    def linked_package(name, label):
        url = dependency_url(name)
        safe_label = html.escape(display_relation_label(label), quote=False)
        if url:
            return f'<a href="{html.escape(url, quote=True)}"><code>{safe_label}</code></a>'
        return f"<code>{safe_label}</code>"

    def render_dependencies(name, path, depth):
        node = by_name[name]
        indent = "  " * depth
        for field in ("pre_depends", "depends"):
            relation = "Pre-Depends" if field == "pre_depends" else "Depends"
            for alternatives in relationship_clauses(node.get(field, "")):
                qualifier = " (one alternative)" if len(alternatives) > 1 else ""
                for option in alternatives:
                    dependency = option["name"]
                    target = by_name.get(dependency)
                    label = option["label"]
                    if target:
                        link = linked_package(dependency, label)
                        target_version = display_version(target.get("version", ""))
                        if dependency in path:
                            status = " — dependency cycle"
                            output.append(f"{indent}- **{relation}{qualifier}:** {link}{status}")
                            continue
                        if dependency in expanded:
                            output.append(
                                f"{indent}- **{relation}{qualifier}:** <code>{html.escape(display_relation_label(label), quote=False)}</code> "
                                "— shared dependency; tree shown above"
                            )
                            continue
                        output.append(
                            f"{indent}- **{relation}{qualifier}:** {link} "
                            f"— Core 2 build {html.escape(target_version, quote=False)}"
                        )
                        expanded.add(dependency)
                        first_path[dependency] = " > ".join(path + [dependency])
                        render_dependencies(dependency, path + [dependency], depth + 1)
                    else:
                        safe_label = html.escape(display_relation_label(label), quote=False)
                        output.append(
                            f"{indent}- **{relation}{qualifier}:** <code>{safe_label}</code> "
                            "— Debian Bookworm package; not rebuilt here"
                        )

    def render_category(category, names):
        if not names:
            return
        output.extend([
            "<details>",
            f"<summary>{html.escape(category)} ({len(names)} top-level packages)</summary>",
            "",
        ])
        for name in names:
            if name in expanded:
                continue
            node = by_name[name]
            label = package_label(name, node)
            url = dependency_url(name) or str(node.get("release_url") or "")
            output.append(f"- {linked_package(name, label)}")
            expanded.add(name)
            first_path[name] = name
            render_dependencies(name, [name], 1)
            output.append("")
        output.extend(["</details>", ""])

    category_names = {}
    for name in roots:
        category_names.setdefault(package_category(name, by_name[name]), []).append(name)
    category_order = [item[0] for item in PACKAGE_CATEGORIES] + [DEFAULT_CATEGORY]
    for category in category_order:
        render_category(category, sorted(category_names.get(category, [])))

    remaining = sorted(set(by_name) - expanded)
    if remaining:
        output.extend([
            "<details>",
            f"<summary>Dependency cycles / remaining packages ({len(remaining)} packages)</summary>",
            "",
        ])
        for name in remaining:
            if name in expanded:
                continue
            node = by_name[name]
            output.append(f"- {linked_package(name, package_label(name, node))}")
            expanded.add(name)
            first_path[name] = name
            render_dependencies(name, [name], 1)
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
            release_info = release_metadata(release)
            record["primary_binary"] = str(release_info.get("primary_binary") or "")
            record["release_description"] = str(release_info.get("description") or "")
            active[asset_id] = record

    tree_lines, count = build_tree_markdown(list(active.values()))
    output = [
        "",
        "Expand a category to see one compact dependency tree per top-level binary package.",
        "Every Pre-Depends and Depends relationship is shown with its version constraint. Links point to matching Core 2 .deb builds; dependencies not rebuilt in this repository are shown as Debian Bookworm leaves.",
        "Alternatives are marked as choices. Shared dependencies link back to where their subtree was first expanded, avoiding a huge repeated tree. Use Ctrl+F to locate a package or dependency.",
        "",
        *tree_lines,
        f"**Unique binary packages indexed:** {count}.",
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
        metadata = release_metadata(release)
        display_name = str(metadata.get("display_name") or package).strip()
        description = str(metadata.get("description") or "").strip()
        package = package.replace("|", "\\|").replace("\\n", " ").strip() or "package"
        selector = package.strip().lower()
        release_kind = "system" if str(release.get("tag_name") or "").startswith("core2-system-") else "optimized"

        lines.append(f"### {display_name} ({release_kind})")
        if version:
            lines.append(f"Version: {chr(96)}{version}{chr(96)} · Published: {published}")
        elif published:
            lines.append(f"Published: {published}")
        if description:
            lines.append(f"**Description:** {description}")

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
