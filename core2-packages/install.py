#!/usr/bin/env python3
"""Smart installer for AmrUser-48/linux Core 2 Debian Bookworm packages.

Usage:
  curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - PACKAGE
  ... | python3 - PACKAGE --dry-run

Only updates matching binary packages already installed on this system, plus the
package's primary runtime package when it is not installed. Optional -dev, -doc,
-source, dbgsym, x32/i386 and other split packages are never added just because
they exist in a release: they are selected only if that exact package/architecture
is already installed. APT resolves dependencies and shows a simulation first.
"""
import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import urllib.error
import urllib.request
from pathlib import Path

REPO = "AmrUser-48/linux"
API = f"https://api.github.com/repos/{REPO}/releases"
USER_AGENT = "core2-smart-package-installer/1.1"

# Source package -> binary package(s) to install if none of its binary outputs
# is installed. Other binaries from that release are added only when installed.
PRIMARY = {
    "glibc": ["libc6"],
    "libxfce4util": ["libxfce4util7"],
    "libxfce4ui": ["libxfce4ui-2-0"],
    "garcon": ["libgarcon-1-0"],
    "exo": ["libexo-2-0"],
    "xorg-server": ["xserver-xorg-core"],
    "zlib": ["zlib1g"],
    "shadow": ["passwd"],
    "readline": ["libreadline8"],
    "pcre2": ["libpcre2-8-0"],
    "pam": ["libpam0g"],
    "mpfr4": ["libmpfr6"],
    "libxcrypt": ["libcrypt1"],
    "libtirpc": ["libtirpc3"],
    "libselinux": ["libselinux1"],
    "libffi": ["libffi8"],
    "gmp": ["libgmp10"],
    "mesa": ["libgl1-mesa-dri"],
    "fftw3": ["libfftw3-double3"],
    "ncurses": ["libncursesw6"],
    "rust-sd": ["sd"],
    "rust-ripgrep": ["ripgrep"],
    "rust-fd-find": ["fd-find"],
}

def request_bytes(url):
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT, "Accept": "application/vnd.github+json"})
    with urllib.request.urlopen(req, timeout=45) as response:
        return response.read()

def request_json(url):
    return json.loads(request_bytes(url).decode("utf-8"))

def package_and_version(release):
    title = str(release.get("name") or "").strip()
    for prefix in ("Core 2 optimized ", "Core 2 system "):
        if title.lower().startswith(prefix.lower()):
            description = title[len(prefix):].strip()
            match = re.match(r"^(.*?)\s+(\S+)$", description)
            if match:
                return match.group(1).strip().lower(), match.group(2).strip()
    return None, None

def release_kind_from_tag(tag_name):
    tag = str(tag_name or "")
    if tag.startswith("core2-system-"):
        return "system"
    if tag.startswith("core2-"):
        return "optimized"
    return None

def fetch_releases(kind="any"):
    if kind not in ("any", "optimized", "system"):
        raise ValueError(f"Unsupported package release kind: {kind}")
    result = []
    for page in range(1, 21):
        url = f"{API}?per_page=100&page={page}"
        rows = request_json(url)
        if not isinstance(rows, list):
            raise RuntimeError("GitHub returned an unexpected releases response.")
        if not rows:
            break
        result.extend(rows)
        if len(rows) < 100:
            break
    indexed = {}
    for release in result:
        if release.get("draft") or release.get("prerelease"):
            continue
        tag_kind = release_kind_from_tag(release.get("tag_name"))
        if tag_kind is None:
            continue
        if kind != "any" and tag_kind != kind:
            continue
        key, version = package_and_version(release)
        if not key:
            continue
        stamp = str(release.get("published_at") or release.get("created_at") or "")
        previous = indexed.get(key)
        old_stamp = str((previous or {}).get("published_at") or (previous or {}).get("created_at") or "")
        if previous is None or stamp > old_stamp:
            indexed[key] = release
    return indexed

def is_debug_package(package_name):
    return package_name.lower().endswith(("-dbg", "-dbgsym"))

def canonicalize_asset_version(version):
    """Restore the build timestamp separator lost in some uploaded asset names.

    Debian control metadata retains '+core2.1~YYYYMMDDhhmmss', while the asset
    filename may contain '+core2.1.YYYYMMDDhhmmss'. Treat those as the same
    version for comparison; do not rewrite any other part of the version.
    """
    return re.sub(r"(\+core2\.\d+)[.~](\d{14})$", r"\1~\2", version)

def parse_dpkg_deb_fields(output):
    """Parse labeled Package/Version/Architecture output from dpkg-deb."""
    fields = {}
    for line in output.splitlines():
        if ": " not in line:
            continue
        name, value = line.split(": ", 1)
        fields[name.strip().lower()] = value.strip()
    return fields

def parse_deb_asset(asset):
    name = str(asset.get("name") or "")
    if not name.endswith(".deb"):
        return None
    parts = name[:-4].rsplit("_", 2)
    if len(parts) != 3:
        return None
    package, version, arch = parts
    if not package or not version or not arch:
        return None
    version = canonicalize_asset_version(version)
    return {"asset": asset, "name": name, "package": package, "version": version, "arch": arch}

