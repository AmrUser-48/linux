# Debian 12 packages for Intel Core 2

This repository publishes Debian Bookworm packages built for Intel Core 2 CPUs (`-march=core2 -mtune=core2`), targeting systems such as the Dell Latitude D630.

## Packages

**[Browse the complete Core 2 package list →](core2-packages/README.md)**

The separate package README lists releases newest first and includes direct download links, checksums, build metadata, and release notes.

For build instructions and smart installation, see the [package guide](core2-packages/README.md).

## RustDesk for Intel Core 2 / Debian 12

The [Core 2 optimized RustDesk workflow](.github/workflows/d630-core2-rustdesk.yml) builds the official stable RustDesk source as an installable Bookworm `.deb`. It uses `-march=core2 -mtune=core2` for C/C++ and `target-cpu=core2`, release LTO and symbol stripping for Rust; strips remaining ELF payloads; validates runtime dependencies and shared-library resolution; and publishes checksums and build metadata.

The package retains the upstream runtime requirements, including GTK 3, XCB, xdo, ALSA, systemd, VA-API, GStreamer/PipeWire and the Ayatana app-indicator recommendation. On Debian 12, install the released package with APT (not `dpkg -i`) so dependency resolution is handled automatically. The action skips an already-published version unless **force rebuild** is selected.
