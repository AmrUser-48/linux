# Debian Bookworm packages optimized for Intel Core 2

This directory documents the opt-in GitHub Actions workflows for rebuilding Debian Bookworm source packages with native Core 2 compiler targets.

## Build any package by source name

The [Core 2 optimized Debian package workflow](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-package.yml) accepts a free-text Debian source-package name; it is no longer limited to a YAML dropdown list. Enter any valid source package available from the configured Debian Bookworm source repositories, such as `python3.11`, `thunar`, or another package name. The workflow resolves build dependencies, builds binary packages for amd64/all, and skips publication when that package already has a Core 2 release.

The [Core 2 optimized Debian system package workflow](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-package.yml) also accepts a free-text source-package name and uses the conservative `-O2 -march=core2 -mtune=core2` profile. The package-train workflows remain predefined sequential sets.

## Smart install/update

Each package entry below includes a one-line install command. It downloads the latest release for that package, checks installed Debian package names, architectures and versions, then prepares an APT plan.

The installer updates binary packages from that release **only when the same package and architecture is already installed**. It may add the primary runtime package if that package is not installed; it does not install extra `-dev`, `-doc`, `-source`, dbgsym, i386/x32 or other split packages merely because they are attached to the release. For example, selecting `glibc` updates installed `libc6` and other matching installed components, but will not add `libc6-dev`, `libc6-x32` or `libc6-i386` if they are absent.

The script verifies SHA-256 hashes where the release publishes them, shows an APT simulation, and asks before installing. It refuses plans in which APT proposes removing packages. APT resolves dependencies using your configured Debian repositories. This installer is for Debian Bookworm amd64.

Run the command shown under a package heading to install/update that package. To preview instead of installing, add `--dry-run` after the package key. To list package keys supported by the current releases:

```sh
curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - --list
```

Installer source: [`install.py`](install.py).

## Published package downloads (newest first)

The index below is refreshed automatically after each successful Core 2 package release. It lists installable `.deb` files, build metadata, checksums, and release notes inside collapsed file lists. New builds exclude `-dbg`/`-dbgsym` binaries and do not publish source archives; the index also hides those assets from historical releases.

<!-- CORE2-PACKAGE-RELEASE-INDEX:START -->
### glibc
Version: `2.36-9+deb12u14+core2.1~20261010052854` · Published: 2026-10-10 05:56:13 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - glibc`

<details><summary>Files (18)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/BUILD-INFO.txt)
- [glibc-doc_2.36-9+deb12u14+core2.1.20261010052854_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/glibc-doc_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_all.deb)
- [glibc-source_2.36-9+deb12u14+core2.1.20261010052854_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/glibc-source_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_all.deb)
- [libc-bin_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc-bin_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc-dev-bin_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc-dev-bin_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc-devtools_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc-devtools_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc-l10n_2.36-9+deb12u14+core2.1.20261010052854_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc-l10n_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_all.deb)
- [libc6_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc6-dev_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6-dev_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc6-dev-i386_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6-dev-i386_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc6-dev-x32_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6-dev-x32_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc6-i386_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6-i386_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc6-x32_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6-x32_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [locales_2.36-9+deb12u14+core2.1.20261010052854_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/locales_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_all.deb)
- [locales-all_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/locales-all_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [nscd_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/nscd_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/release-notes.md)
- [SHA256SUMS-core2-glibc.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/SHA256SUMS-core2-glibc.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854)

</details>

### thunar
Version: `4.18.4-1+core2.1~20261010054751` · Published: 2026-10-10 05:50:00 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - thunar`

<details><summary>Files (8)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/BUILD-INFO.txt)
- [gir1.2-thunarx-3.0_4.18.4-1+core2.1.20261010054751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/gir1.2-thunarx-3.0_4.18.4-1%2Bcore2.1.20261010054751_amd64.deb)
- [libthunarx-3-0_4.18.4-1+core2.1.20261010054751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/libthunarx-3-0_4.18.4-1%2Bcore2.1.20261010054751_amd64.deb)
- [libthunarx-3-dev_4.18.4-1+core2.1.20261010054751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/libthunarx-3-dev_4.18.4-1%2Bcore2.1.20261010054751_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/release-notes.md)
- [SHA256SUMS-core2-thunar.txt](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/SHA256SUMS-core2-thunar.txt)
- [thunar_4.18.4-1+core2.1.20261010054751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/thunar_4.18.4-1%2Bcore2.1.20261010054751_amd64.deb)
- [thunar-data_4.18.4-1+core2.1.20261010054751_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/thunar-data_4.18.4-1%2Bcore2.1.20261010054751_all.deb)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-thunar-4.18.4-1-core2.1-20261010054751)

</details>

### tumbler
Version: `4.18.0-1+core2.1~20261010054511` · Published: 2026-10-10 05:46:25 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - tumbler`

<details><summary>Files (8)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/BUILD-INFO.txt)
- [libtumbler-1-0_4.18.0-1+core2.1.20261010054511_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/libtumbler-1-0_4.18.0-1%2Bcore2.1.20261010054511_amd64.deb)
- [libtumbler-1-dev_4.18.0-1+core2.1.20261010054511_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/libtumbler-1-dev_4.18.0-1%2Bcore2.1.20261010054511_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/release-notes.md)
- [SHA256SUMS-core2-tumbler.txt](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/SHA256SUMS-core2-tumbler.txt)
- [tumbler_4.18.0-1+core2.1.20261010054511_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/tumbler_4.18.0-1%2Bcore2.1.20261010054511_amd64.deb)
- [tumbler-common_4.18.0-1+core2.1.20261010054511_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/tumbler-common_4.18.0-1%2Bcore2.1.20261010054511_all.deb)
- [tumbler-plugins-extra_4.18.0-1+core2.1.20261010054511_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/tumbler-plugins-extra_4.18.0-1%2Bcore2.1.20261010054511_amd64.deb)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-tumbler-4.18.0-1-core2.1-20261010054511)

</details>

### garcon
Version: `4.18.0-1+core2.1~20261010054213` · Published: 2026-10-10 05:43:19 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - garcon`

