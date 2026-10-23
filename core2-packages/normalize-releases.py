#!/usr/bin/env python3
"""Normalize published Core 2 Debian package release names and notes."""
from __future__ import annotations

import json
import os
import pathlib
import re
import subprocess
import sys
import tempfile
import urllib.request

USER_AGENT = "core2-release-metadata/1.0"
DISPLAY_NAMES = {
    "7zip": "7-Zip", "bash": "Bash", "binutils": "GNU Binutils",
    "brave-browser": "Brave", "codex": "OpenAI Codex CLI",
    "coreutils": "GNU Core Utilities", "ffmpeg": "FFmpeg",
    "gcc-12": "GCC 12", "glibc": "GNU C Library (glibc)",
    "lame": "LAME", "libjpeg-turbo": "libjpeg-turbo", "mesa": "Mesa",
    "mpv": "mpv", "neovim": "Neovim", "opus": "Opus",
    "opus-tools": "Opus Tools", "rustdesk": "RustDesk",
    "sfk": "Swiss File Knife (SFK)", "sox-ng": "SoX NG",
    "zlib": "zlib", "zstd": "Zstandard", "xz-utils": "XZ Utils",
}
PREFERRED = {
    "glibc": ("libc6", "libc-bin"),
    "mesa": ("libgl1-mesa-dri", "libegl-mesa0", "mesa-vulkan-drivers"),
    "xorg-server": ("xserver-xorg-core",),
    "gcc-12": ("gcc-12", "cpp-12"),
    "sox-ng": ("sox-ng", "libsox-ng5"),
}
NONPRIMARY_SUFFIXES = ("-dev", "-doc", "-dbg", "-dbgsym")


def flatten(value):
    if isinstance(value, list):
        for item in value:
            yield from flatten(item)
    else:
        yield value


def read_url(url, timeout=90):
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(request, timeout=timeout) as response:
        return response.read()


def read_asset_text(asset):
    try:
        return read_url(asset["browser_download_url"], timeout=30).decode("utf-8", "replace")
    except Exception as exc:
        print(f"  warning: cannot read {asset.get('name')}: {exc}", flush=True)
        return ""


def parse_key_values(text):
    values = {}
    for line in text.splitlines():
        if ": " in line:
            key, value = line.split(": ", 1)
            values[key.strip().lower()] = value.strip()
        elif "=" in line and not line.startswith((" ", "\t")):
            key, value = line.split("=", 1)
            values[key.strip().lower()] = value.strip()
    return values


def title_parts(release, build_info):
    values = parse_key_values(build_info)
    title = str(release.get("name") or "").strip()
    package = values.get("package", "")
    if not package:
        for prefix in ("Core 2 optimized ", "Core 2 system ", "Core 2 optimized Debian package: "):
            if title.lower().startswith(prefix.lower()):
                rest = title[len(prefix):].strip()
                match = re.match(r"^(.+?)\s+(\S+)$", rest)
                if match:
                    package = match.group(1).strip()
                    break
        if not package and re.match(r"^SFK\s", title, re.I):
            package = "sfk"
    if not package:
        return None

    version = (
        values.get("core 2 package version")
        or values.get("debian package version")
        or values.get("package version")
        or ""
    )
    source_version = (
        values.get("debian bookworm source version")
        or values.get("upstream version")
        or values.get("source version")
        or ""
    )
    if not version:
        # Existing custom releases sometimes only put the version in the title.
        rest = title
        for prefix in ("Core 2 optimized ", "Core 2 system "):
            if rest.lower().startswith(prefix.lower()):
                rest = rest[len(prefix):].strip()
                break
        match = re.match(r"^" + re.escape(package) + r"\s+(\S+)", rest, re.I)
        if match:
            version = match.group(1)
    if not source_version:
        source_version = version
    if not version:
        return None
    return package, source_version, version, values


def deb_field(asset, name):
    data = read_url(asset["browser_download_url"])
    with tempfile.TemporaryDirectory(prefix="core2-release-") as temp:
        path = pathlib.Path(temp) / str(asset.get("name") or "package.deb")
        path.write_bytes(data)
        result = subprocess.run(
            ["dpkg-deb", "-f", str(path), name],
            check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
        )
        return result.stdout.strip()


