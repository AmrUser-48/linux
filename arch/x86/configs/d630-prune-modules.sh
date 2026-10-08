#!/bin/sh
# Aggressively remove loadable modules from the D630 configuration.
# Hardware needed for boot/use is kept built-in in d630.config; only this
# small whitelist remains loadable.

set -eu

test -f .config
test -x scripts/config

tmp=.config.d630-prune.tmp
sed -E 's/^(CONFIG_[A-Za-z0-9_]+)=m$/\1=n/' .config > "$tmp"
mv "$tmp" .config

# Optional drivers/interfaces kept as modules.
for opt in   TIGON3   USB_STORAGE   USB_NET_CDCETHER   USB_NET_RNDIS_HOST   USB_NET_CDC_NCM   INPUT_JOYDEV   HIDRAW   INPUT_UINPUT   BINFMT_MISC
do
  ./scripts/config --module "$opt"
done

# The profile deliberately keeps loadable-module support but avoids module
# overhead such as unloading, version CRCs, compression, signing and debug.
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
grep -E '=m$' .config || true