<details><summary>Files (11)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/BUILD-INFO.txt)
- [gir1.2-garcon-1.0_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/gir1.2-garcon-1.0_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [gir1.2-garcongtk-1.0_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/gir1.2-garcongtk-1.0_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [libgarcon-1-0_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-1-0_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [libgarcon-1-0-dev_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-1-0-dev_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [libgarcon-1-dev_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-1-dev_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [libgarcon-common_4.18.0-1+core2.1.20261010054213_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-common_4.18.0-1%2Bcore2.1.20261010054213_all.deb)
- [libgarcon-gtk3-1-0_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-gtk3-1-0_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [libgarcon-gtk3-1-dev_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-gtk3-1-dev_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/release-notes.md)
- [SHA256SUMS-core2-garcon.txt](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/SHA256SUMS-core2-garcon.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-garcon-4.18.0-1-core2.1-20261010054213)

</details>

### exo
Version: `4.18.0-1+core2.1~20261010053936` · Published: 2026-10-10 05:40:53 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - exo`

<details><summary>Files (7)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-exo-4.18.0-1-core2.1-20261010053936/BUILD-INFO.txt)
- [exo-utils_4.18.0-1+core2.1.20261010053936_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-exo-4.18.0-1-core2.1-20261010053936/exo-utils_4.18.0-1%2Bcore2.1.20261010053936_amd64.deb)
- [libexo-2-0_4.18.0-1+core2.1.20261010053936_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-exo-4.18.0-1-core2.1-20261010053936/libexo-2-0_4.18.0-1%2Bcore2.1.20261010053936_amd64.deb)
- [libexo-2-dev_4.18.0-1+core2.1.20261010053936_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-exo-4.18.0-1-core2.1-20261010053936/libexo-2-dev_4.18.0-1%2Bcore2.1.20261010053936_amd64.deb)
- [libexo-common_4.18.0-1+core2.1.20261010053936_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-exo-4.18.0-1-core2.1-20261010053936/libexo-common_4.18.0-1%2Bcore2.1.20261010053936_all.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-exo-4.18.0-1-core2.1-20261010053936/release-notes.md)
- [SHA256SUMS-core2-exo.txt](https://github.com/AmrUser-48/linux/releases/download/core2-exo-4.18.0-1-core2.1-20261010053936/SHA256SUMS-core2-exo.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-exo-4.18.0-1-core2.1-20261010053936)

</details>

### libxfce4ui
Version: `4.18.2-2+core2.1~20261010053651` · Published: 2026-10-10 05:38:11 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxfce4ui`

<details><summary>Files (9)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/BUILD-INFO.txt)
- [gir1.2-libxfce4ui-2.0_4.18.2-2+core2.1.20261010053651_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/gir1.2-libxfce4ui-2.0_4.18.2-2%2Bcore2.1.20261010053651_amd64.deb)
- [libxfce4ui-2-0_4.18.2-2+core2.1.20261010053651_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/libxfce4ui-2-0_4.18.2-2%2Bcore2.1.20261010053651_amd64.deb)
- [libxfce4ui-2-dev_4.18.2-2+core2.1.20261010053651_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/libxfce4ui-2-dev_4.18.2-2%2Bcore2.1.20261010053651_amd64.deb)
- [libxfce4ui-common_4.18.2-2+core2.1.20261010053651_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/libxfce4ui-common_4.18.2-2%2Bcore2.1.20261010053651_all.deb)
- [libxfce4ui-glade_4.18.2-2+core2.1.20261010053651_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/libxfce4ui-glade_4.18.2-2%2Bcore2.1.20261010053651_amd64.deb)
- [libxfce4ui-utils_4.18.2-2+core2.1.20261010053651_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/libxfce4ui-utils_4.18.2-2%2Bcore2.1.20261010053651_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/release-notes.md)
- [SHA256SUMS-core2-libxfce4ui.txt](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/SHA256SUMS-core2-libxfce4ui.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651)

</details>

### xfconf
Version: `4.18.0-2+core2.1~20261010053410` · Published: 2026-10-10 05:35:14 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xfconf`

<details><summary>Files (7)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-xfconf-4.18.0-2-core2.1-20261010053410/BUILD-INFO.txt)
- [gir1.2-xfconf-0_4.18.0-2+core2.1.20261010053410_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xfconf-4.18.0-2-core2.1-20261010053410/gir1.2-xfconf-0_4.18.0-2%2Bcore2.1.20261010053410_amd64.deb)
- [libxfconf-0-3_4.18.0-2+core2.1.20261010053410_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xfconf-4.18.0-2-core2.1-20261010053410/libxfconf-0-3_4.18.0-2%2Bcore2.1.20261010053410_amd64.deb)
- [libxfconf-0-dev_4.18.0-2+core2.1.20261010053410_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xfconf-4.18.0-2-core2.1-20261010053410/libxfconf-0-dev_4.18.0-2%2Bcore2.1.20261010053410_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-xfconf-4.18.0-2-core2.1-20261010053410/release-notes.md)
- [SHA256SUMS-core2-xfconf.txt](https://github.com/AmrUser-48/linux/releases/download/core2-xfconf-4.18.0-2-core2.1-20261010053410/SHA256SUMS-core2-xfconf.txt)
- [xfconf_4.18.0-2+core2.1.20261010053410_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xfconf-4.18.0-2-core2.1-20261010053410/xfconf_4.18.0-2%2Bcore2.1.20261010053410_amd64.deb)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xfconf-4.18.0-2-core2.1-20261010053410)

</details>

### libxfce4util
Version: `4.18.1-2+core2.1~20261010053208` · Published: 2026-10-10 05:33:07 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxfce4util`

<details><summary>Files (8)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/BUILD-INFO.txt)
- [gir1.2-libxfce4util-1.0_4.18.1-2+core2.1.20261010053208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/gir1.2-libxfce4util-1.0_4.18.1-2%2Bcore2.1.20261010053208_amd64.deb)
- [libxfce4util-bin_4.18.1-2+core2.1.20261010053208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/libxfce4util-bin_4.18.1-2%2Bcore2.1.20261010053208_amd64.deb)
- [libxfce4util-common_4.18.1-2+core2.1.20261010053208_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/libxfce4util-common_4.18.1-2%2Bcore2.1.20261010053208_all.deb)
- [libxfce4util-dev_4.18.1-2+core2.1.20261010053208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/libxfce4util-dev_4.18.1-2%2Bcore2.1.20261010053208_amd64.deb)
- [libxfce4util7_4.18.1-2+core2.1.20261010053208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/libxfce4util7_4.18.1-2%2Bcore2.1.20261010053208_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/release-notes.md)
- [SHA256SUMS-core2-libxfce4util.txt](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/SHA256SUMS-core2-libxfce4util.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4util-4.18.1-2-core2.1-20261010053208)

</details>

### glibc
Version: `2.36-9+deb12u14+core2.1~20261010025123` · Published: 2026-10-10 03:17:08 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - glibc`

<details><summary>Files (17)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/BUILD-INFO.txt)
- [glibc-doc_2.36-9+deb12u14+core2.1.20261010025123_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/glibc-doc_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_all.deb)
- [glibc-source_2.36-9+deb12u14+core2.1.20261010025123_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/glibc-source_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_all.deb)
- [libc-bin_2.36-9+deb12u14+core2.1.20261010025123_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/libc-bin_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_amd64.deb)
- [libc-dev-bin_2.36-9+deb12u14+core2.1.20261010025123_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/libc-dev-bin_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_amd64.deb)
- [libc-devtools_2.36-9+deb12u14+core2.1.20261010025123_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/libc-devtools_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_amd64.deb)
- [libc-l10n_2.36-9+deb12u14+core2.1.20261010025123_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/libc-l10n_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_all.deb)
- [libc6_2.36-9+deb12u14+core2.1.20261010025123_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/libc6_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_amd64.deb)
- [libc6-dev-i386_2.36-9+deb12u14+core2.1.20261010025123_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/libc6-dev-i386_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_amd64.deb)
- [libc6-dev-x32_2.36-9+deb12u14+core2.1.20261010025123_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/libc6-dev-x32_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_amd64.deb)
- [libc6-i386_2.36-9+deb12u14+core2.1.20261010025123_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/libc6-i386_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_amd64.deb)
- [libc6-x32_2.36-9+deb12u14+core2.1.20261010025123_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/libc6-x32_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_amd64.deb)
- [locales_2.36-9+deb12u14+core2.1.20261010025123_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/locales_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_all.deb)
- [locales-all_2.36-9+deb12u14+core2.1.20261010025123_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/locales-all_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_amd64.deb)
- [nscd_2.36-9+deb12u14+core2.1.20261010025123_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/nscd_2.36-9%2Bdeb12u14%2Bcore2.1.20261010025123_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/release-notes.md)
- [SHA256SUMS-core2-glibc.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123/SHA256SUMS-core2-glibc.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010025123)

</details>

### systemd
Version: `252.39-1~deb12u2+core2.1~20261010025144` · Published: 2026-10-10 02:59:56 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - systemd`

<details><summary>Files (27)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/BUILD-INFO.txt)
- [libnss-myhostname_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libnss-myhostname_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libnss-mymachines_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libnss-mymachines_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libnss-resolve_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libnss-resolve_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libnss-systemd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libnss-systemd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libpam-systemd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libpam-systemd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libsystemd-shared_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libsystemd-shared_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libsystemd0_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libsystemd0_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libudev1_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libudev1_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/release-notes.md)
- [SHA256SUMS-core2-systemd.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/SHA256SUMS-core2-systemd.txt)
- [systemd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-boot_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-boot_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-boot-efi_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-boot-efi_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-container_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-container_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-coredump_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-coredump_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-homed_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-homed_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-journal-remote_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-journal-remote_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-oomd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-oomd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-resolved_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-resolved_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-standalone-sysusers_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-standalone-sysusers_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-standalone-tmpfiles_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-standalone-tmpfiles_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-sysv_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-sysv_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-tests_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-tests_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-timesyncd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-timesyncd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-userdbd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-userdbd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [udev_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/udev_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144)

</details>

### binutils
Version: `2.40-2+core2.1~20261009173258` · Published: 2026-10-09 20:39:48 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - binutils`

<details><summary>Files (36)</summary>

- [binutils_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-aarch64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-aarch64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-alpha-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-alpha-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-arc-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-arc-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-arm-linux-gnueabi_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-arm-linux-gnueabi_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-arm-linux-gnueabihf_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-arm-linux-gnueabihf_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-common_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-common_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-doc_2.40-2+core2.1.20261009173258_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-doc_2.40-2%2Bcore2.1.20261009173258_all.deb)
- [binutils-for-build_2.40-2+core2.1.20261009173258_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-for-build_2.40-2%2Bcore2.1.20261009173258_all.deb)
- [binutils-for-host_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-for-host_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-hppa-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-hppa-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-hppa64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-hppa64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-i686-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-i686-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-i686-kfreebsd-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-i686-kfreebsd-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-i686-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-i686-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-ia64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-ia64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-m68k-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-m68k-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-multiarch_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-multiarch_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-powerpc-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-powerpc-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-powerpc64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-powerpc64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-powerpc64le-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-powerpc64le-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-riscv64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-riscv64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-s390x-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-s390x-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-sh4-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-sh4-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-source_2.40-2+core2.1.20261009173258_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-source_2.40-2%2Bcore2.1.20261009173258_all.deb)
- [binutils-sparc64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-sparc64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-x86-64-kfreebsd-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-x86-64-kfreebsd-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-x86-64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-x86-64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-x86-64-linux-gnux32_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-x86-64-linux-gnux32_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/BUILD-INFO.txt)
- [libbinutils_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/libbinutils_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [libctf-nobfd0_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/libctf-nobfd0_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [libctf0_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/libctf0_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [libgprofng0_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/libgprofng0_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/release-notes.md)
- [SHA256SUMS-core2-binutils.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/SHA256SUMS-core2-binutils.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258)

</details>

### libtirpc
Version: `1.3.3+ds-1+core2.1~20261009195337` · Published: 2026-10-09 19:54:21 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libtirpc`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-libtirpc-1.3.3-ds-1-core2.1-20261009195337/BUILD-INFO.txt)
- [libtirpc-common_1.3.3+ds-1+core2.1.20261009195337_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libtirpc-1.3.3-ds-1-core2.1-20261009195337/libtirpc-common_1.3.3%2Bds-1%2Bcore2.1.20261009195337_all.deb)
- [libtirpc3_1.3.3+ds-1+core2.1.20261009195337_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libtirpc-1.3.3-ds-1-core2.1-20261009195337/libtirpc3_1.3.3%2Bds-1%2Bcore2.1.20261009195337_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-libtirpc-1.3.3-ds-1-core2.1-20261009195337/release-notes.md)
- [SHA256SUMS-core2-libtirpc.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-libtirpc-1.3.3-ds-1-core2.1-20261009195337/SHA256SUMS-core2-libtirpc.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libtirpc-1.3.3-ds-1-core2.1-20261009195337)

</details>

### expat
Version: `2.5.0-1+deb12u4+core2.1~20261009195158` · Published: 2026-10-09 19:52:39 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - expat`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-expat-2.5.0-1-deb12u4-core2.1-20261009195158/BUILD-INFO.txt)
- [expat_2.5.0-1+deb12u4+core2.1.20261009195158_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-expat-2.5.0-1-deb12u4-core2.1-20261009195158/expat_2.5.0-1%2Bdeb12u4%2Bcore2.1.20261009195158_amd64.deb)
- [libexpat1_2.5.0-1+deb12u4+core2.1.20261009195158_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-expat-2.5.0-1-deb12u4-core2.1-20261009195158/libexpat1_2.5.0-1%2Bdeb12u4%2Bcore2.1.20261009195158_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-expat-2.5.0-1-deb12u4-core2.1-20261009195158/release-notes.md)
- [SHA256SUMS-core2-expat.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-expat-2.5.0-1-deb12u4-core2.1-20261009195158/SHA256SUMS-core2-expat.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-expat-2.5.0-1-deb12u4-core2.1-20261009195158)

</details>

### libffi
Version: `3.4.4-1+core2.1~20261009194707` · Published: 2026-10-09 19:51:15 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libffi`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-libffi-3.4.4-1-core2.1-20261009194707/BUILD-INFO.txt)
- [libffi8_3.4.4-1+core2.1.20261009194707_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libffi-3.4.4-1-core2.1-20261009194707/libffi8_3.4.4-1%2Bcore2.1.20261009194707_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-libffi-3.4.4-1-core2.1-20261009194707/release-notes.md)
- [SHA256SUMS-core2-libffi.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-libffi-3.4.4-1-core2.1-20261009194707/SHA256SUMS-core2-libffi.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libffi-3.4.4-1-core2.1-20261009194707)

</details>

### gmp
Version: `2:6.2.1+dfsg1-1.1+core2.1~20261009194412` · Published: 2026-10-09 19:46:09 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gmp`

<details><summary>Files (6)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412/BUILD-INFO.txt)
- [libgmp10_6.2.1+dfsg1-1.1+core2.1.20261009194412_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412/libgmp10_6.2.1%2Bdfsg1-1.1%2Bcore2.1.20261009194412_amd64.deb)
- [libgmp10-doc_6.2.1+dfsg1-1.1+core2.1.20261009194412_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412/libgmp10-doc_6.2.1%2Bdfsg1-1.1%2Bcore2.1.20261009194412_all.deb)
- [libgmpxx4ldbl_6.2.1+dfsg1-1.1+core2.1.20261009194412_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412/libgmpxx4ldbl_6.2.1%2Bdfsg1-1.1%2Bcore2.1.20261009194412_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412/release-notes.md)
- [SHA256SUMS-core2-gmp.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412/SHA256SUMS-core2-gmp.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412)

</details>

### mpfr4
Version: `4.2.0-1+core2.1~20261009194039` · Published: 2026-10-09 19:43:32 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - mpfr4`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-mpfr4-4.2.0-1-core2.1-20261009194039/BUILD-INFO.txt)
- [libmpfr-doc_4.2.0-1+core2.1.20261009194039_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-mpfr4-4.2.0-1-core2.1-20261009194039/libmpfr-doc_4.2.0-1%2Bcore2.1.20261009194039_all.deb)
- [libmpfr6_4.2.0-1+core2.1.20261009194039_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-mpfr4-4.2.0-1-core2.1-20261009194039/libmpfr6_4.2.0-1%2Bcore2.1.20261009194039_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-mpfr4-4.2.0-1-core2.1-20261009194039/release-notes.md)
- [SHA256SUMS-core2-mpfr4.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-mpfr4-4.2.0-1-core2.1-20261009194039/SHA256SUMS-core2-mpfr4.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-mpfr4-4.2.0-1-core2.1-20261009194039)

</details>

### curl
Version: `7.88.1-10+deb12u15+core2.1~20261009190528` · Published: 2026-10-09 19:41:11 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - curl`

<details><summary>Files (8)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/BUILD-INFO.txt)
- [curl_7.88.1-10+deb12u15+core2.1.20261009190528_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/curl_7.88.1-10%2Bdeb12u15%2Bcore2.1.20261009190528_amd64.deb)
- [libcurl3-gnutls_7.88.1-10+deb12u15+core2.1.20261009190528_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/libcurl3-gnutls_7.88.1-10%2Bdeb12u15%2Bcore2.1.20261009190528_amd64.deb)
- [libcurl3-nss_7.88.1-10+deb12u15+core2.1.20261009190528_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/libcurl3-nss_7.88.1-10%2Bdeb12u15%2Bcore2.1.20261009190528_amd64.deb)
- [libcurl4_7.88.1-10+deb12u15+core2.1.20261009190528_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/libcurl4_7.88.1-10%2Bdeb12u15%2Bcore2.1.20261009190528_amd64.deb)
- [libcurl4-doc_7.88.1-10+deb12u15+core2.1.20261009190528_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/libcurl4-doc_7.88.1-10%2Bdeb12u15%2Bcore2.1.20261009190528_all.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/release-notes.md)
- [SHA256SUMS-core2-curl.txt](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/SHA256SUMS-core2-curl.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528)

</details>

### xz-utils
Version: `5.4.1-1+deb12u2+core2.1~20261009193709` · Published: 2026-10-09 19:38:34 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xz-utils`

<details><summary>Files (7)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709/BUILD-INFO.txt)
- [liblzma-doc_5.4.1-1+deb12u2+core2.1.20261009193709_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709/liblzma-doc_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009193709_all.deb)
- [liblzma5_5.4.1-1+deb12u2+core2.1.20261009193709_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709/liblzma5_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009193709_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709/release-notes.md)
- [SHA256SUMS-core2-xz-utils.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709/SHA256SUMS-core2-xz-utils.txt)
- [xz-utils_5.4.1-1+deb12u2+core2.1.20261009193709_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709/xz-utils_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009193709_amd64.deb)
- [xzdec_5.4.1-1+deb12u2+core2.1.20261009193709_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709/xzdec_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009193709_amd64.deb)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709)