def installed_packages():
    fmt = "${Package}\t${Architecture}\t${Version}\t${db:Status-Abbrev}\n"
    result = subprocess.run(
        ["dpkg-query", "-W", "-f=" + fmt],
        text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=False
    )
    if result.returncode != 0:
        raise RuntimeError("Could not query installed packages: " + result.stderr.strip())
    installed = {}
    for line in result.stdout.splitlines():
        fields = line.split("\t")
        if len(fields) != 4:
            continue
        name, arch, version, status = fields
        if status.startswith("ii"):
            installed[(name, arch)] = version
    return installed

def version_is_newer(target, current):
    result = subprocess.run(
        ["dpkg", "--compare-versions", target, "gt", current],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=False
    )
    return result.returncode == 0

def sha256_file(path):
    digest = hashlib.sha256()
    with open(path, "rb") as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()

def checksum_map(release):
    sums_asset = next(
        (a for a in release.get("assets", []) if str(a.get("name", "")).startswith("SHA256SUMS")),
        None
    )
    if not sums_asset or not sums_asset.get("browser_download_url"):
        return {}
    try:
        text = request_bytes(sums_asset["browser_download_url"]).decode("utf-8", errors="replace")
    except Exception as exc:
        print(f"Warning: could not fetch checksum list: {exc}", file=sys.stderr)
        return {}
    found = {}
    for line in text.splitlines():
        match = re.match(r"^([0-9a-fA-F]{64})\s+[* ]?(.+?)\s*$", line)
        if match:
            found[Path(match.group(2).strip()).name] = match.group(1).lower()
    return found

def download_asset(deb, release, checksums, destination):
    asset = deb["asset"]
    url = asset.get("browser_download_url")
    if not url:
        raise RuntimeError(f"No download URL for {deb['name']}")
    path = destination / deb["name"]
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    digest = hashlib.sha256()
    with urllib.request.urlopen(req, timeout=90) as response, open(path, "wb") as target:
        while True:
            chunk = response.read(1024 * 1024)
            if not chunk:
                break
            target.write(chunk)
            digest.update(chunk)
    actual = digest.hexdigest()
    expected = None
    published_digest = asset.get("digest")
    if isinstance(published_digest, str) and published_digest.lower().startswith("sha256:"):
        expected = published_digest.split(":", 1)[1].lower()
    if not expected:
        expected = checksums.get(deb["name"])
    if expected and actual != expected:
        path.unlink(missing_ok=True)
        raise RuntimeError(f"SHA-256 mismatch for {deb['name']}; refusing to use it.")
    if not expected:
        print(f"Warning: no published SHA-256 found for {deb['name']}.", file=sys.stderr)

    metadata = subprocess.run(
        ["dpkg-deb", "-f", str(path), "Package", "Version", "Architecture"],
        text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=False
    )
    if metadata.returncode != 0:
        path.unlink(missing_ok=True)
        raise RuntimeError(f"Invalid Debian package {deb['name']}: {metadata.stderr.strip()}")
    fields = parse_dpkg_deb_fields(metadata.stdout)
    actual_package = fields.get("package", "")
    actual_version = canonicalize_asset_version(fields.get("version", ""))
    actual_arch = fields.get("architecture", "")
    if not actual_package or not actual_version or not actual_arch:
        path.unlink(missing_ok=True)
        raise RuntimeError(
            f"Could not read labeled Package/Version/Architecture fields from {deb['name']}: "
            f"{metadata.stdout.strip()}"
        )
    if (actual_package, actual_version, actual_arch) != (deb["package"], deb["version"], deb["arch"]):
        path.unlink(missing_ok=True)
        raise RuntimeError(
            f"Package metadata mismatch for {deb['name']}: "
            f"expected {deb['package']} {deb['version']} {deb['arch']}; "
            f"got {actual_package} {actual_version} {actual_arch}"
        )
    return path

def confirm(prompt):
    try:
        with open("/dev/tty", "r+", encoding="utf-8") as tty:
            tty.write(prompt)
            tty.flush()
            return tty.readline().strip().lower() in ("y", "yes")
    except OSError:
        return False