def select_primary_asset(package, assets):
    debs = [
        asset for asset in assets
        if str(asset.get("name") or "").lower().endswith(".deb")
        and asset.get("browser_download_url")
    ]
    if not debs:
        return None
    by_name = {str(a.get("name") or "").split("_", 1)[0].lower(): a for a in debs}
    exact = by_name.get(package.lower())
    if exact:
        return exact
    for preferred in PREFERRED.get(package.lower(), ()):
        if preferred in by_name:
            return by_name[preferred]
    runtime = [
        a for a in debs
        if not str(a.get("name") or "").split("_", 1)[0].lower().endswith(NONPRIMARY_SUFFIXES)
    ]
    return min(runtime or debs, key=lambda a: int(a.get("size") or 0))


def parse_profile(build_info, flags_text):
    joined = build_info + "\n" + flags_text
    values = parse_key_values(joined)
    cflags = values.get("cflags", "")
    cxxflags = values.get("cxxflags", "")
    optimization = values.get("optimization level", "-O2")
    if not optimization.startswith("-O"):
        optimization = "-O2"
    profile = f"{optimization} -pipe -march=core2 -mtune=core2"
    if cflags and cxxflags:
        profile = f"CFLAGS={cflags}; CXXFLAGS={cxxflags}"
    return profile, cflags, cxxflags, values


def markdown(value):
    return re.sub(r"\s+", " ", str(value or "")).strip().replace("|", "\\|")


def release_notes(package, source_version, package_version, kind, description, profile,
                  asset_names, build_info, flags_text, old_body, info_values):
    display = DISPLAY_NAMES.get(package.lower(), package)
    metadata = {
        "source_package": package,
        "display_name": display,
        "source_version": source_version,
        "package_version": package_version,
        "kind": kind,
        "description": description,
        "primary_binary": info_values.get("binary package", package),
        "compiler_profile": profile,
        "build_mode": info_values.get("build mode", ""),
        "target": "Debian 12 Bookworm / amd64 / Intel Core 2",
    }
    lines = [
        f"<!-- core2-release-metadata: {json.dumps(metadata, sort_keys=True, ensure_ascii=False, separators=(',', ':'))} -->",
        f"# {display} {source_version}",
        "",
        description,
        "",
    ]

    if package.lower() == "sox-ng":
        source_ref = info_values.get("stable source ref", "sox_ng-14.8.1")
        encoder_commit = re.search(r"Encoder backport: upstream commit ([0-9a-f]{7,40})", old_body, re.I)
        commit = encoder_commit.group(1) if encoder_commit else "ed26bb80b6b89065b597b46ff40ed2b42de8b89d"
        lines.extend([
            f"Built from the stable upstream SoX NG {source_version} source ref `{source_ref}` for Debian 12 Bookworm amd64.",
            "",
            "## Features and verification",
            "",
            f"- Native Opus encoder backported from upstream commit `{commit}`.",
            "- CI installed the package and verified direct SoX NG WAV-to-Opus encoding followed by Opus-to-WAV decoding; FFmpeg was not used to encode the test file.",
            "- Provides the conventional `sox`, `soxi`, `play`, and `rec` command names.",
            "- Dynamic format handlers are enabled; this changes handler loading but does not guarantee a smaller total installation.",
        ])
        config = re.search(r"(?m)^CONFIGURE_FLAGS=(.+)$", flags_text)
        if config:
            lines.extend(["", f"**Configure options:** `{config.group(1).strip()}`"])
    elif package.lower() in {"rustdesk", "sfk"}:
        lines.extend([
            f"Built for Debian 12 Bookworm amd64 on Intel Core 2 using the build profile `{profile}`.",
            "",
            "## Build-specific details",
            "",
            old_body.strip(),
        ])
    else:
        source_desc = f"Built from the Debian Bookworm source package `{package}` version `{source_version}`, retaining Debian packaging and patches."
        lines.extend([
            source_desc,
            "",
            "## Build",
            "",
            f"- **Package build version:** `{package_version}`",
            "- **Target:** Debian 12 Bookworm, amd64, Intel Core 2 family.",
            f"- **Compiler profile:** `{profile}`.",
            "- Debian compiler/linker hardening defaults are retained where present; attached build metadata records the available effective flags.",
        ])
        if package.lower() == "glibc":
            lines.extend([
                "",
                "> **System-critical package:** this release can contain `libc6`, `libc-bin`, locales, and related runtime components. Do not install all generated packages on a working system without a tested recovery path and a known-good backup.",
            ])

    deb_names = [name for name in asset_names if name.lower().endswith(".deb")]
    lines.extend(["", "## Binary packages", ""])
    if deb_names:
        lines.extend(f"- `{name}`" for name in sorted(deb_names, key=str.lower))
    else:
        lines.append("- No binary packages are attached.")
    lines.extend([
        "",
        "See `BUILD-INFO.txt` and any accompanying build metadata for source commits, effective flags, and package-specific settings. Verify `SHA256SUMS*` before installing.",
    ])
    return display, metadata, "\n".join(lines).strip() + "\n"