</details>

### kmod
Version: `30+20221128-1+core2.1~20261009193535` · Published: 2026-10-09 19:36:20 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - kmod`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-kmod-30-20221128-1-core2.1-20261009193535/BUILD-INFO.txt)
- [kmod_30+20221128-1+core2.1.20261009193535_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-kmod-30-20221128-1-core2.1-20261009193535/kmod_30%2B20221128-1%2Bcore2.1.20261009193535_amd64.deb)
- [libkmod2_30+20221128-1+core2.1.20261009193535_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-kmod-30-20221128-1-core2.1-20261009193535/libkmod2_30%2B20221128-1%2Bcore2.1.20261009193535_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-kmod-30-20221128-1-core2.1-20261009193535/release-notes.md)
- [SHA256SUMS-core2-kmod.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-kmod-30-20221128-1-core2.1-20261009193535/SHA256SUMS-core2-kmod.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-kmod-30-20221128-1-core2.1-20261009193535)

</details>

### iproute2
Version: `6.1.0-3+core2.1~20261009193351` · Published: 2026-10-09 19:34:38 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - iproute2`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-iproute2-6.1.0-3-core2.1-20261009193351/BUILD-INFO.txt)
- [iproute2_6.1.0-3+core2.1.20261009193351_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-iproute2-6.1.0-3-core2.1-20261009193351/iproute2_6.1.0-3%2Bcore2.1.20261009193351_amd64.deb)
- [iproute2-doc_6.1.0-3+core2.1.20261009193351_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-iproute2-6.1.0-3-core2.1-20261009193351/iproute2-doc_6.1.0-3%2Bcore2.1.20261009193351_all.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-iproute2-6.1.0-3-core2.1-20261009193351/release-notes.md)
- [SHA256SUMS-core2-iproute2.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-iproute2-6.1.0-3-core2.1-20261009193351/SHA256SUMS-core2-iproute2.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-iproute2-6.1.0-3-core2.1-20261009193351)

</details>

### pam
Version: `1.5.2-6+deb12u2+core2.1~20261009193111` · Published: 2026-10-09 19:32:56 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - pam`

<details><summary>Files (8)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/BUILD-INFO.txt)
- [libpam-doc_1.5.2-6+deb12u2+core2.1.20261009193111_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/libpam-doc_1.5.2-6%2Bdeb12u2%2Bcore2.1.20261009193111_all.deb)
- [libpam-modules_1.5.2-6+deb12u2+core2.1.20261009193111_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/libpam-modules_1.5.2-6%2Bdeb12u2%2Bcore2.1.20261009193111_amd64.deb)
- [libpam-modules-bin_1.5.2-6+deb12u2+core2.1.20261009193111_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/libpam-modules-bin_1.5.2-6%2Bdeb12u2%2Bcore2.1.20261009193111_amd64.deb)
- [libpam-runtime_1.5.2-6+deb12u2+core2.1.20261009193111_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/libpam-runtime_1.5.2-6%2Bdeb12u2%2Bcore2.1.20261009193111_all.deb)
- [libpam0g_1.5.2-6+deb12u2+core2.1.20261009193111_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/libpam0g_1.5.2-6%2Bdeb12u2%2Bcore2.1.20261009193111_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/release-notes.md)
- [SHA256SUMS-core2-pam.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/SHA256SUMS-core2-pam.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111)

</details>

### shadow
Version: `1:4.13+dfsg1-1+deb12u2+core2.1~20261009192822` · Published: 2026-10-09 19:30:23 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - shadow`

<details><summary>Files (7)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822/BUILD-INFO.txt)
- [libsubid4_4.13+dfsg1-1+deb12u2+core2.1.20261009192822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822/libsubid4_4.13%2Bdfsg1-1%2Bdeb12u2%2Bcore2.1.20261009192822_amd64.deb)
- [login_4.13+dfsg1-1+deb12u2+core2.1.20261009192822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822/login_4.13%2Bdfsg1-1%2Bdeb12u2%2Bcore2.1.20261009192822_amd64.deb)
- [passwd_4.13+dfsg1-1+deb12u2+core2.1.20261009192822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822/passwd_4.13%2Bdfsg1-1%2Bdeb12u2%2Bcore2.1.20261009192822_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822/release-notes.md)
- [SHA256SUMS-core2-shadow.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822/SHA256SUMS-core2-shadow.txt)
- [uidmap_4.13+dfsg1-1+deb12u2+core2.1.20261009192822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822/uidmap_4.13%2Bdfsg1-1%2Bdeb12u2%2Bcore2.1.20261009192822_amd64.deb)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822)

</details>

### psmisc
Version: `23.6-1+core2.1~20261009192718` · Published: 2026-10-09 19:27:48 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - psmisc`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-psmisc-23.6-1-core2.1-20261009192718/BUILD-INFO.txt)
- [psmisc_23.6-1+core2.1.20261009192718_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-psmisc-23.6-1-core2.1-20261009192718/psmisc_23.6-1%2Bcore2.1.20261009192718_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-psmisc-23.6-1-core2.1-20261009192718/release-notes.md)
- [SHA256SUMS-core2-psmisc.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-psmisc-23.6-1-core2.1-20261009192718/SHA256SUMS-core2-psmisc.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-psmisc-23.6-1-core2.1-20261009192718)

</details>

### e2fsprogs
Version: `1.47.0-2+core2.1~20261009192320` · Published: 2026-10-09 19:26:35 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - e2fsprogs`

