# Debian 12 packages for Intel Core 2

This repository builds Debian Bookworm packages optimized for Intel Core 2 CPUs (`-march=core2 -mtune=core2`). The packages target systems such as the Dell Latitude D630 and are not generic amd64 replacements.

## Published package downloads — newest first

Direct links to installable `.deb` packages, checksums, and build metadata. New builds exclude debug-symbol binaries and do not publish Debian source archives; historical releases may still contain older assets.

The full date-sorted index is maintained in [`core2-packages/README.md`](core2-packages/README.md), including direct links to each release asset. The root README will not duplicate the full list until the refresh workflow is updated to write both files.

## Build or refresh

- [Build any Core 2 optimized Debian package](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-package.yml)
- [Build any Core 2 system package](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-package.yml)
- [Update a package and replace older releases](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-update-package.yml)
- [Run the Core 2 Debian package train](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-packages-series.yml)
- [Run the Core 2 system package train](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-packages-series.yml)
- [Refresh the package release index](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-update-release-index.yml)

The [detailed package documentation and full release index](core2-packages/README.md) includes per-package smart install commands that select only relevant binary packages already installed (plus a primary runtime package when missing), as well as build policy and safety notes.
