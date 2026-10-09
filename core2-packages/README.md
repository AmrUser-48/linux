# Debian Bookworm packages optimized for Intel Core 2

This directory documents the opt-in GitHub Actions workflows for rebuilding selected Debian Bookworm source packages with native Core 2 compiler targets.

## Start a build

In GitHub, open **Actions → Core 2 optimized Debian package train → Run workflow**. Select a series:

- all: LAME first as the known performance benchmark, then Bash, Zsh, Nano, Neovim, zstd, xz-utils, 7-Zip, FFmpeg, mpv, curl, and Mesa last.
- shell-editors: Bash, Zsh, Nano and Neovim.
- media: LAME, zstd, xz-utils, 7-Zip, FFmpeg, mpv and curl.
- graphics: Mesa only.

Each target runs as a separate workflow, and the train waits for its release to finish before dispatching the next target. If a build fails, the train stops there. To rebuild just one package, start **Core 2 optimized Debian package** and select it directly.

## Build policy

The workflow fetches official Debian Bookworm and Bookworm-security source packages, retains Debian's packaging and patches, and appends a unique +core2.1~timestamp revision so each serial build can upgrade the previous custom package. It uses -O2 -march=core2 -mtune=core2 for Mesa, Bash, Zsh, Nano, Neovim and curl; the media/compression batch (LAME, FFmpeg, mpv, 7-Zip, zstd and xz-utils) uses -O3 -march=core2 -mtune=core2. Debian's package-specific hardening flags are retained. The build verifies that the selected optimization and Core 2 flags reached dpkg-buildflags. Binary packages and their checksums are published in a package-specific GitHub Release.

The artifacts target Intel Core 2-class systems (such as the D630 CPUs) and are not intended as generic amd64 replacements. They use Debian's standard ABI, but compiler-generated instructions can require Core 2 or a later CPU. Keep the stock Debian packages available for rollback.

Mesa is the highest-risk target because it supplies graphics libraries and driver modules used by the desktop. Its release may contain multiple runtime and development .deb packages. Inspect the package list, install only the related runtime packages required by this machine, keep a known-working kernel/Mesa combination as fallback, and test the GMA X3100 driver locally. CI compilation alone does not prove hardware rendering works.


## Core system packages (manual, higher risk)

For Debian core utilities, libraries and boot/runtime components, open [**Core 2 optimized Debian system package**](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-package.yml) and choose one source package per run. The menu includes:

- Runtime and toolchain foundations: `glibc` (produces packages including `libc6` and `libc-bin`), `gcc-12`, `binutils`, `dpkg`, `apt`.
- Init, shell and system tools: `systemd`, `bash`, `dash`, `coreutils`, `util-linux`, `iproute2`, `kmod`, `procps`, `e2fsprogs`, `psmisc`, `shadow`, `pam`.
- Core libraries and compression: `openssl`, `zlib`, `libxcrypt`, `ncurses`, `readline`, `libcap2`, `libselinux`, `libseccomp`, `acl`, `attr`, `pcre2`, `gmp`, `mpfr4`, `libffi`, `expat`, `libtirpc`.
- Basic text/file utilities: `findutils`, `grep`, `sed`, `gawk`, `diffutils`, `tar`, `gzip`, `bzip2`, `xz-utils`, `zstd`.

This workflow uses the conservative `-O2 -march=core2 -mtune=core2` profile for all listed packages. GCC and glibc builds are particularly large and may run for hours; the workflow timeout is six hours. Each successful build publishes its binary packages, build metadata and SHA-256 sums in a separate `core2-system-*` GitHub Release. Compilation is not the same as runtime validation.

**Critical warning:** do not install every generated `.deb` blindly. A glibc build may publish multiple runtime, locale, development, debug and multiarch packages. Inspect the asset list and dependencies first. Replacing `libc6` or `systemd` can make the installed system unusable; do this only with a verified backup, known-good kernel, and a tested rescue/rollback path. Keep the stock Debian packages and recovery media available. These builds target the D630 / Intel Core 2 system, not generic amd64 computers.

## Brave Browser

Brave is intentionally not in the normal Debian-source train. It is not a standard Bookworm source-package rebuild; Brave's Linux build uses a Chromium-sized checkout. Upstream's current instructions recommend more than 16 GB RAM and expect about 100 GB of free disk for Chromium. That does not fit the standard GitHub-hosted runner reliably. Treat Brave as a separate project requiring a larger or self-hosted runner, and test it as a separate browser install rather than replacing the held vendor package automatically.