def main():
    parser = argparse.ArgumentParser(
        description="Select a Core 2 package release using installed-package-aware rules."
    )
    parser.add_argument("package", nargs="?", help="package key from core2-packages/README.md")
    parser.add_argument("--list", action="store_true", help="list available package keys")
    parser.add_argument(
        "--kind", choices=("optimized", "system", "any"), default="any",
        help="select a release family; any keeps backward-compatible newest-release selection"
    )
    parser.add_argument("--dry-run", action="store_true", help="show the APT plan but do not install")
    parser.add_argument("--yes", action="store_true", help="apply the displayed APT plan without asking")
    args = parser.parse_args()

    if os.name != "posix" or not Path("/usr/bin/dpkg-query").exists():
        raise RuntimeError("This installer is intended for Debian-based systems with dpkg.")
    architecture = subprocess.check_output(["dpkg", "--print-architecture"], text=True).strip()
    if architecture != "amd64":
        raise RuntimeError(f"This repository targets amd64; detected architecture is {architecture!r}.")

    releases = fetch_releases(args.kind)
    if args.list:
        for key, release in sorted(releases.items()):
            _, version = package_and_version(release)
            print(f"{key:20s} {version or ''}  {release.get('tag_name', '')}")
        return 0
    if not args.package:
        parser.print_help()
        print("\nAvailable package keys: " + ", ".join(sorted(releases)))
        return 2

    key = args.package.strip().lower()
    release = releases.get(key)
    if release is None:
        print(f"Unknown package key: {args.package}", file=sys.stderr)
        print("Available package keys: " + ", ".join(sorted(releases)), file=sys.stderr)
        return 2

    package_assets = [p for a in (release.get("assets") or []) if (p := parse_deb_asset(a))]
    package_assets = [
        p for p in package_assets
        if p["arch"] in ("amd64", "all") and not is_debug_package(p["package"])
    ]
    if not package_assets:
        raise RuntimeError(f"No amd64/all Debian packages attached to {release.get('tag_name')}.")

    installed = installed_packages()
    selected = {}
    skipped_current = []
    for deb in package_assets:
        current = installed.get((deb["package"], deb["arch"]))
        if current is None:
            continue
        if version_is_newer(deb["version"], current):
            deb["reason"] = f"update installed package ({current} -> {deb['version']})"
            selected[(deb["package"], deb["arch"])] = deb
        else:
            skipped_current.append((deb["package"], current, deb["version"]))

    primary_names = PRIMARY.get(key, [key])
    for primary in primary_names:
        candidate = next((d for d in package_assets if d["package"] == primary), None)
        if candidate is None:
            continue
        current = installed.get((candidate["package"], candidate["arch"]))
        if current is None:
            candidate["reason"] = "primary runtime package is not installed"
            selected[(candidate["package"], candidate["arch"])] = candidate
        # If already installed at this version or newer, leave it alone.

    if not selected:
        print(f"No package from {key} needs installation or upgrade.")
        if skipped_current:
            print("All matching installed packages are already at the release version or newer.")
        else:
            print("No matching package is installed, and no supported primary runtime package was found.")
            print("Nothing was changed.")
        return 0

    print(f"Package bundle: {key}")
    print(f"Release: {release.get('name') or release.get('tag_name')}")
    print(f"Tag: {release.get('tag_name')}")
    print("\nSelected binary packages:")
    for deb in sorted(selected.values(), key=lambda d: d["package"]):
        print(f"  {deb['package']}:{deb['arch']} {deb['version']} — {deb['reason']}")
    if skipped_current:
        print("\nAlready current/newer; not selected:")
        for name, current, target in sorted(skipped_current):
            print(f"  {name}: installed {current}, release {target}")

    with tempfile.TemporaryDirectory(prefix="core2-smart-install-") as temp:
        destination = Path(temp)
        checksums = checksum_map(release)
        paths = []
        for deb in sorted(selected.values(), key=lambda d: d["package"]):
            paths.append(download_asset(deb, release, checksums, destination))

        elevate = [] if os.geteuid() == 0 else ["sudo"]
        if elevate and not shutil.which("sudo"):
            raise RuntimeError("sudo is required when this installer is run as an unprivileged user.")
        if elevate and subprocess.run([*elevate, "-v"], check=False).returncode != 0:
            raise RuntimeError("sudo authentication failed; no packages were installed.")
        command = [
            *elevate, "apt-get", "-s", "install", "--no-install-recommends",
            *[str(p) for p in paths]
        ]
        simulation = subprocess.run(command, text=True, stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT, check=False)
        print("\nAPT simulation:")
        print(simulation.stdout.rstrip())
        if simulation.returncode != 0:
            raise RuntimeError("APT could not solve this package plan; nothing was installed.")
        has_removals = any(line.startswith("Remv ") for line in simulation.stdout.splitlines())
        if has_removals:
            raise RuntimeError(
                "APT proposes removing installed packages. Refusing this plan automatically; "
                "nothing was installed. Review the APT output and resolve the conflict first."
            )
        if args.dry_run:
            print("\nDry run complete. Nothing was installed.")
            return 0
        if not args.yes and not confirm("\nProceed with this APT plan? [y/N] "):
            print("Cancelled. Nothing was installed.")
            return 0

        install_command = [
            *elevate, "apt-get", "-y", "install", "--no-install-recommends",
            *[str(p) for p in paths]
        ]
        result = subprocess.run(install_command, check=False)
        if result.returncode != 0:
            raise RuntimeError("APT installation failed; check its output above.")
        print("\nInstallation completed.")
        return 0

if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, urllib.error.URLError, json.JSONDecodeError, subprocess.SubprocessError, RuntimeError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
