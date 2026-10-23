#!/usr/bin/env python3
"""Render consistent release titles and notes from staged Debian package metadata."""
from __future__ import annotations

import json
import os
import pathlib
import re
import subprocess
import sys

DISPLAY_NAMES = {
    "7zip": "7-Zip",
    "bash": "Bash",
    "binutils": "GNU Binutils",
    "brave-browser": "Brave",
    "codex": "OpenAI Codex CLI",
    "coreutils": "GNU Core Utilities",
    "ffmpeg": "FFmpeg",
    "gcc-12": "GCC 12",
    "glibc": "GNU C Library (glibc)",
    "lame": "LAME",
    "libjpeg-turbo": "libjpeg-turbo",
    "mesa": "Mesa",
    "mpv": "mpv",
    "neovim": "Neovim",
    "opus": "Opus",
    "opus-tools": "Opus Tools",
    "rustdesk": "RustDesk",
    "sfk": "Swiss File Knife (SFK)",
    "sox-ng": "SoX NG",
    "zlib": "zlib",
    "zstd": "Zstandard",
    "xz-utils": "XZ Utils",
}

PREFERRED_BINARIES = {
    "glibc": ("libc6", "libc-bin"),
    "mesa": ("libgl1-mesa-dri", "libegl-mesa0", "mesa-vulkan-drivers"),
    "xorg-server": ("xserver-xorg-core",),
    "gcc-12": ("gcc-12", "cpp-12"),
    "sox-ng": ("sox-ng", "libsox-ng5"),
    "rustdesk": ("rustdesk",),
}

DEBUG_SUFFIXES = ("-dbg", "-dbgsym", "-doc")
DEV_SUFFIXES = ("-dev",)

def field(path: pathlib.Path, name: str) -> str:
    result = subprocess.run(
        ["dpkg-deb", "-f", str(path), name],
        check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
    )
    return result.stdout.strip()

def short_description(path: pathlib.Path) -> str:
    text = field(path, "Description")
    first = text.splitlines()[0].strip() if text else ""
    return re.sub(r"\s+", " ", first)

def human_name(package: str) -> str:
    return DISPLAY_NAMES.get(package.lower(), package)

def clean_cell(value: str) -> str:
    return re.sub(r"\s+", " ", value or "").replace("|", "\\|").strip()

def main() -> int:
    package = os.environ.get("PACKAGE", "").strip()
    package_version = os.environ.get("PACKAGE_VERSION", "").strip()
    source_version = os.environ.get("SOURCE_VERSION", "").strip() or package_version
    kind = os.environ.get("RELEASE_KIND", "optimized").strip().lower()
    opt_level = os.environ.get("OPT_LEVEL", "-O2").strip() or "-O2"
    build_mode = os.environ.get("BUILD_MODE", "").strip()
    compiler_profile = os.environ.get("COMPILER_PROFILE", "").strip() or f"{opt_level} -pipe -march=core2 -mtune=core2"
    if not package or not package_version:
        raise SystemExit("PACKAGE and PACKAGE_VERSION must be set.")

    debs = sorted(pathlib.Path(".").glob("*.deb"))
    if not debs:
        raise SystemExit("No .deb files found; refusing to make a release without package metadata.")

    binaries = []
    for deb in debs:
        binaries.append({
            "file": deb.name,
            "package": field(deb, "Package"),
            "version": field(deb, "Version"),
            "arch": field(deb, "Architecture"),
            "description": short_description(deb),
        })

    by_name = {item["package"].lower(): item for item in binaries}
    preferred = PREFERRED_BINARIES.get(package.lower(), ())
    primary = by_name.get(package.lower())
    if primary is None:
        primary = next((by_name[name] for name in preferred if name in by_name), None)
    if primary is None:
        primary = next(
            (
                item for item in binaries
                if not item["package"].lower().endswith(DEBUG_SUFFIXES + DEV_SUFFIXES)
            ),
            binaries[0],
        )
    description = primary["description"] or f"Binary packages built from the {package} Debian source package."

    display = human_name(package)
    release_title = f"{display} {package_version} (Intel Core 2 · Debian 12)"
    metadata = {
        "schema_version": 2,
        "source_package": package,
        "display_name": display,
        "source_version": source_version,
        "package_version": package_version,
        "kind": kind,
        "description": description,
        "primary_binary": primary["package"],
        "compiler_profile": compiler_profile,
        "build_mode": build_mode,
        "target": "Debian 12 Bookworm / amd64 / Intel Core 2",
    }

    if package.lower() == "sox-ng":
        source_ref = os.environ.get("SOURCE_REF", "sox_ng-14.8.1")
        source_commit = os.environ.get("SOURCE_COMMIT", "")
        source_sentence = f"Built from stable upstream SoX NG {source_version} source ref `{source_ref}`"
        if source_commit:
            source_sentence += f" at commit `{source_commit}`"
        source_sentence += " for Debian 12 Bookworm amd64."
    else:
        source_sentence = f"Built from the Debian Bookworm source package `{package}` version `{source_version}`, with Debian packaging and patches retained."

    lines = [
        f"<!-- core2-release-metadata: {json.dumps(metadata, sort_keys=True, ensure_ascii=False, separators=(',', ':'))} -->",
        f"# {display} {source_version}",
        "",
        description,
        "",
        source_sentence,
        "",
        "## Build",
        "",
        f"- **Package build version:** `{package_version}`",
        "- **Target:** Debian 12 Bookworm, amd64, Intel Core 2 family.",
        f"- **Compiler profile:** `{compiler_profile}`.",
        "- Debian compiler/linker hardening defaults are retained. See `BUILD-INFO.txt` for the effective CFLAGS and CXXFLAGS used by the build.",
    ]
    if build_mode:
        lines.append(f"- **Build/test mode:** {build_mode}.")
    if "rust" in build_mode.lower() or package.lower() in {"rust-sd", "cargo", "rustc"}:
        lines.append("- Rust compilation retains Debian's Rust/linker defaults and adds the Core 2 CPU target where supported.")
    lines.extend([
        "",
        "## Binary packages",
        "",
        "| Debian package | Version | Architecture | Description |",
        "|---|---|---|---|",
    ])
    for item in binaries:
        lines.append(
            f"| `{clean_cell(item['package'])}` | `{clean_cell(item['version'])}` | "
            f"{clean_cell(item['arch'])} | {clean_cell(item['description']) or '—'} |"
        )
    lines.extend([
        "",
        "The attached `.deb` files are the binary outputs of this build. Review the package list before installing; use APT to resolve dependencies.",
        "",
        "## Verification",
        "",
        "- `BUILD-INFO.txt` records the source/package versions and build configuration.",
        "- `SHA256SUMS-core2-*.txt` provides SHA-256 checksums for the published package artifacts.",
    ])
    if package.lower() == "glibc":
        lines.extend([
            "",
            "> **System-critical package:** this release can contain `libc6`, `libc-bin`, locales, and related runtime components. Do not install the complete set on a working system without a tested recovery path and a known-good backup.",
        ])
    details_path = os.environ.get("RELEASE_DETAILS_FILE", "").strip()
    if details_path:
        details = pathlib.Path(details_path)
        if details.is_file():
            details_text = details.read_text(encoding="utf-8").strip()
            if details_text:
                lines.extend(["", details_text])
    pathlib.Path("release-title.txt").write_text(release_title + "\n", encoding="utf-8")
    pathlib.Path("release-notes.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"Release title: {release_title}")
    print(f"Primary binary: {primary['package']} — {description}")
    print(f"Binary package count: {len(binaries)}")
    return 0

if __name__ == "__main__":
    sys.exit(main())