def main():
    if len(sys.argv) != 2:
        raise SystemExit("Usage: normalize-releases.py releases.json")
    payload = json.loads(pathlib.Path(sys.argv[1]).read_text(encoding="utf-8"))
    releases = list(flatten(payload))
    changed = 0
    skipped = 0
    failures = []

    for release in releases:
        tag = str(release.get("tag_name") or "")
        if (not tag.startswith("core2-") or release.get("draft") or release.get("prerelease")):
            continue
        assets = release.get("assets") or []
        deb_assets = [a for a in assets if str(a.get("name") or "").lower().endswith(".deb")]
        if not deb_assets:
            continue
        old_body = str(release.get("body") or "")
        if "core2-release-metadata:" in old_body:
            skipped += 1
            continue
        try:
            info_asset = next((a for a in assets if str(a.get("name") or "").lower() == "build-info.txt"), None)
            flags_asset = next((a for a in assets if str(a.get("name") or "").lower() == "core2-flags.txt"), None)
            build_info = read_asset_text(info_asset) if info_asset else ""
            flags_text = read_asset_text(flags_asset) if flags_asset else ""
            parsed = title_parts(release, build_info)
            if not parsed:
                print(f"SKIP {tag}: cannot identify source package/version from title or BUILD-INFO.txt")
                skipped += 1
                continue
            package, source_version, package_version, info_values = parsed
            kind = "system" if tag.startswith("core2-system-") else "optimized"
            profile, cflags, cxxflags, flag_values = parse_profile(build_info, flags_text)
            primary = select_primary_asset(package, deb_assets)
            if primary is None:
                print(f"SKIP {tag}: no downloadable .deb asset")
                skipped += 1
                continue
            description = deb_field(primary, "Description").splitlines()[0].strip()
            primary_binary = deb_field(primary, "Package")
            if not description:
                raise RuntimeError(f"Description field is empty for {primary.get('name')}")
            info_values["binary package"] = primary_binary
            display, metadata, body = release_notes(
                package, source_version, package_version, kind, description, profile,
                [str(a.get("name") or "") for a in assets], build_info, flags_text,
                old_body, info_values,
            )
            metadata["primary_binary"] = primary_binary
            body = body.replace(
                json.dumps(metadata, sort_keys=True, ensure_ascii=False, separators=(",", ":")),
                json.dumps(metadata, sort_keys=True, ensure_ascii=False, separators=(",", ":")),
                1,
            )
            title = f"{display} {package_version} (Intel Core 2 · Debian 12)"
            with tempfile.TemporaryDirectory(prefix="core2-release-notes-") as temp:
                notes_path = pathlib.Path(temp) / "release-notes.md"
                notes_path.write_text(body, encoding="utf-8")
                subprocess.run(
                    [
                        "gh", "release", "edit", tag, "--repo", os.environ["GITHUB_REPOSITORY"],
                        "--title", title, "--notes-file", str(notes_path),
                    ],
                    check=True,
                )
            print(f"UPDATED {tag}: {title} | {primary_binary}: {description}")
            changed += 1
        except Exception as exc:
            failures.append(f"{tag}: {exc}")
            print(f"ERROR {tag}: {exc}", file=sys.stderr, flush=True)

    summary = [
        "## Core 2 release metadata normalization",
        "",
        f"- Updated releases: {changed}",
        f"- Skipped releases: {skipped}",
        f"- Failed releases: {len(failures)}",
    ]
    if failures:
        summary.extend(["", "### Failures", ""])
        summary.extend(f"- {item}" for item in failures)
    summary.append("")
    summary_path = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary_path:
        pathlib.Path(summary_path).write_text("\n".join(summary), encoding="utf-8")
    if failures:
        raise SystemExit(1)
    print(f"Finished: {changed} release(s) normalized; {skipped} skipped.")


if __name__ == "__main__":
    main()
