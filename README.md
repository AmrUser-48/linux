# Debian 12 packages for Intel Core 2

This repository publishes Debian Bookworm packages built for Intel Core 2 CPUs (`-march=core2 -mtune=core2`), targeting systems such as the Dell Latitude D630.

## Packages

**[Browse the complete Core 2 package list →](core2-packages/README.md)**

The separate package README lists releases newest first and includes direct download links, checksums, build metadata, and release notes.

For build instructions and smart installation, see the [package guide](core2-packages/README.md).

## RustDesk for Intel Core 2 / Debian 12

The [Core 2 optimized RustDesk workflow](.github/workflows/d630-core2-rustdesk.yml) builds the official stable RustDesk source as an installable Bookworm `.deb`. It uses `-march=core2 -mtune=core2` for C/C++ and `target-cpu=core2`, release LTO and symbol stripping for Rust; strips remaining ELF payloads; validates runtime dependencies and shared-library resolution; and publishes checksums and build metadata.

The package retains the upstream runtime requirements, including GTK 3, XCB, xdo, ALSA, systemd, VA-API, GStreamer/PipeWire and the Ayatana app-indicator recommendation. On Debian 12, install the released package with APT (not `dpkg -i`) so dependency resolution is handled automatically. The action skips an already-published version unless **force rebuild** is selected.

## Midnight Commander and related packages

The [MC package-suite workflow](.github/workflows/d630-core2-mc-suite.yml) queues Core 2 builds for Midnight Commander and its available Debian Bookworm direct-dependency, recommendation, and concrete-suggestion source packages. It reuses the generic Debian package builder, skips existing releases and active builds, and checks that each source package exists in Bookworm before dispatch. The MC source build publishes both `mc` and `mc-data`; virtual suggestions and reverse-dependent applications are not rebuilt as MC requirements.

For any binary or source package, the [**Build with Deps** workflow](.github/workflows/build-with-deps.yml) resolves its recursive Debian Bookworm runtime dependency closure and builds missing Core 2 source packages. It can optionally include Recommends and can force rebuilds of existing Core 2 releases. Debian Build-Depends are supplied by Bookworm during each individual source build rather than recursively rebuilt.