<details><summary>Files (11)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/BUILD-INFO.txt)
- [e2fsck-static_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/e2fsck-static_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [e2fsprogs_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/e2fsprogs_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [e2fsprogs-l10n_1.47.0-2+core2.1.20261009192320_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/e2fsprogs-l10n_1.47.0-2%2Bcore2.1.20261009192320_all.deb)
- [fuse2fs_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/fuse2fs_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [libcom-err2_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/libcom-err2_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [libext2fs2_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/libext2fs2_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [libss2_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/libss2_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [logsave_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/logsave_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/release-notes.md)
- [SHA256SUMS-core2-e2fsprogs.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/SHA256SUMS-core2-e2fsprogs.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320)

</details>

### bzip2
Version: `1.0.8-5+core2.1~20261009192040` · Published: 2026-10-09 19:21:05 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - bzip2`

<details><summary>Files (6)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-bzip2-1.0.8-5-core2.1-20261009192040/BUILD-INFO.txt)
- [bzip2_1.0.8-5+core2.1.20261009192040_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-bzip2-1.0.8-5-core2.1-20261009192040/bzip2_1.0.8-5%2Bcore2.1.20261009192040_amd64.deb)
- [bzip2-doc_1.0.8-5+core2.1.20261009192040_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-bzip2-1.0.8-5-core2.1-20261009192040/bzip2-doc_1.0.8-5%2Bcore2.1.20261009192040_all.deb)
- [libbz2-1.0_1.0.8-5+core2.1.20261009192040_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-bzip2-1.0.8-5-core2.1-20261009192040/libbz2-1.0_1.0.8-5%2Bcore2.1.20261009192040_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-bzip2-1.0.8-5-core2.1-20261009192040/release-notes.md)
- [SHA256SUMS-core2-bzip2.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-bzip2-1.0.8-5-core2.1-20261009192040/SHA256SUMS-core2-bzip2.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-bzip2-1.0.8-5-core2.1-20261009192040)

</details>

### gzip
Version: `1.12-1+core2.1~20261009191817` · Published: 2026-10-09 19:19:50 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gzip`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-gzip-1.12-1-core2.1-20261009191817/BUILD-INFO.txt)
- [gzip_1.12-1+core2.1.20261009191817_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gzip-1.12-1-core2.1-20261009191817/gzip_1.12-1%2Bcore2.1.20261009191817_amd64.deb)
- [gzip-win32_1.12-1+core2.1.20261009191817_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gzip-1.12-1-core2.1-20261009191817/gzip-win32_1.12-1%2Bcore2.1.20261009191817_all.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-gzip-1.12-1-core2.1-20261009191817/release-notes.md)
- [SHA256SUMS-core2-gzip.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-gzip-1.12-1-core2.1-20261009191817/SHA256SUMS-core2-gzip.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-gzip-1.12-1-core2.1-20261009191817)

</details>

### diffutils
Version: `1:3.8-4+core2.1~20261009191615` · Published: 2026-10-09 19:17:10 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - diffutils`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-diffutils-1-3.8-4-core2.1-20261009191615/BUILD-INFO.txt)
- [diffutils_3.8-4+core2.1.20261009191615_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-diffutils-1-3.8-4-core2.1-20261009191615/diffutils_3.8-4%2Bcore2.1.20261009191615_amd64.deb)
- [diffutils-doc_3.8-4+core2.1.20261009191615_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-diffutils-1-3.8-4-core2.1-20261009191615/diffutils-doc_3.8-4%2Bcore2.1.20261009191615_all.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-diffutils-1-3.8-4-core2.1-20261009191615/release-notes.md)
- [SHA256SUMS-core2-diffutils.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-diffutils-1-3.8-4-core2.1-20261009191615/SHA256SUMS-core2-diffutils.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-diffutils-1-3.8-4-core2.1-20261009191615)

</details>

### sed
Version: `4.9-1+deb12u1+core2.1~20261009191427` · Published: 2026-10-09 19:15:32 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - sed`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-sed-4.9-1-deb12u1-core2.1-20261009191427/BUILD-INFO.txt)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-sed-4.9-1-deb12u1-core2.1-20261009191427/release-notes.md)
- [sed_4.9-1+deb12u1+core2.1.20261009191427_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-sed-4.9-1-deb12u1-core2.1-20261009191427/sed_4.9-1%2Bdeb12u1%2Bcore2.1.20261009191427_amd64.deb)
- [SHA256SUMS-core2-sed.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-sed-4.9-1-deb12u1-core2.1-20261009191427/SHA256SUMS-core2-sed.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-sed-4.9-1-deb12u1-core2.1-20261009191427)

</details>

### grep
Version: `3.8-5+core2.1~20261009191150` · Published: 2026-10-09 19:13:45 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - grep`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-grep-3.8-5-core2.1-20261009191150/BUILD-INFO.txt)
- [grep_3.8-5+core2.1.20261009191150_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-grep-3.8-5-core2.1-20261009191150/grep_3.8-5%2Bcore2.1.20261009191150_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-grep-3.8-5-core2.1-20261009191150/release-notes.md)
- [SHA256SUMS-core2-grep.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-grep-3.8-5-core2.1-20261009191150/SHA256SUMS-core2-grep.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-grep-3.8-5-core2.1-20261009191150)

</details>

### attr
Version: `1:2.5.1-4+core2.1~20261009191027` · Published: 2026-10-09 19:10:56 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - attr`

<details><summary>Files (5)</summary>

- [attr_2.5.1-4+core2.1.20261009191027_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-attr-1-2.5.1-4-core2.1-20261009191027/attr_2.5.1-4%2Bcore2.1.20261009191027_amd64.deb)
- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-attr-1-2.5.1-4-core2.1-20261009191027/BUILD-INFO.txt)
- [libattr1_2.5.1-4+core2.1.20261009191027_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-attr-1-2.5.1-4-core2.1-20261009191027/libattr1_2.5.1-4%2Bcore2.1.20261009191027_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-attr-1-2.5.1-4-core2.1-20261009191027/release-notes.md)
- [SHA256SUMS-core2-attr.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-attr-1-2.5.1-4-core2.1-20261009191027/SHA256SUMS-core2-attr.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-attr-1-2.5.1-4-core2.1-20261009191027)

</details>

### acl
Version: `2.3.1-3+core2.1~20261009190907` · Published: 2026-10-09 19:09:41 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - acl`

<details><summary>Files (5)</summary>

- [acl_2.3.1-3+core2.1.20261009190907_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-acl-2.3.1-3-core2.1-20261009190907/acl_2.3.1-3%2Bcore2.1.20261009190907_amd64.deb)
- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-acl-2.3.1-3-core2.1-20261009190907/BUILD-INFO.txt)
- [libacl1_2.3.1-3+core2.1.20261009190907_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-acl-2.3.1-3-core2.1-20261009190907/libacl1_2.3.1-3%2Bcore2.1.20261009190907_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-acl-2.3.1-3-core2.1-20261009190907/release-notes.md)
- [SHA256SUMS-core2-acl.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-acl-2.3.1-3-core2.1-20261009190907/SHA256SUMS-core2-acl.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-acl-2.3.1-3-core2.1-20261009190907)

</details>

### libselinux
Version: `3.4-1+core2.1~20261009190433` · Published: 2026-10-09 19:05:10 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libselinux`

<details><summary>Files (7)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-libselinux-3.4-1-core2.1-20261009190433/BUILD-INFO.txt)
- [libselinux1_3.4-1+core2.1.20261009190433_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libselinux-3.4-1-core2.1-20261009190433/libselinux1_3.4-1%2Bcore2.1.20261009190433_amd64.deb)
- [python3-selinux_3.4-1+core2.1.20261009190433_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libselinux-3.4-1-core2.1-20261009190433/python3-selinux_3.4-1%2Bcore2.1.20261009190433_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-libselinux-3.4-1-core2.1-20261009190433/release-notes.md)
- [ruby-selinux_3.4-1+core2.1.20261009190433_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libselinux-3.4-1-core2.1-20261009190433/ruby-selinux_3.4-1%2Bcore2.1.20261009190433_amd64.deb)
- [selinux-utils_3.4-1+core2.1.20261009190433_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libselinux-3.4-1-core2.1-20261009190433/selinux-utils_3.4-1%2Bcore2.1.20261009190433_amd64.deb)
- [SHA256SUMS-core2-libselinux.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-libselinux-3.4-1-core2.1-20261009190433/SHA256SUMS-core2-libselinux.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libselinux-3.4-1-core2.1-20261009190433)

</details>

### mpv
Version: `0.35.1-4+core2.1~20261009190224` · Published: 2026-10-09 19:04:20 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - mpv`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-mpv-0.35.1-4-core2.1-20261009190224/BUILD-INFO.txt)
- [libmpv2_0.35.1-4+core2.1.20261009190224_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mpv-0.35.1-4-core2.1-20261009190224/libmpv2_0.35.1-4%2Bcore2.1.20261009190224_amd64.deb)
- [mpv_0.35.1-4+core2.1.20261009190224_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mpv-0.35.1-4-core2.1-20261009190224/mpv_0.35.1-4%2Bcore2.1.20261009190224_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-mpv-0.35.1-4-core2.1-20261009190224/release-notes.md)
- [SHA256SUMS-core2-mpv.txt](https://github.com/AmrUser-48/linux/releases/download/core2-mpv-0.35.1-4-core2.1-20261009190224/SHA256SUMS-core2-mpv.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-mpv-0.35.1-4-core2.1-20261009190224)

</details>

### libcap2
Version: `1:2.66-4+deb12u3+core2.1~20261009190327` · Published: 2026-10-09 19:03:51 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libcap2`

<details><summary>Files (6)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327/BUILD-INFO.txt)
- [libcap2_2.66-4+deb12u3+core2.1.20261009190327_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327/libcap2_2.66-4%2Bdeb12u3%2Bcore2.1.20261009190327_amd64.deb)
- [libcap2-bin_2.66-4+deb12u3+core2.1.20261009190327_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327/libcap2-bin_2.66-4%2Bdeb12u3%2Bcore2.1.20261009190327_amd64.deb)
- [libpam-cap_2.66-4+deb12u3+core2.1.20261009190327_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327/libpam-cap_2.66-4%2Bdeb12u3%2Bcore2.1.20261009190327_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327/release-notes.md)
- [SHA256SUMS-core2-libcap2.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327/SHA256SUMS-core2-libcap2.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327)

</details>

