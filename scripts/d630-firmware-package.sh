#!/bin/sh
# Build a tiny Debian package containing only the Intel 3945ABG firmware
# required by the D630's iwl3945 driver.

set -eu

PKG=d630-firmware-iwl3945
VER=15.32.2.9-1
URL='https://gitlab.com/kernel-firmware/linux-firmware/-/raw/c979a06518069901e4c43e0019d3a15b435b7e16/iwlwifi-3945-2.ucode'
LICENCE_URL='https://gitlab.com/kernel-firmware/linux-firmware/-/raw/c979a06518069901e4c43e0019d3a15b435b7e16/LICENCE.iwlwifi_firmware'
EXPECTED_SIZE=150100
EXPECTED_SHA256=9bccc66fab027d18f0977fa737816d3e67938d4a9f5cf0790df8e45e19168f20

OUT="${1:-.}"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

mkdir -p "$WORK/pkg/DEBIAN" "$WORK/pkg/lib/firmware"
curl -fL --retry 3 --retry-delay 2 "$URL" -o "$WORK/pkg/lib/firmware/iwlwifi-3945-2.ucode"
curl -fL --retry 3 --retry-delay 2 "$LICENCE_URL" -o "$WORK/pkg/usr.share.licence" 2>/dev/null || true

size="$(wc -c < "$WORK/pkg/lib/firmware/iwlwifi-3945-2.ucode")"
test "$size" = "$EXPECTED_SIZE"

sha="$(sha256sum "$WORK/pkg/lib/firmware/iwlwifi-3945-2.ucode" | awk '{print $1}')"
test "$sha" = "$EXPECTED_SHA256"

if test -f "$WORK/pkg/usr.share.licence"; then
  mkdir -p "$WORK/pkg/usr/share/doc/$PKG"
  mv "$WORK/pkg/usr.share.licence" "$WORK/pkg/usr/share/doc/$PKG/LICENCE.iwlwifi_firmware"
fi

cat > "$WORK/pkg/DEBIAN/control" <<EOF
Package: $PKG
Version: $VER
Section: non-free-firmware
Priority: optional
Architecture: all
Maintainer: D630 kernel build <noreply@localhost>
Description: Intel PRO/Wireless 3945ABG firmware for D630 kernel
 Firmware-only package containing iwlwifi-3945-2.ucode for the
 Intel PRO/Wireless 3945ABG adapter used by Dell Latitude D630 systems.
EOF

dpkg-deb --root-owner-group --build "$WORK/pkg" "${OUT}/${PKG}_${VER}_all.deb"
dpkg-deb --info "$OUT/$PKG_$VER_all.deb"
