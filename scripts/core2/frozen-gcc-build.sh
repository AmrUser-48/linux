#!/usr/bin/env bash
set -Eeuo pipefail
die(){ echo "::error::$*" >&2; exit 1; }

: "${GITHUB_WORKSPACE:?missing GITHUB_WORKSPACE}"
: "${GITHUB_REPOSITORY:?missing GITHUB_REPOSITORY}"
: "${GH_TOKEN:?missing GH_TOKEN}"

ROOT="$GITHUB_WORKSPACE/gcc-frozen-work"
STATE_TAG=core2-gcc12-frozen-state
RESET_CHECKPOINT="${RESET_CHECKPOINT:-false}"
GEN="${GITHUB_RUN_ID:-local}-${GITHUB_RUN_ATTEMPT:-1}"
CONTAINER="gcc-frozen-${GITHUB_RUN_ID:-local}-${GITHUB_RUN_ATTEMPT:-1}"
TMP="$(mktemp -d)"
UID_BUILD="$(id -u)"
RESTORED=false
cleanup(){ docker rm -f "$CONTAINER" >/dev/null 2>&1 || true; rm -rf "$TMP"; }
trap cleanup EXIT
for c in docker gh tar zstd split jq sha256sum; do command -v "$c" >/dev/null || die "Missing command: $c"; done

# Prove nanosecond timestamps survive the archive format before an expensive build.
mkdir "$TMP/probe" "$TMP/probe-out"
touch -d '2026-10-26 21:10:34.765182049 UTC' "$TMP/probe/file"
tar --format=pax -cf "$TMP/probe.tar" -C "$TMP/probe" file
tar -xpf "$TMP/probe.tar" -C "$TMP/probe-out"
[[ "$(stat -c %y "$TMP/probe/file")" == "$(stat -c %y "$TMP/probe-out/file")" ]] ||
  die "PAX timestamp preservation test failed."

