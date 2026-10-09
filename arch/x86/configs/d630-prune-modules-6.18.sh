#!/bin/sh
# Linux 6.18.y D630 module pruning.
# Drop loadable modules by default, then restore the explicit D630 hardware
# modules plus selected Debian userspace facilities.
set -eu

test -f .config
test -x scripts/config

tmp=.config.d630-prune.tmp
sed -E 's/^(CONFIG_[A-Za-z0-9_]+)=m$/\1=n/' .config > "$tmp"
mv "$tmp" .config

for opt in \
  TIGON3 KVM KVM_INTEL TUN USB_STORAGE USB_NET_CDCETHER USB_NET_RNDIS_HOST \
  USB_NET_CDC_NCM INPUT_JOYDEV INPUT_UINPUT BINFMT_MISC \
  FUSE_FS CUSE OVERLAY_FS \
  NETFILTER_NETLINK NF_CONNTRACK NF_CT_NETLINK NF_LOG_SYSLOG NF_NAT NF_TABLES \
  NFT_CT NFT_LOG NFT_LIMIT NFT_MASQ NFT_NAT NFT_REJECT NFT_REJECT_INET \
  NETFILTER_XTABLES \
  IP_NF_IPTABLES IP_NF_FILTER IP_NF_MANGLE IP_NF_TARGET_REJECT \
  IP6_NF_IPTABLES IP6_NF_FILTER IP6_NF_MANGLE IP6_NF_TARGET_REJECT \
  NETFILTER_XT_MATCH_CONNTRACK NETFILTER_XT_MATCH_STATE NETFILTER_XT_MATCH_POLICY \
  NETFILTER_XT_TARGET_CONNSECMARK NETFILTER_XT_TARGET_NFLOG \
  NETFILTER_XT_TARGET_REJECT NETFILTER_XT_TARGET_SECMARK \
  NETFILTER_XT_TARGET_TCPMSS NETFILTER_XT_TARGET_MASQUERADE NETFILTER_XT_NAT
do
  ./scripts/config --module "$opt"
done

# Keep standard module administration/version checks; disallow dangerous
# forced unload and forced signature enforcement.
./scripts/config --enable MODULES
./scripts/config --enable MODULE_UNLOAD
./scripts/config --disable MODULE_FORCE_UNLOAD
./scripts/config --disable MODULE_COMPRESS
./scripts/config --enable MODVERSIONS
./scripts/config --disable MODULE_SRCVERSION_ALL
./scripts/config --enable MODULE_SIG
./scripts/config --disable MODULE_SIG_ALL
./scripts/config --disable MODULE_SIG_FORCE
./scripts/config --disable MODULE_DECOMPRESS
./scripts/config --disable MODULE_DEBUG

make olddefconfig

echo '=== required retained modules ==='
for opt in \
  FUSE_FS OVERLAY_FS NF_CONNTRACK NF_NAT NF_TABLES \
  NETFILTER_XTABLES NFT_CT NFT_NAT NFT_MASQ \
  KVM KVM_INTEL TUN BINFMT_MISC
do
  printf 'CONFIG_%s=' "$opt"
  ./scripts/config --state "CONFIG_$opt" || true
done

echo '=== remaining loadable modules ==='
grep '=m$' .config || true
