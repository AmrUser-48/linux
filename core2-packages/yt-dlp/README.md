# Lightweight yt-dlp package for Debian 12

This package is built from the official upstream yt-dlp source archive, not Debian Bookworm's older source package.

## Design

- One /usr/bin/yt-dlp platform-independent zipimport executable.
- Architecture: all; no Core 2-specific machine code.
- Runtime dependency: python3 (>= 3.11), using Debian 12's system Python.
- No virtualenv, pip installation, PyInstaller bundle, or bundled interpreter.
- Optional dependencies are deliberately not installed: ffmpeg, yt-dlp-ejs, and a supported JavaScript runtime remain user choices.

The upstream source archive checksum is verified before building with make yt-dlp. CI checks the Debian metadata and runs the extracted executable's --version command.

## Build

Run [Build lightweight upstream yt-dlp package](https://github.com/AmrUser-48/linux/actions/workflows/yt-dlp-bookworm.yml) from the Actions tab. Leave the version empty to package the latest stable upstream release, or enter an exact upstream release tag.

Published .deb files are listed automatically in [the Core 2 package index](../README.md).
