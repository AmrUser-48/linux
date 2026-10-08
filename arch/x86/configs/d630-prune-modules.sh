#!/bin/sh
# Aggressively trim loadable modules for the D630 profile.
# Start from x86_64_defconfig, convert every =m to =n, then restore only
# the explicit optional module whitelist below.

set -eu

test -f .config
test -x scripts/config

tmp=.config.d630-prune.tmp
sed -E 's/^(CONFIG_[A-Za-z0-9_]+)=m$/\1=n/' .config > "$tmp"
mv "$tmp" .config

# Optional modules only:
# - tg3: Ethernet fallback
# - KVM/kvm-intel: QEMU hardware acceleration
# - tun: QEMU TAP networking
# - USB storage/phone networking
# - joystick userspace interface / raw HID (built-in) / uinput
# - binfmt_misc
for opt in \
  TIGON3 \
  KVM \
  KVM_INTEL \
  TUN \
  USB_STORAGE \
  USB_NET_CDCETHER \
  USB_NET_RNDIS_HOST \
  USB_NET_CDC_NCM \
  INPUT_JOYDEV \
  INPUT_UINPUT \
  BINFMT_MISC
do
  ./scripts/config --module "$opt"
done

# Keep module support but remove module-management and metadata overhead.
./scripts/config --enable MODULES
./scripts/config --disable MODULE_UNLOAD
./scripts/config --disable MODULE_FORCE_UNLOAD
./scripts/config --disable MODULE_COMPRESS
./scripts/config --disable MODVERSIONS
./scripts/config --disable MODULE_SRCVERSION_ALL
./scripts/config --disable MODULE_SIG
./scripts/config --disable MODULE_SIG_ALL
./scripts/config --disable MODULE_SIG_FORCE
./scripts/config --disable MODULE_DECOMPRESS
./scripts/config --disable MODULE_DEBUG

make olddefconfig

echo '=== remaining module settings ==='
grep '=m$' .config || true