rm -rf "$ROOT"; mkdir -p "$ROOT"
if [[ "$RESET_CHECKPOINT" != true ]]; then
  if RELEASE="$(gh api "repos/$GITHUB_REPOSITORY/releases/tags/$STATE_TAG" 2>"$TMP/release.err")"; then
    RID="$(jq -r .id <<<"$RELEASE")"
    ASSET_NAMES_JSON="$(gh api "repos/$GITHUB_REPOSITORY/releases/$RID/assets?per_page=100")" ||
      die "Could not list checkpoint assets; refusing to treat an API failure as an empty checkpoint."
    mapfile -t MANIFESTS < <(jq -r '.[].name' <<<"$ASSET_NAMES_JSON" |
      grep -E '^gcc12-manifest-[0-9]+-[0-9]+\.json
    for MN in "${MANIFESTS[@]}"; do
      C="$TMP/candidate"; rm -rf "$C"; mkdir -p "$C"
      gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$MN" --dir "$C" >/dev/null 2>&1 || continue
      M="$C/$MN"
      jq -e '.schema==1 and .source_package=="gcc-12" and (.generation|type=="string") and (.parts|type=="array" and length>0)' "$M" >/dev/null 2>&1 || continue
      G="$(jq -r .generation "$M")"; VALID=true; PARTS=()
      while IFS=$'\t' read -r N S; do
        [[ "$N" == "gcc12-state-$G.part"* && "$N" =~ ^gcc12-state-[0-9]+-[0-9]+\.part[0-9]{4}$ && "$S" =~ ^[a-f0-9]{64}$ ]] || { VALID=false; break; }
        gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$N" --dir "$C" >/dev/null 2>&1 || { VALID=false; break; }
        printf '%s  %s\n' "$S" "$C/$N" | sha256sum --check --status || { VALID=false; break; }
        PARTS+=("$C/$N")
      done < <(jq -r '.parts[]|[.name,.sha256]|@tsv' "$M")
      [[ "$VALID" == true && ${#PARTS[@]} -gt 0 ]] || continue
      if cat "${PARTS[@]}" | zstd -q -d -c | tar -xpf - -C "$ROOT" &&
         [[ -s "$ROOT/state.json" ]] &&
         [[ "$(jq -r '.source_package // empty' "$ROOT/state.json")" == gcc-12 ]]; then
        RESTORED=true; echo "Restored verified GCC checkpoint $G."; break
      fi
      rm -rf "$ROOT"; mkdir -p "$ROOT"
    done
  elif grep -Eqi 'HTTP 404|Not Found|release not found' "$TMP/release.err"; then
    echo "No prior GCC checkpoint; initialize a new build."
  else
    cat "$TMP/release.err" >&2
    die "Could not inspect checkpoint release; refusing to discard potentially valid state."
  fi
else
  echo "Reset requested; old checkpoint stays available until a new one is verified."
fi
if [[ "$RESTORED" != true ]]; then rm -rf "$ROOT"; mkdir -p "$ROOT/source-tree"; fi

docker pull debian:12
docker create --name "$CONTAINER" -v "$ROOT:/work" debian:12 sleep infinity >/dev/null
docker start "$CONTAINER" >/dev/null

docker exec -i -e BUILD_UID="$UID_BUILD" "$CONTAINER" bash -s <<'PREP'
set -Eeuo pipefail
export DEBIAN_FRONTEND=noninteractive
rm -f /etc/apt/sources.list.d/debian.sources
cat >/etc/apt/sources.list.d/core2-gcc.list <<'APT'
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb http://deb.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
APT
apt-get update
apt-get install -y --no-install-recommends build-essential devscripts debhelper dpkg-dev fakeroot ca-certificates curl file xz-utils zstd jq cmake meson ninja-build python3 pkg-config quilt bc flex bison gawk
apt-get build-dep -y gcc-12
id core2build >/dev/null 2>&1 || useradd -m -s /bin/bash -o -u "$BUILD_UID" core2build

if [[ ! -s /work/state.json ]]; then
  cd /work/source-tree
  apt-get source gcc-12
  SD="$(find /work/source-tree -mindepth 1 -maxdepth 1 -type d -name 'gcc-12-*' -print -quit)"
  [[ -s "$SD/debian/changelog" ]] || { echo "GCC source unpacking failed" >&2; exit 1; }
  SV="$(dpkg-parsechangelog -l "$SD/debian/changelog" -S Version)"
  PV="${SV}+core2.1~$(date -u +%Y%m%d%H%M%S)"
  cd "$SD"
  dch --newversion "$PV" --distribution bookworm --force-distribution 'Core 2 optimized GCC 12 and runtime/development libraries.'
  [[ "$(dpkg-parsechangelog -l "$SD/debian/changelog" -S Version)" == "$PV" ]]
  find /work/source-tree -maxdepth 1 -type f \( -name '*.dsc' -o -name '*.orig.tar.*' -o -name '*.debian.tar.*' -o -name '*.diff.gz' -o -name '*.tar.gz' -o -name '*.tar.xz' -o -name '*.tar.bz2' -o -name '*.tar.zst' \) -delete
  SDREL="${SD#/work/}"
  [[ "$SDREL" =~ ^source-tree/[A-Za-z0-9.+_-]+$ ]] || { echo "Unsafe source dir" >&2; exit 1; }
  jq -n --arg source_package gcc-12 --arg source_dir "$SDREL" --arg source_version "$SV" --arg package_version "$PV" --arg optimization_level=-O2 '{schema:1,source_package:$source_package,source_dir:$source_dir,source_version:$source_version,package_version:$package_version,optimization_level:$optimization_level}' >/work/state.json
  chown "$BUILD_UID:$BUILD_UID" /work/state.json
  chown -R "$BUILD_UID:$BUILD_UID" /work/source-tree
  export DEB_CFLAGS_MAINT_APPEND='-O2 -march=core2 -mtune=core2' DEB_CXXFLAGS_MAINT_APPEND='-O2 -march=core2 -mtune=core2' DEB_FFLAGS_MAINT_APPEND='-O2 -march=core2 -mtune=core2'
  CFLAGS="$(dpkg-buildflags --get CFLAGS)"; CXXFLAGS="$(dpkg-buildflags --get CXXFLAGS)"
  grep -q -- -march=core2 <<<"$CFLAGS"; grep -q -- -mtune=core2 <<<"$CFLAGS"
  grep -q -- -march=core2 <<<"$CXXFLAGS"; grep -q -- -mtune=core2 <<<"$CXXFLAGS"
  printf 'CFLAGS=%s\nCXXFLAGS=%s\n' "$CFLAGS" "$CXXFLAGS" >/work/build-flags.txt
  chown "$BUILD_UID:$BUILD_UID" /work/build-flags.txt
fi

SDREL="$(jq -r .source_dir /work/state.json)"
[[ "$SDREL" =~ ^source-tree/[A-Za-z0-9.+_-]+$ && -s "/work/$SDREL/debian/changelog" ]] || { echo "Checkpoint has invalid source tree" >&2; exit 1; }
SOURCE_DIR="/work/${SDREL%/}/"
test -s "${SOURCE_DIR}debian/dummy.texi" || { echo "Missing GCC packaging dummy.texi" >&2; exit 1; }
echo "Prepared $SOURCE_DIR at version $(jq -r .package_version /work/state.json)"
PREP

SDREL="$(jq -r .source_dir "$ROOT/state.json")"
SV="$(jq -r .source_version "$ROOT/state.json")"
PV="$(jq -r .package_version "$ROOT/state.json")"
OPT="$(jq -r .optimization_level "$ROOT/state.json")"
[[ "$PV" =~ ^[0-9A-Za-z.+:~_-]+$ && "$SV" =~ ^[0-9A-Za-z.+:~_-]+$ ]] || die "Unsafe version in checkpoint."
[[ -s "$ROOT/build-flags.txt" ]] || die "Build flags missing."
echo "Object/archive files before segment: $(find "$ROOT/source-tree" -type f \( -name '*.o' -o -name '*.a' \) | wc -l)"
set +e
docker exec -e SOURCE_DIR="/work/${SDREL%/}/" \
  -e DEB_CFLAGS_MAINT_APPEND="-O2 -march=core2 -mtune=core2" \
  -e DEB_CXXFLAGS_MAINT_APPEND="-O2 -march=core2 -mtune=core2" \
  -e DEB_FFLAGS_MAINT_APPEND="-O2 -march=core2 -mtune=core2" \
  -e DEB_BUILD_OPTIONS="parallel=2 noautodbgsym" "$CONTAINER" bash -c '
    set -o pipefail
    runuser --preserve-environment -u core2build -- env HOME=/home/core2build USER=core2build LOGNAME=core2build \
      SOURCE_DIR="$SOURCE_DIR" DEB_CFLAGS_MAINT_APPEND="$DEB_CFLAGS_MAINT_APPEND" \
      DEB_CXXFLAGS_MAINT_APPEND="$DEB_CXXFLAGS_MAINT_APPEND" DEB_FFLAGS_MAINT_APPEND="$DEB_FFLAGS_MAINT_APPEND" \
      DEB_BUILD_OPTIONS="$DEB_BUILD_OPTIONS" \
      bash -c '"'"'cd "$SOURCE_DIR" && exec timeout --signal=INT --kill-after=90s 205m dpkg-buildpackage -rfakeroot -us -uc -b -nc -j2'"'"' \
      2>&1 | tee -a /work/build.log
  '
BUILD_STATUS=$?
set -e
echo "dpkg-buildpackage status=$BUILD_STATUS; object/archive files afterward: $(find "$ROOT/source-tree" -type f \( -name '*.o' -o -name '*.a' \) | wc -l)"

checkpoint_state(){
  [[ -s "$ROOT/state.json" ]] || die "No build state to checkpoint."
  local prefix="$TMP/gcc12-state-$GEN.part" manifest="$TMP/gcc12-manifest-$GEN.json" lines="$TMP/parts.jsonl"
  tar --format=pax --numeric-owner --acls --xattrs -cf - -C "$ROOT" \
    --exclude='*.deb' --exclude='*.changes' --exclude='*.buildinfo' . |
    zstd -q -T0 -3 -c | split -b 1400M -d -a 4 - "$prefix"
  shopt -s nullglob
  local parts=( "$TMP"/gcc12-state-"$GEN".part* )
  (( ${#parts[@]} > 0 )) || die "Snapshot produced no parts."
  : >"$lines"
  for p in "${parts[@]}"; do
    jq -cn --arg name "$(basename "$p")" --arg sha256 "$(sha256sum "$p"|awk '{print $1}')" '{name:$name,sha256:$sha256}' >>"$lines"
  done
  jq -n --arg generation "$GEN" --arg source_package gcc-12 --arg source_version "$SV" --arg package_version "$PV" --argjson parts "$(jq -s . "$lines")" \
    '{schema:1,generation:$generation,source_package:$source_package,source_version:$source_version,package_version:$package_version,parts:$parts}' >"$manifest"
  if ! gh api "repos/$GITHUB_REPOSITORY/releases/tags/$STATE_TAG" >"$TMP/existing-release.json" 2>"$TMP/create-release.err"; then
    if grep -Eqi 'HTTP 404|Not Found|release not found' "$TMP/create-release.err"; then
      gh release create "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --title "Resumable GCC 12 build state" \
        --notes "Verified PAX-format disk snapshots for incremental Debian GCC 12 builds. A generation manifest is uploaded last."
    else
      cat "$TMP/create-release.err" >&2
      die "Could not inspect checkpoint release before uploading a new snapshot."
    fi
  fi
  gh release upload "$STATE_TAG" "${parts[@]}" --repo "$GITHUB_REPOSITORY"
  gh release upload "$STATE_TAG" "$manifest" --repo "$GITHUB_REPOSITORY"
  local verify="$TMP/verified"; mkdir -p "$verify"
  gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$(basename "$manifest")" --dir "$verify"
  cmp -s "$manifest" "$verify/$(basename "$manifest")" || die "Published manifest verification failed."
  while IFS=$'\t' read -r n s; do
    gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$n" --dir "$verify"
    printf '%s  %s\n' "$s" "$verify/$n" | sha256sum -c -
  done < <(jq -r '.parts[]|[.name,.sha256]|@tsv' "$manifest")
  local rid assets_json
  rid="$(gh api "repos/$GITHUB_REPOSITORY/releases/tags/$STATE_TAG" --jq .id)"
  assets_json="$(gh api "repos/$GITHUB_REPOSITORY/releases/$rid/assets?per_page=100")" ||
    die "Could not list checkpoint assets after publishing the new generation."
  while IFS=
  echo "Checkpoint $GEN uploaded and verified."
}

if [[ "$BUILD_STATUS" -eq 124 ]]; then
  checkpoint_state
  gh workflow run d630-core2-gcc-frozen-build.yml --repo "$GITHUB_REPOSITORY" --ref master -f stage=gcc-12 -f reset_checkpoint=false -f force_rebuild=true
  echo "Queued next incremental GCC segment."
  exit 0
elif [[ "$BUILD_STATUS" -ne 0 ]]; then
  checkpoint_state
  die "GCC build failed (status $BUILD_STATUS); state saved for diagnosis and retry."
fi

shopt -s nullglob
DEBS=( "$ROOT"/source-tree/*.deb )
(( ${#DEBS[@]} > 0 )) || die "Build succeeded but produced no Debian packages."
mkdir -p "$ROOT/release-artifacts"; rm -f "$ROOT/release-artifacts/"*
OK_DEBS=()
for deb in "${DEBS[@]}"; do
  pkg="$(dpkg-deb -f "$deb" Package)"; ver="$(dpkg-deb -f "$deb" Version)"; arch="$(dpkg-deb -f "$deb" Architecture)"
  case "$pkg" in *-dbg|*-dbgsym) rm -f "$deb"; continue;; esac
  [[ "$ver" == "$PV" ]] || die "Wrong package version in $(basename "$deb"): $ver"
  case "$arch" in amd64|all) ;; *) die "Unexpected architecture $arch";; esac
  OK_DEBS+=("$deb")
done
(( ${#OK_DEBS[@]} > 0 )) || die "No non-debug GCC packages remain."
for deb in "${OK_DEBS[@]}"; do cp "$deb" "$ROOT/release-artifacts/"; done
cp "$ROOT/build-flags.txt" "$ROOT/release-artifacts/CORE2-BUILD-FLAGS.txt"
{
  echo "Source package: gcc-12"
  echo "Bookworm source version: $SV"
  echo "Core 2 package version: $PV"
  echo "Target: amd64 / Intel Core 2 Duo"
  echo "Flags: -O2 -march=core2 -mtune=core2"
  echo "Build: resumable incremental Debian package build with verified PAX disk snapshots"
  echo "Debug-symbol packages excluded."
  echo
  for deb in "${OK_DEBS[@]}"; do printf '%s %s %s\n' "$(dpkg-deb -f "$deb" Package)" "$(dpkg-deb -f "$deb" Version)" "$(dpkg-deb -f "$deb" Architecture)"; done
} >"$ROOT/release-artifacts/BUILD-INFO.txt"
(cd "$ROOT/release-artifacts" && sha256sum ./*.deb > SHA256SUMS-core2-gcc-12.txt)

TAG_VER="$(printf '%s' "$PV" | sed -E 's/[^A-Za-z0-9._-]+/-/g')"
RELEASE_TAG="core2-system-gcc-12-$TAG_VER"
if gh release view "$RELEASE_TAG" --repo "$GITHUB_REPOSITORY" >/dev/null 2>&1; then die "Release $RELEASE_TAG already exists; refusing to overwrite."; fi
export PACKAGE=gcc-12 SOURCE_VERSION="$SV" PACKAGE_VERSION="$PV" RELEASE_TAG OPT_LEVEL="$OPT" RELEASE_KIND=system
cd "$ROOT/release-artifacts"
python3 "$GITHUB_WORKSPACE/core2-packages/release-notes.py"
TITLE="$(cat release-title.txt)"
rm -f release-title.txt
ASSETS=( ./*.deb ./*.txt )
(( ${#ASSETS[@]} > 0 )) || die "No release assets staged."
gh release create "$RELEASE_TAG" "${ASSETS[@]}" --repo "$GITHUB_REPOSITORY" --title "$TITLE" --notes-file release-notes.md
echo "Published GCC runtime/development packages: $RELEASE_TAG"

gh release delete "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --yes --cleanup-tag || echo "::warning::Package release succeeded but checkpoint cleanup failed."
gh workflow run d630-core2-gcc-frozen-build.yml --repo "$GITHUB_REPOSITORY" --ref master -f stage=defaults -f reset_checkpoint=false -f force_rebuild=true
echo "Queued gcc/cpp default packages after GCC 12 publication."
 | sort -t- -k3,3nr -k4,4nr || true)
    for MN in "${MANIFESTS[@]}"; do
      C="$TMP/candidate"; rm -rf "$C"; mkdir -p "$C"
      gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$MN" --dir "$C" >/dev/null 2>&1 || continue
      M="$C/$MN"
      jq -e '.schema==1 and .source_package=="gcc-12" and (.generation|type=="string") and (.parts|type=="array" and length>0)' "$M" >/dev/null 2>&1 || continue
      G="$(jq -r .generation "$M")"; VALID=true; PARTS=()
      while IFS=$'\t' read -r N S; do
        [[ "$N" == "gcc12-state-$G.part"* && "$N" =~ ^gcc12-state-[0-9]+-[0-9]+\.part[0-9]{4}$ && "$S" =~ ^[a-f0-9]{64}$ ]] || { VALID=false; break; }
        gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$N" --dir "$C" >/dev/null 2>&1 || { VALID=false; break; }
        printf '%s  %s\n' "$S" "$C/$N" | sha256sum --check --status || { VALID=false; break; }
        PARTS+=("$C/$N")
      done < <(jq -r '.parts[]|[.name,.sha256]|@tsv' "$M")
      [[ "$VALID" == true && ${#PARTS[@]} -gt 0 ]] || continue
      if cat "${PARTS[@]}" | zstd -q -d -c | tar -xpf - -C "$ROOT" &&
         [[ -s "$ROOT/state.json" ]] &&
         [[ "$(jq -r '.source_package // empty' "$ROOT/state.json")" == gcc-12 ]]; then
        RESTORED=true; echo "Restored verified GCC checkpoint $G."; break
      fi
      rm -rf "$ROOT"; mkdir -p "$ROOT"
    done
  elif grep -Eqi 'HTTP 404|Not Found|release not found' "$TMP/release.err"; then
    echo "No prior GCC checkpoint; initialize a new build."
  else
    cat "$TMP/release.err" >&2
    die "Could not inspect checkpoint release; refusing to discard potentially valid state."
  fi
else
  echo "Reset requested; old checkpoint stays available until a new one is verified."
fi
if [[ "$RESTORED" != true ]]; then rm -rf "$ROOT"; mkdir -p "$ROOT/source-tree"; fi

docker pull debian:12
docker create --name "$CONTAINER" -v "$ROOT:/work" debian:12 sleep infinity >/dev/null
docker start "$CONTAINER" >/dev/null

docker exec -i -e BUILD_UID="$UID_BUILD" "$CONTAINER" bash -s <<'PREP'
set -Eeuo pipefail
export DEBIAN_FRONTEND=noninteractive
rm -f /etc/apt/sources.list.d/debian.sources
cat >/etc/apt/sources.list.d/core2-gcc.list <<'APT'
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb http://deb.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
APT
apt-get update
apt-get install -y --no-install-recommends build-essential devscripts debhelper dpkg-dev fakeroot ca-certificates curl file xz-utils zstd jq cmake meson ninja-build python3 pkg-config quilt bc flex bison gawk
apt-get build-dep -y gcc-12
id core2build >/dev/null 2>&1 || useradd -m -s /bin/bash -o -u "$BUILD_UID" core2build

if [[ ! -s /work/state.json ]]; then
  cd /work/source-tree
  apt-get source gcc-12
  SD="$(find /work/source-tree -mindepth 1 -maxdepth 1 -type d -name 'gcc-12-*' -print -quit)"
  [[ -s "$SD/debian/changelog" ]] || { echo "GCC source unpacking failed" >&2; exit 1; }
  SV="$(dpkg-parsechangelog -l "$SD/debian/changelog" -S Version)"
  PV="${SV}+core2.1~$(date -u +%Y%m%d%H%M%S)"
  cd "$SD"
  dch --newversion "$PV" --distribution bookworm --force-distribution 'Core 2 optimized GCC 12 and runtime/development libraries.'
  [[ "$(dpkg-parsechangelog -l "$SD/debian/changelog" -S Version)" == "$PV" ]]
  find /work/source-tree -maxdepth 1 -type f \( -name '*.dsc' -o -name '*.orig.tar.*' -o -name '*.debian.tar.*' -o -name '*.diff.gz' -o -name '*.tar.gz' -o -name '*.tar.xz' -o -name '*.tar.bz2' -o -name '*.tar.zst' \) -delete
  SDREL="${SD#/work/}"
  [[ "$SDREL" =~ ^source-tree/[A-Za-z0-9.+_-]+$ ]] || { echo "Unsafe source dir" >&2; exit 1; }
  jq -n --arg source_package gcc-12 --arg source_dir "$SDREL" --arg source_version "$SV" --arg package_version "$PV" --arg optimization_level=-O2 '{schema:1,source_package:$source_package,source_dir:$source_dir,source_version:$source_version,package_version:$package_version,optimization_level:$optimization_level}' >/work/state.json
  chown "$BUILD_UID:$BUILD_UID" /work/state.json
  chown -R "$BUILD_UID:$BUILD_UID" /work/source-tree
  export DEB_CFLAGS_MAINT_APPEND='-O2 -march=core2 -mtune=core2' DEB_CXXFLAGS_MAINT_APPEND='-O2 -march=core2 -mtune=core2' DEB_FFLAGS_MAINT_APPEND='-O2 -march=core2 -mtune=core2'
  CFLAGS="$(dpkg-buildflags --get CFLAGS)"; CXXFLAGS="$(dpkg-buildflags --get CXXFLAGS)"
  grep -q -- -march=core2 <<<"$CFLAGS"; grep -q -- -mtune=core2 <<<"$CFLAGS"
  grep -q -- -march=core2 <<<"$CXXFLAGS"; grep -q -- -mtune=core2 <<<"$CXXFLAGS"
  printf 'CFLAGS=%s\nCXXFLAGS=%s\n' "$CFLAGS" "$CXXFLAGS" >/work/build-flags.txt
  chown "$BUILD_UID:$BUILD_UID" /work/build-flags.txt
fi

SDREL="$(jq -r .source_dir /work/state.json)"
[[ "$SDREL" =~ ^source-tree/[A-Za-z0-9.+_-]+$ && -s "/work/$SDREL/debian/changelog" ]] || { echo "Checkpoint has invalid source tree" >&2; exit 1; }
SOURCE_DIR="/work/${SDREL%/}/"
test -s "${SOURCE_DIR}debian/dummy.texi" || { echo "Missing GCC packaging dummy.texi" >&2; exit 1; }
echo "Prepared $SOURCE_DIR at version $(jq -r .package_version /work/state.json)"
PREP

SDREL="$(jq -r .source_dir "$ROOT/state.json")"
SV="$(jq -r .source_version "$ROOT/state.json")"
PV="$(jq -r .package_version "$ROOT/state.json")"
OPT="$(jq -r .optimization_level "$ROOT/state.json")"
[[ "$PV" =~ ^[0-9A-Za-z.+:~_-]+$ && "$SV" =~ ^[0-9A-Za-z.+:~_-]+$ ]] || die "Unsafe version in checkpoint."
[[ -s "$ROOT/build-flags.txt" ]] || die "Build flags missing."
echo "Object/archive files before segment: $(find "$ROOT/source-tree" -type f \( -name '*.o' -o -name '*.a' \) | wc -l)"
set +e
docker exec -e SOURCE_DIR="/work/${SDREL%/}/" \
  -e DEB_CFLAGS_MAINT_APPEND="-O2 -march=core2 -mtune=core2" \
  -e DEB_CXXFLAGS_MAINT_APPEND="-O2 -march=core2 -mtune=core2" \
  -e DEB_FFLAGS_MAINT_APPEND="-O2 -march=core2 -mtune=core2" \
  -e DEB_BUILD_OPTIONS="parallel=2 noautodbgsym" "$CONTAINER" bash -c '
    set -o pipefail
    runuser --preserve-environment -u core2build -- env HOME=/home/core2build USER=core2build LOGNAME=core2build \
      SOURCE_DIR="$SOURCE_DIR" DEB_CFLAGS_MAINT_APPEND="$DEB_CFLAGS_MAINT_APPEND" \
      DEB_CXXFLAGS_MAINT_APPEND="$DEB_CXXFLAGS_MAINT_APPEND" DEB_FFLAGS_MAINT_APPEND="$DEB_FFLAGS_MAINT_APPEND" \
      DEB_BUILD_OPTIONS="$DEB_BUILD_OPTIONS" \
      bash -c '"'"'cd "$SOURCE_DIR" && exec timeout --signal=INT --kill-after=90s 205m dpkg-buildpackage -rfakeroot -us -uc -b -nc -j2'"'"' \
      2>&1 | tee -a /work/build.log
  '
BUILD_STATUS=$?
set -e
echo "dpkg-buildpackage status=$BUILD_STATUS; object/archive files afterward: $(find "$ROOT/source-tree" -type f \( -name '*.o' -o -name '*.a' \) | wc -l)"

checkpoint_state(){
  [[ -s "$ROOT/state.json" ]] || die "No build state to checkpoint."
  local prefix="$TMP/gcc12-state-$GEN.part" manifest="$TMP/gcc12-manifest-$GEN.json" lines="$TMP/parts.jsonl"
  tar --format=pax --numeric-owner --acls --xattrs -cf - -C "$ROOT" \
    --exclude='*.deb' --exclude='*.changes' --exclude='*.buildinfo' . |
    zstd -q -T0 -3 -c | split -b 1400M -d -a 4 - "$prefix"
  shopt -s nullglob
  local parts=( "$TMP"/gcc12-state-"$GEN".part* )
  (( ${#parts[@]} > 0 )) || die "Snapshot produced no parts."
  : >"$lines"
  for p in "${parts[@]}"; do
    jq -cn --arg name "$(basename "$p")" --arg sha256 "$(sha256sum "$p"|awk '{print $1}')" '{name:$name,sha256:$sha256}' >>"$lines"
  done
  jq -n --arg generation "$GEN" --arg source_package gcc-12 --arg source_version "$SV" --arg package_version "$PV" --argjson parts "$(jq -s . "$lines")" \
    '{schema:1,generation:$generation,source_package:$source_package,source_version:$source_version,package_version:$package_version,parts:$parts}' >"$manifest"
  if ! gh api "repos/$GITHUB_REPOSITORY/releases/tags/$STATE_TAG" >/dev/null 2>&1; then
    gh release create "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --title "Resumable GCC 12 build state" \
      --notes "Verified PAX-format disk snapshots for incremental Debian GCC 12 builds. A generation manifest is uploaded last."
  fi
  gh release upload "$STATE_TAG" "${parts[@]}" --repo "$GITHUB_REPOSITORY"
  gh release upload "$STATE_TAG" "$manifest" --repo "$GITHUB_REPOSITORY"
  local verify="$TMP/verified"; mkdir -p "$verify"
  gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$(basename "$manifest")" --dir "$verify"
  cmp -s "$manifest" "$verify/$(basename "$manifest")" || die "Published manifest verification failed."
  while IFS=$'\t' read -r n s; do
    gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$n" --dir "$verify"
    printf '%s  %s\n' "$s" "$verify/$n" | sha256sum -c -
  done < <(jq -r '.parts[]|[.name,.sha256]|@tsv' "$manifest")
  local rid
  rid="$(gh api "repos/$GITHUB_REPOSITORY/releases/tags/$STATE_TAG" --jq .id)"
  while IFS=$'\t' read -r aid aname; do
    [[ "$aname" == "gcc12-manifest-$GEN.json" || "$aname" == gcc12-state-"$GEN".part* ]] && continue
    if [[ "$aname" =~ ^gcc12-(manifest|state)- ]]; then
      gh api -X DELETE "repos/$GITHUB_REPOSITORY/releases/assets/$aid" >/dev/null || echo "::warning::Could not prune old checkpoint asset $aname."
    fi
  done < <(gh api "repos/$GITHUB_REPOSITORY/releases/$rid/assets?per_page=100" --jq '.[]|[.id,.name]|@tsv')
  echo "Checkpoint $GEN uploaded and verified."
}

if [[ "$BUILD_STATUS" -eq 124 ]]; then
  checkpoint_state
  gh workflow run d630-core2-gcc-frozen-build.yml --repo "$GITHUB_REPOSITORY" --ref master -f stage=gcc-12 -f reset_checkpoint=false -f force_rebuild=true
  echo "Queued next incremental GCC segment."
  exit 0
elif [[ "$BUILD_STATUS" -ne 0 ]]; then
  checkpoint_state
  die "GCC build failed (status $BUILD_STATUS); state saved for diagnosis and retry."
fi

shopt -s nullglob
DEBS=( "$ROOT"/source-tree/*.deb )
(( ${#DEBS[@]} > 0 )) || die "Build succeeded but produced no Debian packages."
mkdir -p "$ROOT/release-artifacts"; rm -f "$ROOT/release-artifacts/"*
OK_DEBS=()
for deb in "${DEBS[@]}"; do
  pkg="$(dpkg-deb -f "$deb" Package)"; ver="$(dpkg-deb -f "$deb" Version)"; arch="$(dpkg-deb -f "$deb" Architecture)"
  case "$pkg" in *-dbg|*-dbgsym) rm -f "$deb"; continue;; esac
  [[ "$ver" == "$PV" ]] || die "Wrong package version in $(basename "$deb"): $ver"
  case "$arch" in amd64|all) ;; *) die "Unexpected architecture $arch";; esac
  OK_DEBS+=("$deb")
done
(( ${#OK_DEBS[@]} > 0 )) || die "No non-debug GCC packages remain."
for deb in "${OK_DEBS[@]}"; do cp "$deb" "$ROOT/release-artifacts/"; done
cp "$ROOT/build-flags.txt" "$ROOT/release-artifacts/CORE2-BUILD-FLAGS.txt"
{
  echo "Source package: gcc-12"
  echo "Bookworm source version: $SV"
  echo "Core 2 package version: $PV"
  echo "Target: amd64 / Intel Core 2 Duo"
  echo "Flags: -O2 -march=core2 -mtune=core2"
  echo "Build: resumable incremental Debian package build with verified PAX disk snapshots"
  echo "Debug-symbol packages excluded."
  echo
  for deb in "${OK_DEBS[@]}"; do printf '%s %s %s\n' "$(dpkg-deb -f "$deb" Package)" "$(dpkg-deb -f "$deb" Version)" "$(dpkg-deb -f "$deb" Architecture)"; done
} >"$ROOT/release-artifacts/BUILD-INFO.txt"
(cd "$ROOT/release-artifacts" && sha256sum ./*.deb > SHA256SUMS-core2-gcc-12.txt)

TAG_VER="$(printf '%s' "$PV" | sed -E 's/[^A-Za-z0-9._-]+/-/g')"
RELEASE_TAG="core2-system-gcc-12-$TAG_VER"
if gh release view "$RELEASE_TAG" --repo "$GITHUB_REPOSITORY" >/dev/null 2>&1; then die "Release $RELEASE_TAG already exists; refusing to overwrite."; fi
export PACKAGE=gcc-12 SOURCE_VERSION="$SV" PACKAGE_VERSION="$PV" RELEASE_TAG OPT_LEVEL="$OPT" RELEASE_KIND=system
cd "$ROOT/release-artifacts"
python3 "$GITHUB_WORKSPACE/core2-packages/release-notes.py"
TITLE="$(cat release-title.txt)"
ASSETS=( ./*.deb ./*.txt )
(( ${#ASSETS[@]} > 0 )) || die "No release assets staged."
gh release create "$RELEASE_TAG" "${ASSETS[@]}" --repo "$GITHUB_REPOSITORY" --title "$TITLE" --notes-file release-notes.md
echo "Published GCC runtime/development packages: $RELEASE_TAG"

gh release delete "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --yes --cleanup-tag || echo "::warning::Package release succeeded but checkpoint cleanup failed."
gh workflow run d630-core2-gcc-frozen-build.yml --repo "$GITHUB_REPOSITORY" --ref master -f stage=defaults -f reset_checkpoint=false -f force_rebuild=true
echo "Queued gcc/cpp default packages after GCC 12 publication."
\t' read -r aid aname; do
    [[ "$aname" == "gcc12-manifest-$GEN.json" || "$aname" == gcc12-state-"$GEN".part* ]] && continue
    if [[ "$aname" =~ ^gcc12-(manifest|state)- ]]; then
      gh api -X DELETE "repos/$GITHUB_REPOSITORY/releases/assets/$aid" >/dev/null || echo "::warning::Could not prune old checkpoint asset $aname."
    fi
  done < <(jq -r '.[]|[.id,.name]|@tsv' <<<"$assets_json")
  echo "Checkpoint $GEN uploaded and verified."
}

if [[ "$BUILD_STATUS" -eq 124 ]]; then
  checkpoint_state
  gh workflow run d630-core2-gcc-frozen-build.yml --repo "$GITHUB_REPOSITORY" --ref master -f stage=gcc-12 -f reset_checkpoint=false -f force_rebuild=true
  echo "Queued next incremental GCC segment."
  exit 0
elif [[ "$BUILD_STATUS" -ne 0 ]]; then
  checkpoint_state
  die "GCC build failed (status $BUILD_STATUS); state saved for diagnosis and retry."
fi

shopt -s nullglob
DEBS=( "$ROOT"/source-tree/*.deb )
(( ${#DEBS[@]} > 0 )) || die "Build succeeded but produced no Debian packages."
mkdir -p "$ROOT/release-artifacts"; rm -f "$ROOT/release-artifacts/"*
OK_DEBS=()
for deb in "${DEBS[@]}"; do
  pkg="$(dpkg-deb -f "$deb" Package)"; ver="$(dpkg-deb -f "$deb" Version)"; arch="$(dpkg-deb -f "$deb" Architecture)"
  case "$pkg" in *-dbg|*-dbgsym) rm -f "$deb"; continue;; esac
  [[ "$ver" == "$PV" ]] || die "Wrong package version in $(basename "$deb"): $ver"
  case "$arch" in amd64|all) ;; *) die "Unexpected architecture $arch";; esac
  OK_DEBS+=("$deb")
done
(( ${#OK_DEBS[@]} > 0 )) || die "No non-debug GCC packages remain."
for deb in "${OK_DEBS[@]}"; do cp "$deb" "$ROOT/release-artifacts/"; done
cp "$ROOT/build-flags.txt" "$ROOT/release-artifacts/CORE2-BUILD-FLAGS.txt"
{
  echo "Source package: gcc-12"
  echo "Bookworm source version: $SV"
  echo "Core 2 package version: $PV"
  echo "Target: amd64 / Intel Core 2 Duo"
  echo "Flags: -O2 -march=core2 -mtune=core2"
  echo "Build: resumable incremental Debian package build with verified PAX disk snapshots"
  echo "Debug-symbol packages excluded."
  echo
  for deb in "${OK_DEBS[@]}"; do printf '%s %s %s\n' "$(dpkg-deb -f "$deb" Package)" "$(dpkg-deb -f "$deb" Version)" "$(dpkg-deb -f "$deb" Architecture)"; done
} >"$ROOT/release-artifacts/BUILD-INFO.txt"
(cd "$ROOT/release-artifacts" && sha256sum ./*.deb > SHA256SUMS-core2-gcc-12.txt)

TAG_VER="$(printf '%s' "$PV" | sed -E 's/[^A-Za-z0-9._-]+/-/g')"
RELEASE_TAG="core2-system-gcc-12-$TAG_VER"
if gh release view "$RELEASE_TAG" --repo "$GITHUB_REPOSITORY" >/dev/null 2>&1; then die "Release $RELEASE_TAG already exists; refusing to overwrite."; fi
export PACKAGE=gcc-12 SOURCE_VERSION="$SV" PACKAGE_VERSION="$PV" RELEASE_TAG OPT_LEVEL="$OPT" RELEASE_KIND=system
cd "$ROOT/release-artifacts"
python3 "$GITHUB_WORKSPACE/core2-packages/release-notes.py"
TITLE="$(cat release-title.txt)"
ASSETS=( ./*.deb ./*.txt )
(( ${#ASSETS[@]} > 0 )) || die "No release assets staged."
gh release create "$RELEASE_TAG" "${ASSETS[@]}" --repo "$GITHUB_REPOSITORY" --title "$TITLE" --notes-file release-notes.md
echo "Published GCC runtime/development packages: $RELEASE_TAG"

gh release delete "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --yes --cleanup-tag || echo "::warning::Package release succeeded but checkpoint cleanup failed."
gh workflow run d630-core2-gcc-frozen-build.yml --repo "$GITHUB_REPOSITORY" --ref master -f stage=defaults -f reset_checkpoint=false -f force_rebuild=true
echo "Queued gcc/cpp default packages after GCC 12 publication."
 | sort -t- -k3,3nr -k4,4nr || true)
    for MN in "${MANIFESTS[@]}"; do
      C="$TMP/candidate"; rm -rf "$C"; mkdir -p "$C"
      gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$MN" --dir "$C" >/dev/null 2>&1 || continue
      M="$C/$MN"
      jq -e '.schema==1 and .source_package=="gcc-12" and (.generation|type=="string") and (.parts|type=="array" and length>0)' "$M" >/dev/null 2>&1 || continue
      G="$(jq -r .generation "$M")"; VALID=true; PARTS=()
      while IFS=$'\t' read -r N S; do
        [[ "$N" == "gcc12-state-$G.part"* && "$N" =~ ^gcc12-state-[0-9]+-[0-9]+\.part[0-9]{4}$ && "$S" =~ ^[a-f0-9]{64}$ ]] || { VALID=false; break; }
        gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$N" --dir "$C" >/dev/null 2>&1 || { VALID=false; break; }
        printf '%s  %s\n' "$S" "$C/$N" | sha256sum --check --status || { VALID=false; break; }
        PARTS+=("$C/$N")
      done < <(jq -r '.parts[]|[.name,.sha256]|@tsv' "$M")
      [[ "$VALID" == true && ${#PARTS[@]} -gt 0 ]] || continue
      if cat "${PARTS[@]}" | zstd -q -d -c | tar -xpf - -C "$ROOT" &&
         [[ -s "$ROOT/state.json" ]] &&
         [[ "$(jq -r '.source_package // empty' "$ROOT/state.json")" == gcc-12 ]]; then
        RESTORED=true; echo "Restored verified GCC checkpoint $G."; break
      fi
      rm -rf "$ROOT"; mkdir -p "$ROOT"
    done
  elif grep -Eqi 'HTTP 404|Not Found|release not found' "$TMP/release.err"; then
    echo "No prior GCC checkpoint; initialize a new build."
  else
    cat "$TMP/release.err" >&2
    die "Could not inspect checkpoint release; refusing to discard potentially valid state."
  fi
else
  echo "Reset requested; old checkpoint stays available until a new one is verified."
fi
if [[ "$RESTORED" != true ]]; then rm -rf "$ROOT"; mkdir -p "$ROOT/source-tree"; fi

docker pull debian:12
docker create --name "$CONTAINER" -v "$ROOT:/work" debian:12 sleep infinity >/dev/null
docker start "$CONTAINER" >/dev/null

docker exec -i -e BUILD_UID="$UID_BUILD" "$CONTAINER" bash -s <<'PREP'
set -Eeuo pipefail
export DEBIAN_FRONTEND=noninteractive
rm -f /etc/apt/sources.list.d/debian.sources
cat >/etc/apt/sources.list.d/core2-gcc.list <<'APT'
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb http://deb.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
APT
apt-get update
apt-get install -y --no-install-recommends build-essential devscripts debhelper dpkg-dev fakeroot ca-certificates curl file xz-utils zstd jq cmake meson ninja-build python3 pkg-config quilt bc flex bison gawk
apt-get build-dep -y gcc-12
id core2build >/dev/null 2>&1 || useradd -m -s /bin/bash -o -u "$BUILD_UID" core2build

if [[ ! -s /work/state.json ]]; then
  cd /work/source-tree
  apt-get source gcc-12
  SD="$(find /work/source-tree -mindepth 1 -maxdepth 1 -type d -name 'gcc-12-*' -print -quit)"
  [[ -s "$SD/debian/changelog" ]] || { echo "GCC source unpacking failed" >&2; exit 1; }
  SV="$(dpkg-parsechangelog -l "$SD/debian/changelog" -S Version)"
  PV="${SV}+core2.1~$(date -u +%Y%m%d%H%M%S)"
  cd "$SD"
  dch --newversion "$PV" --distribution bookworm --force-distribution 'Core 2 optimized GCC 12 and runtime/development libraries.'
  [[ "$(dpkg-parsechangelog -l "$SD/debian/changelog" -S Version)" == "$PV" ]]
  find /work/source-tree -maxdepth 1 -type f \( -name '*.dsc' -o -name '*.orig.tar.*' -o -name '*.debian.tar.*' -o -name '*.diff.gz' -o -name '*.tar.gz' -o -name '*.tar.xz' -o -name '*.tar.bz2' -o -name '*.tar.zst' \) -delete
  SDREL="${SD#/work/}"
  [[ "$SDREL" =~ ^source-tree/[A-Za-z0-9.+_-]+$ ]] || { echo "Unsafe source dir" >&2; exit 1; }
  jq -n --arg source_package gcc-12 --arg source_dir "$SDREL" --arg source_version "$SV" --arg package_version "$PV" --arg optimization_level=-O2 '{schema:1,source_package:$source_package,source_dir:$source_dir,source_version:$source_version,package_version:$package_version,optimization_level:$optimization_level}' >/work/state.json
  chown "$BUILD_UID:$BUILD_UID" /work/state.json
  chown -R "$BUILD_UID:$BUILD_UID" /work/source-tree
  export DEB_CFLAGS_MAINT_APPEND='-O2 -march=core2 -mtune=core2' DEB_CXXFLAGS_MAINT_APPEND='-O2 -march=core2 -mtune=core2' DEB_FFLAGS_MAINT_APPEND='-O2 -march=core2 -mtune=core2'
  CFLAGS="$(dpkg-buildflags --get CFLAGS)"; CXXFLAGS="$(dpkg-buildflags --get CXXFLAGS)"
  grep -q -- -march=core2 <<<"$CFLAGS"; grep -q -- -mtune=core2 <<<"$CFLAGS"
  grep -q -- -march=core2 <<<"$CXXFLAGS"; grep -q -- -mtune=core2 <<<"$CXXFLAGS"
  printf 'CFLAGS=%s\nCXXFLAGS=%s\n' "$CFLAGS" "$CXXFLAGS" >/work/build-flags.txt
  chown "$BUILD_UID:$BUILD_UID" /work/build-flags.txt
fi

SDREL="$(jq -r .source_dir /work/state.json)"
[[ "$SDREL" =~ ^source-tree/[A-Za-z0-9.+_-]+$ && -s "/work/$SDREL/debian/changelog" ]] || { echo "Checkpoint has invalid source tree" >&2; exit 1; }
SOURCE_DIR="/work/${SDREL%/}/"
test -s "${SOURCE_DIR}debian/dummy.texi" || { echo "Missing GCC packaging dummy.texi" >&2; exit 1; }
echo "Prepared $SOURCE_DIR at version $(jq -r .package_version /work/state.json)"
PREP

SDREL="$(jq -r .source_dir "$ROOT/state.json")"
SV="$(jq -r .source_version "$ROOT/state.json")"
PV="$(jq -r .package_version "$ROOT/state.json")"
OPT="$(jq -r .optimization_level "$ROOT/state.json")"
[[ "$PV" =~ ^[0-9A-Za-z.+:~_-]+$ && "$SV" =~ ^[0-9A-Za-z.+:~_-]+$ ]] || die "Unsafe version in checkpoint."
[[ -s "$ROOT/build-flags.txt" ]] || die "Build flags missing."
echo "Object/archive files before segment: $(find "$ROOT/source-tree" -type f \( -name '*.o' -o -name '*.a' \) | wc -l)"
set +e
docker exec -e SOURCE_DIR="/work/${SDREL%/}/" \
  -e DEB_CFLAGS_MAINT_APPEND="-O2 -march=core2 -mtune=core2" \
  -e DEB_CXXFLAGS_MAINT_APPEND="-O2 -march=core2 -mtune=core2" \
  -e DEB_FFLAGS_MAINT_APPEND="-O2 -march=core2 -mtune=core2" \
  -e DEB_BUILD_OPTIONS="parallel=2 noautodbgsym" "$CONTAINER" bash -c '
    set -o pipefail
    runuser --preserve-environment -u core2build -- env HOME=/home/core2build USER=core2build LOGNAME=core2build \
      SOURCE_DIR="$SOURCE_DIR" DEB_CFLAGS_MAINT_APPEND="$DEB_CFLAGS_MAINT_APPEND" \
      DEB_CXXFLAGS_MAINT_APPEND="$DEB_CXXFLAGS_MAINT_APPEND" DEB_FFLAGS_MAINT_APPEND="$DEB_FFLAGS_MAINT_APPEND" \
      DEB_BUILD_OPTIONS="$DEB_BUILD_OPTIONS" \
      bash -c '"'"'cd "$SOURCE_DIR" && exec timeout --signal=INT --kill-after=90s 205m dpkg-buildpackage -rfakeroot -us -uc -b -nc -j2'"'"' \
      2>&1 | tee -a /work/build.log
  '
BUILD_STATUS=$?
set -e
echo "dpkg-buildpackage status=$BUILD_STATUS; object/archive files afterward: $(find "$ROOT/source-tree" -type f \( -name '*.o' -o -name '*.a' \) | wc -l)"

checkpoint_state(){
  [[ -s "$ROOT/state.json" ]] || die "No build state to checkpoint."
  local prefix="$TMP/gcc12-state-$GEN.part" manifest="$TMP/gcc12-manifest-$GEN.json" lines="$TMP/parts.jsonl"
  tar --format=pax --numeric-owner --acls --xattrs -cf - -C "$ROOT" \
    --exclude='*.deb' --exclude='*.changes' --exclude='*.buildinfo' . |
    zstd -q -T0 -3 -c | split -b 1400M -d -a 4 - "$prefix"
  shopt -s nullglob
  local parts=( "$TMP"/gcc12-state-"$GEN".part* )
  (( ${#parts[@]} > 0 )) || die "Snapshot produced no parts."
  : >"$lines"
  for p in "${parts[@]}"; do
    jq -cn --arg name "$(basename "$p")" --arg sha256 "$(sha256sum "$p"|awk '{print $1}')" '{name:$name,sha256:$sha256}' >>"$lines"
  done
  jq -n --arg generation "$GEN" --arg source_package gcc-12 --arg source_version "$SV" --arg package_version "$PV" --argjson parts "$(jq -s . "$lines")" \
    '{schema:1,generation:$generation,source_package:$source_package,source_version:$source_version,package_version:$package_version,parts:$parts}' >"$manifest"
  if ! gh api "repos/$GITHUB_REPOSITORY/releases/tags/$STATE_TAG" >/dev/null 2>&1; then
    gh release create "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --title "Resumable GCC 12 build state" \
      --notes "Verified PAX-format disk snapshots for incremental Debian GCC 12 builds. A generation manifest is uploaded last."
  fi
  gh release upload "$STATE_TAG" "${parts[@]}" --repo "$GITHUB_REPOSITORY"
  gh release upload "$STATE_TAG" "$manifest" --repo "$GITHUB_REPOSITORY"
  local verify="$TMP/verified"; mkdir -p "$verify"
  gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$(basename "$manifest")" --dir "$verify"
  cmp -s "$manifest" "$verify/$(basename "$manifest")" || die "Published manifest verification failed."
  while IFS=$'\t' read -r n s; do
    gh release download "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --pattern "$n" --dir "$verify"
    printf '%s  %s\n' "$s" "$verify/$n" | sha256sum -c -
  done < <(jq -r '.parts[]|[.name,.sha256]|@tsv' "$manifest")
  local rid
  rid="$(gh api "repos/$GITHUB_REPOSITORY/releases/tags/$STATE_TAG" --jq .id)"
  while IFS=$'\t' read -r aid aname; do
    [[ "$aname" == "gcc12-manifest-$GEN.json" || "$aname" == gcc12-state-"$GEN".part* ]] && continue
    if [[ "$aname" =~ ^gcc12-(manifest|state)- ]]; then
      gh api -X DELETE "repos/$GITHUB_REPOSITORY/releases/assets/$aid" >/dev/null || echo "::warning::Could not prune old checkpoint asset $aname."
    fi
  done < <(gh api "repos/$GITHUB_REPOSITORY/releases/$rid/assets?per_page=100" --jq '.[]|[.id,.name]|@tsv')
  echo "Checkpoint $GEN uploaded and verified."
}

if [[ "$BUILD_STATUS" -eq 124 ]]; then
  checkpoint_state
  gh workflow run d630-core2-gcc-frozen-build.yml --repo "$GITHUB_REPOSITORY" --ref master -f stage=gcc-12 -f reset_checkpoint=false -f force_rebuild=true
  echo "Queued next incremental GCC segment."
  exit 0
elif [[ "$BUILD_STATUS" -ne 0 ]]; then
  checkpoint_state
  die "GCC build failed (status $BUILD_STATUS); state saved for diagnosis and retry."
fi

shopt -s nullglob
DEBS=( "$ROOT"/source-tree/*.deb )
(( ${#DEBS[@]} > 0 )) || die "Build succeeded but produced no Debian packages."
mkdir -p "$ROOT/release-artifacts"; rm -f "$ROOT/release-artifacts/"*
OK_DEBS=()
for deb in "${DEBS[@]}"; do
  pkg="$(dpkg-deb -f "$deb" Package)"; ver="$(dpkg-deb -f "$deb" Version)"; arch="$(dpkg-deb -f "$deb" Architecture)"
  case "$pkg" in *-dbg|*-dbgsym) rm -f "$deb"; continue;; esac
  [[ "$ver" == "$PV" ]] || die "Wrong package version in $(basename "$deb"): $ver"
  case "$arch" in amd64|all) ;; *) die "Unexpected architecture $arch";; esac
  OK_DEBS+=("$deb")
done
(( ${#OK_DEBS[@]} > 0 )) || die "No non-debug GCC packages remain."
for deb in "${OK_DEBS[@]}"; do cp "$deb" "$ROOT/release-artifacts/"; done
cp "$ROOT/build-flags.txt" "$ROOT/release-artifacts/CORE2-BUILD-FLAGS.txt"
{
  echo "Source package: gcc-12"
  echo "Bookworm source version: $SV"
  echo "Core 2 package version: $PV"
  echo "Target: amd64 / Intel Core 2 Duo"
  echo "Flags: -O2 -march=core2 -mtune=core2"
  echo "Build: resumable incremental Debian package build with verified PAX disk snapshots"
  echo "Debug-symbol packages excluded."
  echo
  for deb in "${OK_DEBS[@]}"; do printf '%s %s %s\n' "$(dpkg-deb -f "$deb" Package)" "$(dpkg-deb -f "$deb" Version)" "$(dpkg-deb -f "$deb" Architecture)"; done
} >"$ROOT/release-artifacts/BUILD-INFO.txt"
(cd "$ROOT/release-artifacts" && sha256sum ./*.deb > SHA256SUMS-core2-gcc-12.txt)

TAG_VER="$(printf '%s' "$PV" | sed -E 's/[^A-Za-z0-9._-]+/-/g')"
RELEASE_TAG="core2-system-gcc-12-$TAG_VER"
if gh release view "$RELEASE_TAG" --repo "$GITHUB_REPOSITORY" >/dev/null 2>&1; then die "Release $RELEASE_TAG already exists; refusing to overwrite."; fi
export PACKAGE=gcc-12 SOURCE_VERSION="$SV" PACKAGE_VERSION="$PV" RELEASE_TAG OPT_LEVEL="$OPT" RELEASE_KIND=system
cd "$ROOT/release-artifacts"
python3 "$GITHUB_WORKSPACE/core2-packages/release-notes.py"
TITLE="$(cat release-title.txt)"
ASSETS=( ./*.deb ./*.txt )
(( ${#ASSETS[@]} > 0 )) || die "No release assets staged."
gh release create "$RELEASE_TAG" "${ASSETS[@]}" --repo "$GITHUB_REPOSITORY" --title "$TITLE" --notes-file release-notes.md
echo "Published GCC runtime/development packages: $RELEASE_TAG"

gh release delete "$STATE_TAG" --repo "$GITHUB_REPOSITORY" --yes --cleanup-tag || echo "::warning::Package release succeeded but checkpoint cleanup failed."
gh workflow run d630-core2-gcc-frozen-build.yml --repo "$GITHUB_REPOSITORY" --ref master -f stage=defaults -f reset_checkpoint=false -f force_rebuild=true
echo "Queued gcc/cpp default packages after GCC 12 publication."
