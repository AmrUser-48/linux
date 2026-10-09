# Debian Linux 6.1.187-1 source baseline

This branch builds the D630 kernel from Debian's official Bookworm security source package `linux` version `6.1.187-1`.

The `linux-image-amd64` binary package is a meta-package; Debian lists its source as `linux-signed-amd64`. The actual kernel source with Debian's kernel patches is package `linux` version `6.1.187-1`, also published as `linux-source-6.1`.

- Debian binary-package reference: https://packages.debian.org/bookworm/amd64/linux-image-amd64
- Debian kernel source-package reference: https://packages.debian.org/bookworm/kernel/linux-source-6.1
- Debian kernel team's Git repository: https://salsa.debian.org/kernel-team/linux

The build workflow enables the official `bookworm-security` source index and downloads the exact version with `apt-get source linux=6.1.187-1`. It verifies the unpacked Debian source version and applies the D630 configuration from this repository before building.

The full extracted kernel tree is deliberately not committed into this configuration repository. The source archive is large and contains no D630-specific changes; pinning the exact signed Debian source-package version in the workflow makes builds reproducible without duplicating the entire upstream tree. The D630 profile, module-pruning script, firmware package script, and source/build recipe are version-controlled here.
