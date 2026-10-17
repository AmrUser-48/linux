# Telegram Desktop Core 2 — Changelog

Package: `telegram-desktop`  
Upstream Debian source: `4.6.5+ds-2`  
Published Core 2 package: `4.6.5+ds-2+core2.1~20261017193804`  
Target: Debian 12 (Bookworm), amd64 / Intel Core 2  
Release: https://github.com/AmrUser-48/linux/releases/tag/core2-telegram-desktop-4.6.5-ds-2-core2.1-20261017193804  
Build: https://github.com/AmrUser-48/linux/actions/runs/39063244565

## Upstream 4.6.5 changes

- Fixed payment-card input-field validation.
- Fixed hardware-accelerated video playback on macOS (not applicable to the Linux D630 build).

Source: https://github.com/telegramdesktop/tdesktop/blob/dev/changelog.txt

## D630 / Core 2 packaging changes

- Rebuilt the official Debian Bookworm source package for Intel Core 2 using `-O2 -march=core2 -mtune=core2`.
- Retained Debian packaging, patches, and hardening settings.
- Disabled automatic debug-symbol package generation.
- Removed the `Recommends` field from the `telegram-desktop` binary package; hard runtime `Depends` remain intact.
- Customized the emoji / stickers / GIF tabbed panel to avoid hover-triggered auto-opening; use explicit click interaction instead.
- Removed inconsistent option references introduced by Debian's `No-random-popups.patch` so the source compiles with the click-only customization.

## Verification status

- GitHub Actions build and publish jobs: **success**.
- Binary package published: `telegram-desktop_4.6.5+ds-2+core2.1.20261017193804_amd64.deb`.
- Runtime behavior has not yet been tested on the physical Dell Latitude D630.

## Checksums

The release includes `SHA256SUMS-core2-telegram-desktop.txt`, covering the published package and build metadata.