### ncurses
Version: `6.4-4+core2.1~20261009185822` · Published: 2026-10-09 19:02:36 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - ncurses`

<details><summary>Files (17)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/BUILD-INFO.txt)
- [lib32ncurses6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/lib32ncurses6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [lib32ncursesw6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/lib32ncursesw6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [lib32tinfo6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/lib32tinfo6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libncurses5_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libncurses5_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libncurses6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libncurses6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libncursesw5_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libncursesw5_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libncursesw6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libncursesw6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libtinfo5_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libtinfo5_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libtinfo6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libtinfo6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [ncurses-base_6.4-4+core2.1.20261009185822_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/ncurses-base_6.4-4%2Bcore2.1.20261009185822_all.deb)
- [ncurses-bin_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/ncurses-bin_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [ncurses-doc_6.4-4+core2.1.20261009185822_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/ncurses-doc_6.4-4%2Bcore2.1.20261009185822_all.deb)
- [ncurses-examples_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/ncurses-examples_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [ncurses-term_6.4-4+core2.1.20261009185822_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/ncurses-term_6.4-4%2Bcore2.1.20261009185822_all.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/release-notes.md)
- [SHA256SUMS-core2-ncurses.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/SHA256SUMS-core2-ncurses.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822)

</details>

### ffmpeg
Version: `7:5.1.9-0+deb12u1+core2.1~20261009183944` · Published: 2026-10-09 19:00:59 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - ffmpeg`

<details><summary>Files (19)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/BUILD-INFO.txt)
- [ffmpeg_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/ffmpeg_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [ffmpeg-doc_5.1.9-0+deb12u1+core2.1.20261009183944_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/ffmpeg-doc_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_all.deb)
- [libavcodec-extra_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavcodec-extra_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavcodec-extra59_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavcodec-extra59_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavcodec59_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavcodec59_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavdevice59_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavdevice59_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavfilter-extra_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavfilter-extra_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavfilter-extra8_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavfilter-extra8_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavfilter8_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavfilter8_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavformat-extra_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavformat-extra_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavformat-extra59_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavformat-extra59_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavformat59_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavformat59_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavutil57_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavutil57_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libpostproc56_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libpostproc56_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libswresample4_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libswresample4_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libswscale6_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libswscale6_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/release-notes.md)
- [SHA256SUMS-core2-ffmpeg.txt](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/SHA256SUMS-core2-ffmpeg.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944)

</details>

### libxcrypt
Version: `1:4.4.33-2+core2.1~20261009185630` · Published: 2026-10-09 18:57:31 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxcrypt`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-libxcrypt-1-4.4.33-2-core2.1-20261009185630/BUILD-INFO.txt)
- [libcrypt1_4.4.33-2+core2.1.20261009185630_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libxcrypt-1-4.4.33-2-core2.1-20261009185630/libcrypt1_4.4.33-2%2Bcore2.1.20261009185630_amd64.deb)
- [libxcrypt-source_4.4.33-2+core2.1.20261009185630_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libxcrypt-1-4.4.33-2-core2.1-20261009185630/libxcrypt-source_4.4.33-2%2Bcore2.1.20261009185630_all.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-libxcrypt-1-4.4.33-2-core2.1-20261009185630/release-notes.md)
- [SHA256SUMS-core2-libxcrypt.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-libxcrypt-1-4.4.33-2-core2.1-20261009185630/SHA256SUMS-core2-libxcrypt.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libxcrypt-1-4.4.33-2-core2.1-20261009185630)

</details>

### zlib
Version: `1:1.2.13.dfsg-1+core2.1~20261009185513` · Published: 2026-10-09 18:55:48 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - zlib`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-zlib-1-1.2.13.dfsg-1-core2.1-20261009185513/BUILD-INFO.txt)
- [lib32z1_1.2.13.dfsg-1+core2.1.20261009185513_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-zlib-1-1.2.13.dfsg-1-core2.1-20261009185513/lib32z1_1.2.13.dfsg-1%2Bcore2.1.20261009185513_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-zlib-1-1.2.13.dfsg-1-core2.1-20261009185513/release-notes.md)
- [SHA256SUMS-core2-zlib.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-zlib-1-1.2.13.dfsg-1-core2.1-20261009185513/SHA256SUMS-core2-zlib.txt)
- [zlib1g_1.2.13.dfsg-1+core2.1.20261009185513_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-zlib-1-1.2.13.dfsg-1-core2.1-20261009185513/zlib1g_1.2.13.dfsg-1%2Bcore2.1.20261009185513_amd64.deb)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-zlib-1-1.2.13.dfsg-1-core2.1-20261009185513)

</details>

### openssl
Version: `3.0.22-1~deb12u1+core2.1~20261009184347` · Published: 2026-10-09 18:54:26 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - openssl`

<details><summary>Files (6)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-openssl-3.0.22-1-deb12u1-core2.1-20261009184347/BUILD-INFO.txt)
- [libssl-doc_3.0.22-1.deb12u1+core2.1.20261009184347_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-openssl-3.0.22-1-deb12u1-core2.1-20261009184347/libssl-doc_3.0.22-1.deb12u1%2Bcore2.1.20261009184347_all.deb)
- [libssl3_3.0.22-1.deb12u1+core2.1.20261009184347_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-openssl-3.0.22-1-deb12u1-core2.1-20261009184347/libssl3_3.0.22-1.deb12u1%2Bcore2.1.20261009184347_amd64.deb)
- [openssl_3.0.22-1.deb12u1+core2.1.20261009184347_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-openssl-3.0.22-1-deb12u1-core2.1-20261009184347/openssl_3.0.22-1.deb12u1%2Bcore2.1.20261009184347_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-openssl-3.0.22-1-deb12u1-core2.1-20261009184347/release-notes.md)
- [SHA256SUMS-core2-openssl.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-openssl-3.0.22-1-deb12u1-core2.1-20261009184347/SHA256SUMS-core2-openssl.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-openssl-3.0.22-1-deb12u1-core2.1-20261009184347)

</details>

### 7zip
Version: `22.01+really26.02+dfsg-0+deb12u1+core2.1~20261009183500` · Published: 2026-10-09 18:37:34 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - 7zip`

<details><summary>Files (4)</summary>

