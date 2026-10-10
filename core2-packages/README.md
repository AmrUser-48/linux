# Debian Bookworm packages optimized for Intel Core 2

This repository publishes Debian Bookworm binary packages rebuilt for Intel Core 2 CPUs, targeting systems such as the Dell Latitude D630. They are not generic amd64 replacements.

## Published packages

**[Browse all Core 2 packages on GitHub Releases →](https://github.com/AmrUser-48/linux/releases)**

The Releases page is the live package list, newest first. Open a release to download its `.deb` files, checksums, build information, and release notes. This direct link does not open GitHub Actions or require a generated index.

## Build packages

The [Core 2 optimized package workflow](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-package.yml) accepts any valid Debian Bookworm source-package name.

The [Core 2 system package workflow](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-package.yml) accepts a source-package name and uses the conservative `-O2 -march=core2 -mtune=core2` profile.

To rebuild a source package from the latest Bookworm source and replace its previous releases after the new build succeeds, use the [Core 2 package updater](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-update-package.yml). Select `optimized` or `system` and enter the source-package name. If the build fails, existing releases are left untouched.

## Smart install/update

The optional [installer script](install.py) chooses a package release, checks installed Debian package names, architectures and versions, and prepares an APT plan.

It updates matching binary packages only when the same package and architecture is already installed. It may add the primary runtime package when that package is missing, but it does not pull in absent `-dev`, `-doc`, `-source`, dbgsym, i386/x32 or other split packages just because they are attached to a release. APT resolves dependencies using your configured Debian repositories.

The script distinguishes the `optimized` and `system` release families. Use `--kind optimized`, `--kind system`, or `--kind any` to choose the family. It verifies published SHA-256 hashes, shows an APT simulation, asks before installing, and refuses plans in which APT proposes removing packages. It targets Debian Bookworm amd64.

Example:

```sh
curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - kmod --kind system
```

Add `--dry-run` after the package name and family to preview without installing. To list available package keys:

```sh
curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - --list --kind optimized
curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - --list --kind system
```
