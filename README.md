# Debian 12 packages for Intel Core 2

This repository builds Debian Bookworm packages optimized for Intel Core 2 CPUs (`-march=core2 -mtune=core2`). The packages target systems such as the Dell Latitude D630 and are not generic amd64 replacements.

## Package downloads — newest first

The complete, date-sorted package list includes direct links to installable `.deb` files, checksums, build metadata, and Debian source archives where available:

**[Browse all Core 2 package releases and direct downloads](core2-packages/README.md)**

Latest releases are published individually on GitHub. Open the release index for the newest builds and all available assets. Development and debug packages are excluded from publication.

## Build or refresh

- [Run the Core 2 Debian package train](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-packages-series.yml)
- [Run the Core 2 system package train](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-packages-series.yml)
- [Refresh the package release index](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-update-release-index.yml)

The detailed build policy, package selection, safety notes, and full release index are in [`core2-packages/README.md`](core2-packages/README.md).
