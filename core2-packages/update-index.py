#!/usr/bin/env python3
"""Refresh current Core 2 releases and a compact runtime dependency tree.

Dependencies come from actual Pre-Depends and Depends fields in the latest
published .deb for each source package. Runtime dependencies built in this repo
are linked; stock Debian dependencies are shown as leaves. Development,
documentation, and debug split packages remain in the download index.
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


def runtime_tree_package(name):
    """Exclude development/documentation/debug split packages from the runtime view."""
    lower = str(name or "").lower()
    return not lower.endswith(("-dev", "-doc", "-dbg", "-dbgsym", "-debug", "-udeb"))


def build_tree_markdown(nodes):
    """Render a compact, searchable direct-dependency browser for runtime binaries."""
    all_by_name = {}
    for node in nodes:
        name = str(node.get("package") or "").lower()
        if not name:
            continue
        stamp = str(node.get("published_at") or "")
        previous = all_by_name.get(name)
        previous_stamp = str((previous or {}).get("published_at") or "")
        if previous is None or stamp >= previous_stamp:
            all_by_name[name] = node

    runtime = {
        name: node for name, node in all_by_name.items()
        if runtime_tree_package(name)
    }

    def display_relation_label(value):
        return re.sub(r"(\+core2\.\d+)[.~]\d{14}", r"\1~BUILD", str(value or ""))

    def package_label(name, node):
        version = display_version(node.get("version", ""))
        label = f"{name} {version}".strip()
        if str(node.get("primary_binary") or "").lower() == name:
            description = str(node.get("release_description") or "").strip()
            if description:
                label += f" — {description}"
        return label

    def linked_dependency(name, label):
        safe_label = html.escape(display_relation_label(label), quote=False)
        target = runtime.get(name)
        if target:
            # Link to the package's own direct dependency list instead of
            # recursively duplicating its entire subtree under every parent.
            return f'<a href="#core2-package-{html.escape(name, quote=True)}"><code>{safe_label}</code></a>'
        target = all_by_name.get(name)
        if target:
            url = str(target.get("release_url") or "")
            if url:
                return (
                    f'<a href="{html.escape(url, quote=True)}"><code>{safe_label}</code></a>'
                    " <em>(non-runtime Core 2 package)</em>"
                )
            return f"<code>{safe_label}</code> <em>(non-runtime Core 2 package)</em>"
        return f"<code>{safe_label}</code> <em>(Debian Bookworm)</em>"

    output = [
        "",
        "Each package below shows its direct Pre-Depends and Depends from the published .deb. "
        "Core 2 dependencies link to their own entry, so follow links to inspect the next level without duplicating entire subtrees. "
        "Stock Debian dependencies are labelled; development, documentation, and debug split packages are excluded from this runtime view.",
        "",
    ]

    # Generate a concrete example path from package control metadata.
    def find_path(start, target, path):
        if start == target:
            return path
        node = runtime.get(start)
        if not node:
            return None
        dependencies = []
        for field in ("pre_depends", "depends"):
            dependencies.extend(relationship_names(node.get(field, "")))
        for child in dependencies:
            if child in runtime and child not in path:
                found = find_path(child, target, path + [child])
                if found:
                    return found
        return None

    sox_path = find_path("sox-ng", "libebur128-1", ["sox-ng"]) if "sox-ng" in runtime else None
    if sox_path:
        output.extend([
            "**Verified SoX NG dependency path:** "
            + " → ".join("<code>" + name + "</code>" for name in sox_path),
            "",
        ])

    category_names = {}
    for name, node in runtime.items():
        category_names.setdefault(package_category(name, node), []).append(name)

    category_order = [item[0] for item in PACKAGE_CATEGORIES] + [DEFAULT_CATEGORY]
    for category in category_order:
        names = sorted(category_names.get(category, []))
        if not names:
            continue
        output.extend([
            "<details>",
            f"<summary>{html.escape(category)} ({len(names)} packages)</summary>",
            "",
        ])
        for name in names:
            node = runtime[name]
            label = html.escape(package_label(name, node), quote=False)
            release_url = str(node.get("release_url") or "")
            if release_url:
                label = f'<a href="{html.escape(release_url, quote=True)}">{label}</a>'
            output.extend([
                "<details>",
                f'<summary id="core2-package-{html.escape(name, quote=True)}"><code>{label}</code></summary>',
                "",
            ])

            for field in ("pre_depends", "depends"):
                raw = str(node.get(field) or "").strip()
                if not raw:
                    continue
                relation = "Pre-Depends" if field == "pre_depends" else "Depends"
                clauses = []
                for alternatives in relationship_clauses(raw):
                    rendered = [linked_dependency(option["name"], option["label"]) for option in alternatives]
                    if len(rendered) > 1:
                        clauses.append("one of: " + " | ".join(rendered))
                    else:
                        clauses.append(rendered[0])
                if clauses:
                    output.append(f"- **{relation}:** " + "; ".join(clauses))
            if not str(node.get("pre_depends") or "").strip() and not str(node.get("depends") or "").strip():
                output.append("- No declared Pre-Depends or Depends.")
            output.extend(["", "</details>", ""])
        output.extend(["</details>", ""])

    return output, len(runtime)

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
        *tree_lines,
        f"**Runtime binary packages in tree:** {count}. Development, documentation, and debug packages remain in the download index.",
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

    tree_intro = (
        "## Runtime dependency tree\n\n"
        "This is a compact, searchable tree of runtime binary packages from each source package's latest release. "
        "It reads actual Pre-Depends and Depends fields from the published .deb files. "
        "Dependencies built in this repository link to their release pages; stock Debian Bookworm dependencies are grouped as leaves. "
        "Development, documentation, and debug packages stay in the download index but are excluded from this runtime view. "
        "Alternatives are explicitly marked as choices, and shared dependencies identify the first tree path where they are expanded.\n\n"
    )
    document, _ = re.subn(
        r"(?ms)^## Binary package dependency tree\n.*?(?=<!-- CORE2-PACKAGE-DEPENDENCY-TREE:START -->)",
        tree_intro,
        document,
        count=1,
    )
    document, _ = re.subn(
        r"(?ms)^<details>\n<summary>Published package downloads by source release \(advanced\)</summary>\n.*?(?=<!-- CORE2-PACKAGE-RELEASE-INDEX:START -->)",
        "## Latest package releases\n\n"
        "One latest published release per Debian source package is listed here. Direct links are provided for installable .deb files; "
        "the linked release page contains build metadata, checksums, full release notes, and historical builds.\n\n",
        document,
        count=1,
    )
    tree_start = document.index(start_tree) + len(start_tree)
    tree_end = document.index(end_tree, tree_start)
    document = document[:tree_start] + "\n" + "\n".join(tree_lines).rstrip() + "\n" + document[tree_end:]

    # Keep one current release per source package; historical builds remain
    # available from GitHub Releases instead of bloating the README index.
    lines = []
    install_command_written = set()
    index_releases = sorted(
        current_sources.values(),
        key=lambda r: r.get("published_at") or r.get("created_at") or "",
        reverse=True,
    )
    for release in index_releases:
        raw_date = release.get("published_at") or release.get("created_at") or ""
        published = raw_date.replace("T", " ").replace("Z", " UTC").strip()
        package, version = package_and_version(release)
        metadata = release_metadata(release)
        display_name = str(metadata.get("display_name") or package).strip()
        description = str(metadata.get("description") or "").strip()
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

        debs = sorted(
            [
                asset for asset in (release.get("assets") or [])
                if str(asset.get("name") or "").lower().endswith(".deb")
                and not is_debug_binary(str(asset.get("name") or ""))
                and asset.get("browser_download_url")
            ],
            key=lambda asset: str(asset.get("name") or "").lower(),
        )
        if debs:
            lines.append("")
            lines.append("**Binary downloads:**")
            for asset in debs:
                name = markdown_asset_label(asset.get("name"))
                lines.append(f"- [{name}]({asset['browser_download_url']})")
        if release.get("html_url"):
            lines.append(f"**Details and historical versions:** [release page]({release['html_url']})")
        lines.append("")
    if not lines:
        lines = ["_No Core 2 package releases have been published yet._", ""]
    start = document.index(start_index) + len(start_index)
    end = document.index(end_index, start)
    replacement = "\n" + "\n".join(lines).rstrip() + "\n"
    readme_path.write_text(document[:start] + replacement + document[end:], encoding="utf-8")


if __name__ == "__main__":
    main()
