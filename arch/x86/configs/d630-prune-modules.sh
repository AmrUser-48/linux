#!/bin/sh
# Linux 7.2.9 D630 module pruning.
# Drop loadable modules by default, then restore D630 hardware and selected
# Debian userspace facilities. Keep standard module management/version checks.
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
  NFT_CT NFT_LOG NFT_LIMIT NFT_MASQ \
  NFT_REDIR NFT_NAT NFT_REJECT NFT_REJECT_INET NFT_COMPAT \
  NETFILTER_XTABLES NETFILTER_XT_NAT \
  NETFILTER_XT_MATCH_CONNTRACK NETFILTER_XT_MATCH_STATE NETFILTER_XT_MATCH_POLICY \
  NETFILTER_XT_TARGET_CONNSECMARK NETFILTER_XT_TARGET_NFLOG \
  NETFILTER_XT_TARGET_REDIRECT NETFILTER_XT_TARGET_REJECT \
  NETFILTER_XT_TARGET_SECMARK NETFILTER_XT_TARGET_TCPMSS \
  NETFILTER_XT_TARGET_MASQUERADE \
  IP_NF_IPTABLES IP_NF_FILTER IP_NF_NAT IP_NF_MANGLE IP_NF_TARGET_REJECT IP_NF_TARGET_MASQUERADE \
  IP6_NF_IPTABLES IP6_NF_FILTER IP6_NF_NAT IP6_NF_MANGLE IP6_NF_TARGET_REJECT IP6_NF_TARGET_MASQUERADE
do
  ./scripts/config --module "$opt"
done

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

echo '=== retained Debian and optional modules ==='
for opt in \
  FUSE_FS OVERLAY_FS NF_CONNTRACK NF_NAT NF_TABLES NFT_CT NFT_COUNTER \
  NFT_NAT NFT_MASQ NFT_REJECT \
  IP_NF_IPTABLES IP_NF_FILTER IP_NF_NAT IP6_NF_IPTABLES IP6_NF_NAT \
  KVM KVM_INTEL TUN BINFMT_MISC
do
  printf 'CONFIG_%s=' "$opt"
  ./scripts/config --state "CONFIG_$opt" || true
done

echo '=== remaining loadable modules ==='
grep '=m$' .config || true
