# Debian Bookworm packages optimized for Intel Core 2

## Published packages

**[Browse all Core 2 packages on GitHub Releases →](https://github.com/AmrUser-48/linux/releases)**

The Releases page is the package list, newest first. Open a release to download its `.deb` files, checksums, build information, and release notes. There is no generated package index or separate index-refresh Actions run.

## Smart install/update

The optional installer selects a release by package name, checks installed Debian package names, architectures and versions, then prepares an APT plan.

It updates binary packages from that release **only when the same package and architecture is already installed**. It may add the primary runtime package if that package is not installed; it does not install extra `-dev`, `-doc`, `-source`, dbgsym, i386/x32 or other split packages merely because they are attached to the release. For example, selecting `glibc` updates installed `libc6` and other matching installed components, but will not add `libc6-dev`, `libc6-x32` or `libc6-i386` if they are absent.

The releases list identifies the family in each title (`Core 2 optimized` or `Core 2 system`). Use `--kind optimized` or `--kind system` to choose a specific family. `--kind any` selects the newest release for that package across both families.

Example, to install/update `kmod` from the system release:

```sh
curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - kmod --kind system
```

The script verifies SHA-256 hashes when the release publishes them, shows an APT simulation, and asks before installing. It refuses plans in which APT proposes removing packages. APT resolves dependencies using your configured Debian repositories. This installer is for Debian Bookworm amd64.

To preview instead of installing, add `--dry-run` after the package key and `--kind` value. To list package keys, optionally limited to a release family:

```sh
curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - --list --kind optimized
curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - --list --kind system
```

Installer source: [`install.py`](install.py).
