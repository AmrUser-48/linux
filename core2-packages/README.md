# Debian Bookworm packages optimized for Intel Core 2

This directory documents the opt-in GitHub Actions workflows for rebuilding selected Debian Bookworm source packages with native Core 2 compiler targets.

## Start a build

In GitHub, open **Actions → Core 2 optimized Debian package train → Run workflow**. Select a series:

- all: Bash, Zsh, Nano, Neovim, LAME, zstd, xz-utils, 7-Zip, FFmpeg, mpv, curl, then Mesa.
- shell-editors: Bash, Zsh, Nano and Neovim.
- media: LAME, zstd, xz-utils, 7-Zip, FFmpeg, mpv and curl.
- graphics: Mesa only.

Each target runs as a separate workflow, and the train waits for its release to finish before dispatching the next target. If a build fails, the train stops there. To rebuild just one package, start **Core 2 optimized Debian package** and select it directly.

## Build policy

The workflow fetches official Debian Bookworm and Bookworm-security source packages, retains Debian's packaging and patches, and appends a unique +core2.1~timestamp revision so each serial build can upgrade the previous custom package. It uses -O2 -march=core2 -mtune=core2 for Mesa, Bash, Zsh, Nano, Neovim and curl; the media/compression batch (LAME, FFmpeg, mpv, 7-Zip, zstd and xz-utils) uses -O3 -march=core2 -mtune=core2. Debian's package-specific hardening flags are retained. The build verifies that the selected optimization and Core 2 flags reached dpkg-buildflags. Binary packages and their checksums are published in a package-specific GitHub Release.

The artifacts target Intel Core 2-class systems (such as the D630 CPUs) and are not intended as generic amd64 replacements. They use Debian's standard ABI, but compiler-generated instructions can require Core 2 or a later CPU. Keep the stock Debian packages available for rollback.

Mesa is the highest-risk target because it supplies graphics libraries and driver modules used by the desktop. Its release may contain multiple runtime and development .deb packages. Inspect the package list, install only the related runtime packages required by this machine, keep a known-working kernel/Mesa combination as fallback, and test the GMA X3100 driver locally. CI compilation alone does not prove hardware rendering works.

## Brave Browser

Brave is intentionally not in the normal Debian-source train. It is not a standard Bookworm source-package rebuild; Brave's Linux build uses a Chromium-sized checkout. Upstream's current instructions recommend more than 16 GB RAM and expect about 100 GB of free disk for Chromium. That does not fit the standard GitHub-hosted runner reliably. Treat Brave as a separate project requiring a larger or self-hosted runner, and test it as a separate browser install rather than replacing the held vendor package automatically.