- [7zip_22.01+really26.02+dfsg-0+deb12u1+core2.1.20261009183500_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-7zip-22.01-really26.02-dfsg-0-deb12u1-core2.1-20261009183500/7zip_22.01%2Breally26.02%2Bdfsg-0%2Bdeb12u1%2Bcore2.1.20261009183500_amd64.deb)
- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-7zip-22.01-really26.02-dfsg-0-deb12u1-core2.1-20261009183500/BUILD-INFO.txt)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-7zip-22.01-really26.02-dfsg-0-deb12u1-core2.1-20261009183500/release-notes.md)
- [SHA256SUMS-core2-7zip.txt](https://github.com/AmrUser-48/linux/releases/download/core2-7zip-22.01-really26.02-dfsg-0-deb12u1-core2.1-20261009183500/SHA256SUMS-core2-7zip.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-7zip-22.01-really26.02-dfsg-0-deb12u1-core2.1-20261009183500)

</details>

### xz-utils
Version: `5.4.1-1+deb12u2+core2.1~20261009183205` · Published: 2026-10-09 18:33:57 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xz-utils`

<details><summary>Files (7)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-xz-utils-5.4.1-1-deb12u2-core2.1-20261009183205/BUILD-INFO.txt)
- [liblzma-doc_5.4.1-1+deb12u2+core2.1.20261009183205_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xz-utils-5.4.1-1-deb12u2-core2.1-20261009183205/liblzma-doc_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009183205_all.deb)
- [liblzma5_5.4.1-1+deb12u2+core2.1.20261009183205_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xz-utils-5.4.1-1-deb12u2-core2.1-20261009183205/liblzma5_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009183205_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-xz-utils-5.4.1-1-deb12u2-core2.1-20261009183205/release-notes.md)
- [SHA256SUMS-core2-xz-utils.txt](https://github.com/AmrUser-48/linux/releases/download/core2-xz-utils-5.4.1-1-deb12u2-core2.1-20261009183205/SHA256SUMS-core2-xz-utils.txt)
- [xz-utils_5.4.1-1+deb12u2+core2.1.20261009183205_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xz-utils-5.4.1-1-deb12u2-core2.1-20261009183205/xz-utils_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009183205_amd64.deb)
- [xzdec_5.4.1-1+deb12u2+core2.1.20261009183205_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xz-utils-5.4.1-1-deb12u2-core2.1-20261009183205/xzdec_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009183205_amd64.deb)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xz-utils-5.4.1-1-deb12u2-core2.1-20261009183205)

</details>

### fftw3
Version: `3.3.10-1+core2.1~20261009181939` · Published: 2026-10-09 18:29:31 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - fftw3`

<details><summary>Files (10)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/BUILD-INFO.txt)
- [libfftw3-bin_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-bin_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
- [libfftw3-doc_3.3.10-1+core2.1.20261009181939_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-doc_3.3.10-1%2Bcore2.1.20261009181939_all.deb)
- [libfftw3-double3_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-double3_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
- [libfftw3-long3_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-long3_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
- [libfftw3-mpi3_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-mpi3_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
- [libfftw3-quad3_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-quad3_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
- [libfftw3-single3_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-single3_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/release-notes.md)
- [SHA256SUMS-core2-fftw3.txt](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/SHA256SUMS-core2-fftw3.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-fftw3-3.3.10-1-core2.1-20261009181939)

</details>

### python3.11
Version: `3.11.2-6+deb12u9+core2.1~20261009153835` · Published: 2026-10-09 18:18:32 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - python3.11`

<details><summary>Files (15)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/BUILD-INFO.txt)
- [idle-python3.11_3.11.2-6+deb12u9+core2.1.20261009153835_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/idle-python3.11_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_all.deb)
- [libpython3.11_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/libpython3.11_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [libpython3.11-minimal_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/libpython3.11-minimal_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [libpython3.11-stdlib_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/libpython3.11-stdlib_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [libpython3.11-testsuite_3.11.2-6+deb12u9+core2.1.20261009153835_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/libpython3.11-testsuite_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_all.deb)
- [python3.11_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [python3.11-doc_3.11.2-6+deb12u9+core2.1.20261009153835_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-doc_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_all.deb)
- [python3.11-examples_3.11.2-6+deb12u9+core2.1.20261009153835_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-examples_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_all.deb)
- [python3.11-full_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-full_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [python3.11-minimal_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-minimal_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [python3.11-nopie_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-nopie_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [python3.11-venv_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-venv_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/release-notes.md)
- [SHA256SUMS-core2-python3.11.txt](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/SHA256SUMS-core2-python3.11.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835)

</details>

### mesa
Version: `22.3.6-1+deb12u2+core2.1~20261009173146` · Published: 2026-10-09 17:53:45 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - mesa`

<details><summary>Files (19)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/BUILD-INFO.txt)
- [libd3dadapter9-mesa_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libd3dadapter9-mesa_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [libegl-mesa0_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libegl-mesa0_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [libegl1-mesa_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libegl1-mesa_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [libgbm1_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libgbm1_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [libgl1-mesa-dri_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libgl1-mesa-dri_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [libgl1-mesa-glx_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libgl1-mesa-glx_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [libglapi-mesa_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libglapi-mesa_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [libgles2-mesa_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libgles2-mesa_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [libglx-mesa0_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libglx-mesa0_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [libosmesa6_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libosmesa6_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [libwayland-egl1-mesa_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libwayland-egl1-mesa_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [libxatracker2_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/libxatracker2_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [mesa-opencl-icd_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/mesa-opencl-icd_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [mesa-va-drivers_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/mesa-va-drivers_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [mesa-vdpau-drivers_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/mesa-vdpau-drivers_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [mesa-vulkan-drivers_22.3.6-1+deb12u2+core2.1.20261009173146_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/mesa-vulkan-drivers_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261009173146_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/release-notes.md)
- [SHA256SUMS-core2-mesa.txt](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146/SHA256SUMS-core2-mesa.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261009173146)

</details>

### findutils
Version: `4.9.0-4+core2.1~20261009164357` · Published: 2026-10-09 16:45:15 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - findutils`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-findutils-4.9.0-4-core2.1-20261009164357/BUILD-INFO.txt)
- [findutils_4.9.0-4+core2.1.20261009164357_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-findutils-4.9.0-4-core2.1-20261009164357/findutils_4.9.0-4%2Bcore2.1.20261009164357_amd64.deb)
- [locate_4.9.0-4+core2.1.20261009164357_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-findutils-4.9.0-4-core2.1-20261009164357/locate_4.9.0-4%2Bcore2.1.20261009164357_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-findutils-4.9.0-4-core2.1-20261009164357/release-notes.md)
- [SHA256SUMS-core2-findutils.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-findutils-4.9.0-4-core2.1-20261009164357/SHA256SUMS-core2-findutils.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-findutils-4.9.0-4-core2.1-20261009164357)

</details>

### rust-sd
Version: `0.7.6-1+deb12u1+core2.1~20261009163957` · Published: 2026-10-09 16:42:51 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - rust-sd`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-rust-sd-0.7.6-1-deb12u1-core2.1-20261009163957/BUILD-INFO.txt)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-rust-sd-0.7.6-1-deb12u1-core2.1-20261009163957/release-notes.md)
- [sd_0.80.really.0.7.6-1+deb12u1+core2.1.20261009163957_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-rust-sd-0.7.6-1-deb12u1-core2.1-20261009163957/sd_0.80.really.0.7.6-1%2Bdeb12u1%2Bcore2.1.20261009163957_amd64.deb)
- [SHA256SUMS-core2-rust-sd.txt](https://github.com/AmrUser-48/linux/releases/download/core2-rust-sd-0.7.6-1-deb12u1-core2.1-20261009163957/SHA256SUMS-core2-rust-sd.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-rust-sd-0.7.6-1-deb12u1-core2.1-20261009163957)

</details>

### nano
Version: `7.2-1+deb12u1+core2.1~20261009163909` · Published: 2026-10-09 16:40:55 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - nano`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-nano-7.2-1-deb12u1-core2.1-20261009163909/BUILD-INFO.txt)
- [nano_7.2-1+deb12u1+core2.1.20261009163909_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-nano-7.2-1-deb12u1-core2.1-20261009163909/nano_7.2-1%2Bdeb12u1%2Bcore2.1.20261009163909_amd64.deb)
- [nano-tiny_7.2-1+deb12u1+core2.1.20261009163909_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-nano-7.2-1-deb12u1-core2.1-20261009163909/nano-tiny_7.2-1%2Bdeb12u1%2Bcore2.1.20261009163909_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-nano-7.2-1-deb12u1-core2.1-20261009163909/release-notes.md)
- [SHA256SUMS-core2-nano.txt](https://github.com/AmrUser-48/linux/releases/download/core2-nano-7.2-1-deb12u1-core2.1-20261009163909/SHA256SUMS-core2-nano.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-nano-7.2-1-deb12u1-core2.1-20261009163909)

</details>

### readline
Version: `8.2-1.3+core2.1~20261009161033` · Published: 2026-10-09 16:11:55 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - readline`

<details><summary>Files (8)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/BUILD-INFO.txt)
- [lib32readline8_8.2-1.3+core2.1.20261009161033_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/lib32readline8_8.2-1.3%2Bcore2.1.20261009161033_amd64.deb)
- [libreadline8_8.2-1.3+core2.1.20261009161033_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/libreadline8_8.2-1.3%2Bcore2.1.20261009161033_amd64.deb)
- [readline-common_8.2-1.3+core2.1.20261009161033_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/readline-common_8.2-1.3%2Bcore2.1.20261009161033_all.deb)
- [readline-doc_8.2-1.3+core2.1.20261009161033_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/readline-doc_8.2-1.3%2Bcore2.1.20261009161033_all.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/release-notes.md)
- [rlfe_8.2-1.3+core2.1.20261009161033_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/rlfe_8.2-1.3%2Bcore2.1.20261009161033_amd64.deb)
- [SHA256SUMS-core2-readline.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/SHA256SUMS-core2-readline.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-readline-8.2-1.3-core2.1-20261009161033)

</details>

### gawk
Version: `1:5.2.1-2+core2.1~20261009154053` · Published: 2026-10-09 15:42:14 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gawk`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-gawk-1-5.2.1-2-core2.1-20261009154053/BUILD-INFO.txt)
- [gawk_5.2.1-2+core2.1.20261009154053_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gawk-1-5.2.1-2-core2.1-20261009154053/gawk_5.2.1-2%2Bcore2.1.20261009154053_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-gawk-1-5.2.1-2-core2.1-20261009154053/release-notes.md)
- [SHA256SUMS-core2-gawk.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-gawk-1-5.2.1-2-core2.1-20261009154053/SHA256SUMS-core2-gawk.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-gawk-1-5.2.1-2-core2.1-20261009154053)

</details>

### tar
Version: `1.34+dfsg-1.2+deb12u1+core2.1~20261009152714` · Published: 2026-10-09 15:31:27 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - tar`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-tar-1.34-dfsg-1.2-deb12u1-core2.1-20261009152714/BUILD-INFO.txt)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-tar-1.34-dfsg-1.2-deb12u1-core2.1-20261009152714/release-notes.md)
- [SHA256SUMS-core2-tar.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-tar-1.34-dfsg-1.2-deb12u1-core2.1-20261009152714/SHA256SUMS-core2-tar.txt)
- [tar_1.34+dfsg-1.2+deb12u1+core2.1.20261009152714_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-tar-1.34-dfsg-1.2-deb12u1-core2.1-20261009152714/tar_1.34%2Bdfsg-1.2%2Bdeb12u1%2Bcore2.1.20261009152714_amd64.deb)
- [tar-scripts_1.34+dfsg-1.2+deb12u1+core2.1.20261009152714_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-tar-1.34-dfsg-1.2-deb12u1-core2.1-20261009152714/tar-scripts_1.34%2Bdfsg-1.2%2Bdeb12u1%2Bcore2.1.20261009152714_amd64.deb)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-tar-1.34-dfsg-1.2-deb12u1-core2.1-20261009152714)

</details>

### pcre2
Version: `10.42-1+deb12u2+core2.1~20261009152649` · Published: 2026-10-09 15:28:14 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - pcre2`

<details><summary>Files (8)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/BUILD-INFO.txt)
- [libpcre2-16-0_10.42-1+deb12u2+core2.1.20261009152649_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/libpcre2-16-0_10.42-1%2Bdeb12u2%2Bcore2.1.20261009152649_amd64.deb)
- [libpcre2-32-0_10.42-1+deb12u2+core2.1.20261009152649_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/libpcre2-32-0_10.42-1%2Bdeb12u2%2Bcore2.1.20261009152649_amd64.deb)
- [libpcre2-8-0_10.42-1+deb12u2+core2.1.20261009152649_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/libpcre2-8-0_10.42-1%2Bdeb12u2%2Bcore2.1.20261009152649_amd64.deb)
- [libpcre2-posix3_10.42-1+deb12u2+core2.1.20261009152649_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/libpcre2-posix3_10.42-1%2Bdeb12u2%2Bcore2.1.20261009152649_amd64.deb)
- [pcre2-utils_10.42-1+deb12u2+core2.1.20261009152649_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/pcre2-utils_10.42-1%2Bdeb12u2%2Bcore2.1.20261009152649_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/release-notes.md)
- [SHA256SUMS-core2-pcre2.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/SHA256SUMS-core2-pcre2.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649)

</details>

### xorg-server
Version: `2:21.1.7-3+deb12u13+core2.1~20261009120435` · Published: 2026-10-09 12:08:59 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xorg-server`

<details><summary>Files (10)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/BUILD-INFO.txt)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/release-notes.md)
- [SHA256SUMS-core2-xorg-server.txt](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/SHA256SUMS-core2-xorg-server.txt)
- [xnest_21.1.7-3+deb12u13+core2.1.20261009120435_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xnest_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_amd64.deb)
- [xorg-server-source_21.1.7-3+deb12u13+core2.1.20261009120435_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xorg-server-source_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_all.deb)
- [xserver-common_21.1.7-3+deb12u13+core2.1.20261009120435_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xserver-common_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_all.deb)
- [xserver-xephyr_21.1.7-3+deb12u13+core2.1.20261009120435_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xserver-xephyr_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_amd64.deb)
- [xserver-xorg-core_21.1.7-3+deb12u13+core2.1.20261009120435_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xserver-xorg-core_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_amd64.deb)
- [xserver-xorg-legacy_21.1.7-3+deb12u13+core2.1.20261009120435_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xserver-xorg-legacy_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_amd64.deb)
- [xvfb_21.1.7-3+deb12u13+core2.1.20261009120435_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xvfb_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_amd64.deb)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435)

</details>

### htop
Version: `3.2.2-2+core2.1~20261009120215` · Published: 2026-10-09 12:03:09 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - htop`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-htop-3.2.2-2-core2.1-20261009120215/BUILD-INFO.txt)
- [htop_3.2.2-2+core2.1.20261009120215_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-htop-3.2.2-2-core2.1-20261009120215/htop_3.2.2-2%2Bcore2.1.20261009120215_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-htop-3.2.2-2-core2.1-20261009120215/release-notes.md)
- [SHA256SUMS-core2-htop.txt](https://github.com/AmrUser-48/linux/releases/download/core2-htop-3.2.2-2-core2.1-20261009120215/SHA256SUMS-core2-htop.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-htop-3.2.2-2-core2.1-20261009120215)

</details>

### btop
Version: `1.2.13-1+core2.1~20261009120005` · Published: 2026-10-09 12:01:31 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - btop`

<details><summary>Files (4)</summary>

- [btop_1.2.13-1+core2.1.20261009120005_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-btop-1.2.13-1-core2.1-20261009120005/btop_1.2.13-1%2Bcore2.1.20261009120005_amd64.deb)
- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-btop-1.2.13-1-core2.1-20261009120005/BUILD-INFO.txt)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-btop-1.2.13-1-core2.1-20261009120005/release-notes.md)
- [SHA256SUMS-core2-btop.txt](https://github.com/AmrUser-48/linux/releases/download/core2-btop-1.2.13-1-core2.1-20261009120005/SHA256SUMS-core2-btop.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-btop-1.2.13-1-core2.1-20261009120005)

</details>

### rust-ripgrep
Version: `13.0.0-4+core2.1~20261009115443` · Published: 2026-10-09 11:58:49 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - rust-ripgrep`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-rust-ripgrep-13.0.0-4-core2.1-20261009115443/BUILD-INFO.txt)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-rust-ripgrep-13.0.0-4-core2.1-20261009115443/release-notes.md)
- [ripgrep_13.0.0-4+core2.1.20261009115443_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-rust-ripgrep-13.0.0-4-core2.1-20261009115443/ripgrep_13.0.0-4%2Bcore2.1.20261009115443_amd64.deb)
- [SHA256SUMS-core2-rust-ripgrep.txt](https://github.com/AmrUser-48/linux/releases/download/core2-rust-ripgrep-13.0.0-4-core2.1-20261009115443/SHA256SUMS-core2-rust-ripgrep.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-rust-ripgrep-13.0.0-4-core2.1-20261009115443)

</details>

### rust-fd-find
Version: `8.6.0-3+core2.1~20261009114655` · Published: 2026-10-09 11:50:19 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - rust-fd-find`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-rust-fd-find-8.6.0-3-core2.1-20261009114655/BUILD-INFO.txt)
- [fd-find_8.6.0-3+core2.1.20261009114655_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-rust-fd-find-8.6.0-3-core2.1-20261009114655/fd-find_8.6.0-3%2Bcore2.1.20261009114655_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-rust-fd-find-8.6.0-3-core2.1-20261009114655/release-notes.md)
- [SHA256SUMS-core2-rust-fd-find.txt](https://github.com/AmrUser-48/linux/releases/download/core2-rust-fd-find-8.6.0-3-core2.1-20261009114655/SHA256SUMS-core2-rust-fd-find.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-rust-fd-find-8.6.0-3-core2.1-20261009114655)

</details>

### mpd
Version: `0.23.12-1+core2.1~20261009114100` · Published: 2026-10-09 11:45:54 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - mpd`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-mpd-0.23.12-1-core2.1-20261009114100/BUILD-INFO.txt)
- [mpd_0.23.12-1+core2.1.20261009114100_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mpd-0.23.12-1-core2.1-20261009114100/mpd_0.23.12-1%2Bcore2.1.20261009114100_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-mpd-0.23.12-1-core2.1-20261009114100/release-notes.md)
- [SHA256SUMS-core2-mpd.txt](https://github.com/AmrUser-48/linux/releases/download/core2-mpd-0.23.12-1-core2.1-20261009114100/SHA256SUMS-core2-mpd.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-mpd-0.23.12-1-core2.1-20261009114100)

</details>

### ncmpcpp
Version: `0.9.2-2+core2.1~20261009113534` · Published: 2026-10-09 11:39:35 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - ncmpcpp`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-ncmpcpp-0.9.2-2-core2.1-20261009113534/BUILD-INFO.txt)
- [ncmpcpp_0.9.2-2+core2.1.20261009113534_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ncmpcpp-0.9.2-2-core2.1-20261009113534/ncmpcpp_0.9.2-2%2Bcore2.1.20261009113534_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-ncmpcpp-0.9.2-2-core2.1-20261009113534/release-notes.md)
- [SHA256SUMS-core2-ncmpcpp.txt](https://github.com/AmrUser-48/linux/releases/download/core2-ncmpcpp-0.9.2-2-core2.1-20261009113534/SHA256SUMS-core2-ncmpcpp.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-ncmpcpp-0.9.2-2-core2.1-20261009113534)

</details>

### dash
Version: `0.5.12-2+core2.1~20261009104558` · Published: 2026-10-09 10:46:26 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - dash`

<details><summary>Files (5)</summary>

- [ash_0.5.12-2+core2.1.20261009104558_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-dash-0.5.12-2-core2.1-20261009104558/ash_0.5.12-2%2Bcore2.1.20261009104558_all.deb)
- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-dash-0.5.12-2-core2.1-20261009104558/BUILD-INFO.txt)
- [dash_0.5.12-2+core2.1.20261009104558_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-dash-0.5.12-2-core2.1-20261009104558/dash_0.5.12-2%2Bcore2.1.20261009104558_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-dash-0.5.12-2-core2.1-20261009104558/release-notes.md)
- [SHA256SUMS-core2-dash.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-dash-0.5.12-2-core2.1-20261009104558/SHA256SUMS-core2-dash.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-dash-0.5.12-2-core2.1-20261009104558)

</details>

### bash
Version: `5.2.15-2+core2.1~20261009104102` · Published: 2026-10-09 10:45:21 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - bash`

<details><summary>Files (7)</summary>

- [bash_5.2.15-2+core2.1.20261009104102_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-bash-5.2.15-2-core2.1-20261009104102/bash_5.2.15-2%2Bcore2.1.20261009104102_amd64.deb)
- [bash-builtins_5.2.15-2+core2.1.20261009104102_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-bash-5.2.15-2-core2.1-20261009104102/bash-builtins_5.2.15-2%2Bcore2.1.20261009104102_amd64.deb)
- [bash-doc_5.2.15-2+core2.1.20261009104102_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-bash-5.2.15-2-core2.1-20261009104102/bash-doc_5.2.15-2%2Bcore2.1.20261009104102_all.deb)
- [bash-static_5.2.15-2+core2.1.20261009104102_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-bash-5.2.15-2-core2.1-20261009104102/bash-static_5.2.15-2%2Bcore2.1.20261009104102_amd64.deb)
- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-bash-5.2.15-2-core2.1-20261009104102/BUILD-INFO.txt)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-bash-5.2.15-2-core2.1-20261009104102/release-notes.md)
- [SHA256SUMS-core2-bash.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-bash-5.2.15-2-core2.1-20261009104102/SHA256SUMS-core2-bash.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-bash-5.2.15-2-core2.1-20261009104102)

</details>

### coreutils
Version: `9.1-1+core2.1~20261009103756` · Published: 2026-10-09 10:40:01 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - coreutils`

<details><summary>Files (4)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-coreutils-9.1-1-core2.1-20261009103756/BUILD-INFO.txt)
- [coreutils_9.1-1+core2.1.20261009103756_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-coreutils-9.1-1-core2.1-20261009103756/coreutils_9.1-1%2Bcore2.1.20261009103756_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-system-coreutils-9.1-1-core2.1-20261009103756/release-notes.md)
- [SHA256SUMS-core2-coreutils.txt](https://github.com/AmrUser-48/linux/releases/download/core2-system-coreutils-9.1-1-core2.1-20261009103756/SHA256SUMS-core2-coreutils.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-coreutils-9.1-1-core2.1-20261009103756)

</details>

### neovim
Version: `0.7.2-7+core2.1~20261009082328` · Published: 2026-10-09 08:30:27 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - neovim`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009082328/BUILD-INFO.txt)
- [neovim_0.7.2-7+core2.1.20261009082328_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009082328/neovim_0.7.2-7%2Bcore2.1.20261009082328_amd64.deb)
- [neovim-runtime_0.7.2-7+core2.1.20261009082328_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009082328/neovim-runtime_0.7.2-7%2Bcore2.1.20261009082328_all.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009082328/release-notes.md)
- [SHA256SUMS-core2-neovim.txt](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009082328/SHA256SUMS-core2-neovim.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-neovim-0.7.2-7-core2.1-20261009082328)

</details>

### neovim
Version: `0.7.2-7+core2.1~20261009075932` · Published: 2026-10-09 08:09:16 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - neovim`

<details><summary>Files (5)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009075932/BUILD-INFO.txt)
- [neovim_0.7.2-7+core2.1.20261009075932_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009075932/neovim_0.7.2-7%2Bcore2.1.20261009075932_amd64.deb)
- [neovim-runtime_0.7.2-7+core2.1.20261009075932_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009075932/neovim-runtime_0.7.2-7%2Bcore2.1.20261009075932_all.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009075932/release-notes.md)
- [SHA256SUMS-core2-neovim.txt](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009075932/SHA256SUMS-core2-neovim.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-neovim-0.7.2-7-core2.1-20261009075932)

</details>

### zsh
Version: `5.9-4+core2.1~20261009061847` · Published: 2026-10-09 06:24:36 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - zsh`

<details><summary>Files (7)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-zsh-5.9-4-core2.1-20261009061847/BUILD-INFO.txt)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-zsh-5.9-4-core2.1-20261009061847/release-notes.md)
- [SHA256SUMS-core2-zsh.txt](https://github.com/AmrUser-48/linux/releases/download/core2-zsh-5.9-4-core2.1-20261009061847/SHA256SUMS-core2-zsh.txt)
- [zsh_5.9-4+core2.1.20261009061847_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zsh-5.9-4-core2.1-20261009061847/zsh_5.9-4%2Bcore2.1.20261009061847_amd64.deb)
- [zsh-common_5.9-4+core2.1.20261009061847_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zsh-5.9-4-core2.1-20261009061847/zsh-common_5.9-4%2Bcore2.1.20261009061847_all.deb)
- [zsh-doc_5.9-4+core2.1.20261009061847_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zsh-5.9-4-core2.1-20261009061847/zsh-doc_5.9-4%2Bcore2.1.20261009061847_all.deb)
- [zsh-static_5.9-4+core2.1.20261009061847_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zsh-5.9-4-core2.1-20261009061847/zsh-static_5.9-4%2Bcore2.1.20261009061847_amd64.deb)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-zsh-5.9-4-core2.1-20261009061847)

</details>

### bash
Version: `5.2.15-2+core2.1~20261009061252` · Published: 2026-10-09 06:17:34 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - bash`

<details><summary>Files (7)</summary>

- [bash_5.2.15-2+core2.1.20261009061252_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-bash-5.2.15-2-core2.1-20261009061252/bash_5.2.15-2%2Bcore2.1.20261009061252_amd64.deb)
- [bash-builtins_5.2.15-2+core2.1.20261009061252_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-bash-5.2.15-2-core2.1-20261009061252/bash-builtins_5.2.15-2%2Bcore2.1.20261009061252_amd64.deb)
- [bash-doc_5.2.15-2+core2.1.20261009061252_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-bash-5.2.15-2-core2.1-20261009061252/bash-doc_5.2.15-2%2Bcore2.1.20261009061252_all.deb)
- [bash-static_5.2.15-2+core2.1.20261009061252_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-bash-5.2.15-2-core2.1-20261009061252/bash-static_5.2.15-2%2Bcore2.1.20261009061252_amd64.deb)
- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-bash-5.2.15-2-core2.1-20261009061252/BUILD-INFO.txt)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-bash-5.2.15-2-core2.1-20261009061252/release-notes.md)
- [SHA256SUMS-core2-bash.txt](https://github.com/AmrUser-48/linux/releases/download/core2-bash-5.2.15-2-core2.1-20261009061252/SHA256SUMS-core2-bash.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-bash-5.2.15-2-core2.1-20261009061252)

</details>

### lame
Version: `3.100-6+core2.1~20261009061017` · Published: 2026-10-09 06:11:33 UTC

Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - lame`

<details><summary>Files (6)</summary>

- [BUILD-INFO.txt](https://github.com/AmrUser-48/linux/releases/download/core2-lame-3.100-6-core2.1-20261009061017/BUILD-INFO.txt)
- [lame_3.100-6+core2.1.20261009061017_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lame-3.100-6-core2.1-20261009061017/lame_3.100-6%2Bcore2.1.20261009061017_amd64.deb)
- [lame-doc_3.100-6+core2.1.20261009061017_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lame-3.100-6-core2.1-20261009061017/lame-doc_3.100-6%2Bcore2.1.20261009061017_all.deb)
- [libmp3lame0_3.100-6+core2.1.20261009061017_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lame-3.100-6-core2.1-20261009061017/libmp3lame0_3.100-6%2Bcore2.1.20261009061017_amd64.deb)
- [release-notes.md](https://github.com/AmrUser-48/linux/releases/download/core2-lame-3.100-6-core2.1-20261009061017/release-notes.md)
- [SHA256SUMS-core2-lame.txt](https://github.com/AmrUser-48/linux/releases/download/core2-lame-3.100-6-core2.1-20261009061017/SHA256SUMS-core2-lame.txt)
- [Release page](https://github.com/AmrUser-48/linux/releases/tag/core2-lame-3.100-6-core2.1-20261009061017)

</details>
<!-- CORE2-PACKAGE-RELEASE-INDEX:END -->

## Start a build

In GitHub, open **Actions → Core 2 optimized Debian package train → Run workflow**. Select a series. To refresh all release links in this README manually, use [**Refresh Core 2 package release index → Run workflow**](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-update-release-index.yml); the index also refreshes automatically when a release is published:

- all: the existing package train, then Python, FFTW, MPD/client utilities, Rust command-line tools, process monitors and the X.Org server.
- shell-editors: Bash, Zsh, Nano and Neovim.
- media: LAME, zstd, xz-utils, 7-Zip, FFmpeg, mpv and curl.
- graphics: Mesa only.
- new-tools: Python 3.11, FFTW, ncmpcpp, MPD, fd-find, sd, ripgrep, btop, htop and X.Org server.

The train is sequential (one package build at a time). Before dispatching each package, it checks for a matching `core2-<source-package>-*` release containing a .deb and skips it when one already exists. Failures collect the actual GitHub Actions failure log and the train continues to the next package. The final summary lists published, skipped and failed packages. After fixing a failed package, rerun the series: releases already published by the previous pass will be skipped. To build one package directly, start **Core 2 optimized Debian package** and select its Debian source package name.

## Build policy

The workflows fetch official Debian Bookworm and Bookworm-security source packages, retain Debian's packaging and patches, and append a unique +core2.1~timestamp revision so each rebuild can upgrade the previous custom package. Compilation and tests run as an unprivileged build user (with fakeroot only for package steps that need it), so filesystem permission tests do not accidentally pass or fail because CI runs as root. The default profile is `-O2 -march=core2 -mtune=core2`; LAME, FFTW, FFmpeg, mpv, 7-Zip, zstd and xz-utils use `-O3 -march=core2 -mtune=core2`. Rust targets (`rust-fd-find`, `rust-sd`, `rust-ripgrep`) use a compiler wrapper to add `-C target-cpu=core2` while retaining Debian's Cargo/linker flags. Debian's package-specific hardening flags are retained. The build verifies the Core 2 C/C++ flags and checks the Rust wrapper for Rust targets. Binary package selection excludes explicit `*-dev` and `*-dbg` stanzas, and `noautodbgsym` disables automatic debug-symbol packages. The workflow fails if any `-dev`, `-dbg`, or `-dbgsym` package appears in the output. Releases contain normal installable packages, the Debian source descriptor and matching source archives, build metadata, and checksums covering the uploaded binary/source files.

The artifacts target Intel Core 2-class systems (such as the D630 CPUs) and are not intended as generic amd64 replacements. They use Debian's standard ABI, but compiler-generated instructions can require Core 2 or a later CPU. Keep the stock Debian packages available for rollback.

The new-tools train uses Debian source package names where they differ from the binary packages or commands users want: `glibc` (in the system-package workflow) produces `libc6`; `fftw3` builds FFTW and produces runtime libraries including `libfftw3-double3`; `rust-fd-find` provides `fd` as Debian's `fdfind`; `rust-ripgrep` produces `rg` as `ripgrep`; `rust-sd` produces `sd`; and `xorg-server` is the code-bearing X.Org server source (the `xorg` package is only a metapackage). The package builder lets Debian's packaging rules run normally, then excludes `*-dev`, `*-dbg`, and `*-dbgsym` artifacts from publication. Python and X.Org produce several binary packages; only dev/debug packages are filtered, so review the release asset list before installation.

Mesa is the highest-risk target because it supplies graphics libraries and driver modules used by the desktop. Its release can contain multiple runtime and architecture-specific .deb packages; `-dev`, `-dbg`, and `-dbgsym` packages are excluded. Inspect the remaining package list, install only the related runtime packages required by this machine, keep a known-working kernel/Mesa combination as fallback, and test the GMA X3100 driver locally. CI compilation alone does not prove hardware rendering works.


## Core system packages (manual, higher risk)

For Debian core utilities, libraries and boot/runtime components, open [**Core 2 optimized Debian system package**](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-package.yml) and choose one source package per run. The menu includes:

- Runtime and toolchain foundations: `glibc` (produces packages including `libc6` and `libc-bin`), `gcc-12`, `binutils`, `dpkg`, `apt`.
- Init, shell and system tools: `systemd`, `bash`, `dash`, `coreutils`, `util-linux`, `iproute2`, `kmod`, `procps`, `e2fsprogs`, `psmisc`, `shadow`, `pam`.
- Core libraries and compression: `openssl`, `zlib`, `libxcrypt`, `ncurses`, `readline`, `libcap2`, `libselinux`, `libseccomp`, `acl`, `attr`, `pcre2`, `gmp`, `mpfr4`, `libffi`, `expat`, `libtirpc`.
- Basic text/file utilities: `findutils`, `grep`, `sed`, `gawk`, `diffutils`, `tar`, `gzip`, `bzip2`, `xz-utils`, `zstd`.

This workflow uses the conservative `-O2 -march=core2 -mtune=core2` profile for all listed packages. GCC and glibc builds are particularly large and may run for hours; the workflow timeout is six hours. Each successful build publishes its normal installable binary packages, build metadata and SHA-256 sums in a separate `core2-system-*` GitHub Release. Explicit `*-dev` and `*-dbg` package stanzas are excluded during debhelper processing, automatic `*-dbgsym` generation is disabled, and a validation guard stops release if any such package remains. Compilation is not the same as runtime validation.

**Critical warning:** do not install every generated `.deb` blindly. A glibc build may publish multiple runtime, locale and multiarch packages, even though development and debug packages are excluded. Inspect the asset list and dependencies first. Replacing `libc6` or `systemd` can make the installed system unusable; do this only with a verified backup, known-good kernel, and a tested rescue/rollback path. Keep the stock Debian packages and recovery media available. These builds target the D630 / Intel Core 2 system, not generic amd64 computers.



### Recover a failed release without rebuilding

If the compile/package job succeeded but release publishing failed, its workflow artifact may still be available for seven days. Use [**Recover Core 2 package release**](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-recover-release.yml), leave the default values for the Mesa run (`apps`, `mesa`, run ID `37892602737`), and run it. The workflow downloads the saved artifact, verifies its SHA-256 sums, and publishes the release without recompiling. Change the package kind and run ID to recover another app/system artifact.

### Run the system package train

Use [**Core 2 optimized Debian system package train**](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-packages-series.yml) to build batches or all 43 allowlisted system packages. The train reuses the single-package builder, publishes a separate release for each successful package, and runs at most **two package builds concurrently**. It does not stop all remaining builds just because one package fails; inspect the run summary and individual package jobs for failures.

Select `all` for the complete set, or a narrower group: `core-foundation`, `toolchain`, `runtime-libraries`, `system-utilities`, or `text-compression`. GCC and glibc can be long builds; the overall train can take many hours, while each individual package build has its own six-hour timeout. The single-package workflow remains available when you want to retry one failed target.

## Brave Browser

Brave is intentionally not in the normal Debian-source train. It is not a standard Bookworm source-package rebuild; Brave's Linux build uses a Chromium-sized checkout. Upstream's current instructions recommend more than 16 GB RAM and expect about 100 GB of free disk for Chromium. That does not fit the standard GitHub-hosted runner reliably. Treat Brave as a separate project requiring a larger or self-hosted runner, and test it as a separate browser install rather than replacing the held vendor package automatically.
