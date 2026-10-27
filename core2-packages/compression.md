pkgs versions

<details>

```sh
Package: 7zip
Version: 22.01+really26.02+dfsg-0+deb12u1+core2.1~20261009183500
Status: install ok installed
Priority: optional
Section: utils
Maintainer: YOKOTA Hiroshi <yokota.hgml@gmail.com>
Installed-Size: 2,713 kB
Depends: libc6 (>= 2.34), libgcc-s1 (>= 3.0), libstdc++6 (>= 5)
Homepage: https://www.7-zip.org/
Download-Size: unknown
APT-Manual-Installed: yes
APT-Sources: /var/lib/dpkg/status
Description: 7-Zip file archiver with a high compression ratio

Package: xz-utils
Version: 5.4.1-1+deb12u2+core2.1~20261009193709
Status: install ok installed
Priority: standard
Section: utils
Maintainer: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Installed-Size: 1,255 kB
Provides: lzma
Depends: libc6 (>= 2.34), liblzma5 (>= 5.4.0)
Conflicts: lzma (<< 9.22-1), xz-lzma
Breaks: lzip (<< 1.8~rc2), manpages-de (<< 4.17.0-2~bpo11+1), manpages-fr (<< 4.17.0-2~bpo11+1)
Replaces: lzip (<< 1.8~rc2), manpages-de (<< 4.17.0-2~bpo11+1), manpages-fr (<< 4.17.0-2~bpo11+1), xz-lzma
Homepage: https://tukaani.org/xz/
Download-Size: unknown
APT-Manual-Installed: yes
APT-Sources: /var/lib/dpkg/status
Description: XZ-format compression utilities

Package: zstd
Version: 1.5.4+dfsg2-5
Priority: optional
Section: utils
Source: libzstd
Maintainer: RPM packaging team <team+pkg-rpm@tracker.debian.org>
Installed-Size: 2,152 kB
Depends: libc6 (>= 2.34), libgcc-s1 (>= 3.0), liblz4-1 (>= 1.8.0), liblzma5 (>= 5.1.1alpha+20120614), libstdc++6 (>= 12), zlib1g (>= 1:1.1.4)
Homepage: https://github.com/facebook/zstd
Tag: implemented-in::c, interface::commandline, role::program,
 scope::utility, use::compressing
Download-Size: 701 kB
APT-Manual-Installed: yes
APT-Sources: https://deb.debian.org/debian bookworm/main amd64 Packages
Description: fast lossless compression algorithm -- CLI tool

Package: lz4
Version: 1.9.4-1
Priority: optional
Section: utils
Maintainer: Nobuhiro Iwamatsu <iwamatsu@debian.org>
Installed-Size: 248 kB
Provides: liblz4-tool
Depends: libc6 (>= 2.34), liblz4-1 (= 1.9.4-1)
Conflicts: liblz4-tool (<< 1.8.0-1)
Replaces: liblz4-tool (<< 1.8.0-1)
Homepage: https://github.com/lz4/lz4
Download-Size: 92.7 kB
APT-Manual-Installed: yes
APT-Sources: https://deb.debian.org/debian bookworm/main amd64 Packages
Description: Fast LZ compression algorithm library - tool

Package: gzip
Version: 1.12-1+core2.1~20261009191817
Status: install ok installed
Priority: required
Essential: yes
Section: utils
Maintainer: Milan Kupcevic <milan@debian.org>
Installed-Size: 254 kB
Pre-Depends: libc6 (>= 2.34)
Depends: dpkg (>= 1.15.4) | install-info
Suggests: less
Homepage: https://www.gnu.org/software/gzip/
Download-Size: unknown
APT-Manual-Installed: yes
APT-Sources: /var/lib/dpkg/status
Description: GNU compression utilities

Package: zlib1g
Version: 1:1.2.13.dfsg-1+core2.1~20261016151112
Status: install ok installed
Priority: optional
Section: libs
Source: zlib
Maintainer: Mark Brown <broonie@debian.org>
Installed-Size: 172 kB
Provides: libz1
Depends: libc6 (>= 2.14)
Conflicts: zlib1 (<= 1:1.0.4-7)
Breaks: libxml2 (<< 2.7.6.dfsg-2), texlive-binaries (<< 2009-12)
Homepage: http://zlib.net/
Download-Size: unknown
APT-Manual-Installed: yes
APT-Sources: /var/lib/dpkg/status
Description: compression library - runtime
```
</details>



script d630-compression-bench.sh <details>
```sh
#!/usr/bin/env bash
# Local, single-thread compression benchmark for the Dell D630 / Core 2 Duo.
set -euo pipefail

WORK="${PWD}/compression-bench-results"
CORPUS="$WORK/corpus"
TMP="$WORK/tmp"
BYTES=$((16 * 1024 * 1024))
ROUNDS=3
CSV="$WORK/baseline.csv"

if [[ -e "$CSV" ]]; then
  echo "Refusing to overwrite existing baseline: $CSV" >&2
  echo "Move that results directory aside only if you deliberately want a new baseline." >&2
  exit 1
fi
mkdir -p "$CORPUS" "$TMP"

# Create and preserve identical test inputs for a future comparison.
if [[ ! -s "$CORPUS/text.bin" ]]; then
  seed="$TMP/text-seed"
  find /usr/share/doc /usr/include -type f \
    \( -iname 'README*' -o -iname '*.txt' -o -iname '*.md' -o -name copyright -o -iname '*.h' \) \
    -print0 2>/dev/null | sort -z | xargs -0 -r cat 2>/dev/null | head -c "$BYTES" > "$seed" || true
  if [[ ! -s "$seed" || "$(stat -c %s "$seed")" -lt 4096 ]]; then
    printf 'Core 2 Duo compression benchmark text corpus.\n' > "$seed"
  fi
  cp "$seed" "$CORPUS/text.bin"
  while [[ "$(stat -c %s "$CORPUS/text.bin")" -lt "$BYTES" ]]; do cat "$seed" >> "$CORPUS/text.bin"; done
  truncate -s "$BYTES" "$CORPUS/text.bin"
fi
if [[ ! -s "$CORPUS/binary.bin" ]]; then
  dd if=/dev/urandom of="$CORPUS/binary.bin" bs=1M count=16 status=none
fi
sha256sum "$CORPUS/text.bin" "$CORPUS/binary.bin" > "$WORK/corpus-sha256.txt"

SEVENZ=""
for tool in 7z 7zz 7za; do
  if command -v "$tool" >/dev/null 2>&1; then SEVENZ="$(command -v "$tool")"; break; fi
done
ZLIB_BENCH=""
if command -v cc >/dev/null 2>&1 && [[ -r /usr/include/zlib.h ]]; then
  cat > "$TMP/zlib-bench.c" <<'C'
#define _FILE_OFFSET_BITS 64
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <zlib.h>
static unsigned char *read_file(const char *p, size_t *n) {
  FILE *f = fopen(p, "rb"); long z; unsigned char *b;
  if (!f) { perror(p); return NULL; }
  if (fseek(f, 0, SEEK_END) || (z = ftell(f)) < 0 || fseek(f, 0, SEEK_SET)) { perror("seek"); fclose(f); return NULL; }
  b = malloc(z > 0 ? (size_t)z : 1);
  if (!b) { perror("malloc"); fclose(f); return NULL; }
  if (z && fread(b, 1, (size_t)z, f) != (size_t)z) { perror("read"); free(b); fclose(f); return NULL; }
  fclose(f); *n = (size_t)z; return b;
}
static int compress_file(const char *p) {
  size_t n = 0, i; unsigned char *in = read_file(p, &n), *out; uLongf cap; unsigned char h[8]; int rc;
  if (!in) return 1;
  if ((size_t)(uLong)n != n) { fputs("input too large for zlib\n", stderr); free(in); return 1; }
  cap = compressBound((uLong)n); out = malloc((size_t)cap);
  if (!out) { perror("malloc"); free(in); return 1; }
  rc = compress2(out, &cap, in, (uLong)n, Z_DEFAULT_COMPRESSION);
  if (rc != Z_OK) { fprintf(stderr, "compress2: %d\n", rc); free(out); free(in); return 1; }
  for (i = 0; i < 8; ++i) h[7-i] = (unsigned char)(((uint64_t)n >> (i*8)) & 255);
  if (fwrite(h, 1, 8, stdout) != 8 || fwrite(out, 1, (size_t)cap, stdout) != (size_t)cap) { perror("write"); free(out); free(in); return 1; }
  free(out); free(in); return 0;
}
static int decompress_file(const char *p) {
  size_t n = 0, i; unsigned char *in = read_file(p, &n), *out; uint64_t want = 0; uLongf outn; int rc;
  if (!in) return 1;
  if (n < 8) { fputs("truncated archive\n", stderr); free(in); return 1; }
  for (i = 0; i < 8; ++i) want = (want << 8) | in[i];
  if (want > SIZE_MAX || want > ULONG_MAX || n-8 > ULONG_MAX) { fputs("archive too large\n", stderr); free(in); return 1; }
  outn = (uLongf)want; out = malloc(want ? (size_t)want : 1);
  if (!out) { perror("malloc"); free(in); return 1; }
  rc = uncompress(out, &outn, in+8, (uLong)(n-8));
  if (rc != Z_OK || outn != (uLongf)want) { fprintf(stderr, "uncompress: %d\n", rc); free(out); free(in); return 1; }
  if (fwrite(out, 1, (size_t)outn, stdout) != (size_t)outn) { perror("write"); free(out); free(in); return 1; }
  free(out); free(in); return 0;
}
int main(int argc, char **argv) {
  if (argc != 3) { fprintf(stderr, "Usage: %s compress|decompress FILE\n", argv[0]); return 2; }
  if (!strcmp(argv[1], "compress")) return compress_file(argv[2]);
  if (!strcmp(argv[1], "decompress")) return decompress_file(argv[2]);
  return 2;
}
C
  if cc -O2 -march=core2 -mtune=core2 -pipe "$TMP/zlib-bench.c" -lz -o "$WORK/zlib-bench"; then
    ZLIB_BENCH="$WORK/zlib-bench"
  else
    echo "NOTE: zlib direct test skipped; could not build its helper." >&2
  fi
fi

{
  date -Is
  uname -a
  echo
  lscpu 2>/dev/null | grep -E 'Architecture:|Model name:|CPU MHz:|CPU max MHz:|CPU min MHz:' || true
  echo "CPU governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo unavailable)"
  echo
  echo 'Installed package versions:'
  for p in p7zip-full p7zip xz-utils liblzma5 zstd libzstd1 lz4 liblz4-1 gzip zlib1g zlib1g-dev libstdc++6; do dpkg-query -W -f='${binary:Package} ${Version}\n' "$p" 2>/dev/null || true; done
  echo
  echo 'Compression executable dynamic dependencies:'
  for x in "$SEVENZ" "$(command -v xz 2>/dev/null || true)" "$(command -v zstd 2>/dev/null || true)" "$(command -v lz4 2>/dev/null || true)" "$(command -v gzip 2>/dev/null || true)"; do
    [[ -n "$x" && -x "$x" ]] && { echo "[$x]"; ldd "$x" 2>/dev/null || true; }
  done
  if [[ -n "$ZLIB_BENCH" ]]; then echo "[$ZLIB_BENCH]"; ldd "$ZLIB_BENCH" 2>/dev/null || true; fi
} > "$WORK/system-baseline.txt"

echo 'profile,corpus,codec,input_bytes,archive_bytes,ratio,compress_seconds,compress_MiB_s,decompress_seconds,decompress_MiB_s,input_sha256' > "$TMP/results.csv"

compress_one() {
  local codec="$1" input="$2" archive="$3" base
  base="$(basename "$input")"
  case "$codec" in
    7z) (cd "$CORPUS" && "$SEVENZ" a -t7z -mx=5 -mmt=1 -bd -y "$archive" "$base" >/dev/null 2>&1) ;;
    xz) xz -6 -T1 -c "$input" > "$archive" ;;
    lzma) xz --format=lzma -6 -T1 -c "$input" > "$archive" ;;
    zstd) zstd -3 -T1 -q -c "$input" > "$archive" ;;
    lz4) lz4 -1 -q -c "$input" > "$archive" ;;
    gzip) gzip -6 -c "$input" > "$archive" ;;
    zlib) "$ZLIB_BENCH" compress "$input" > "$archive" ;;
  esac
}
decompress_one() {
  local codec="$1" archive="$2" output="$3"
  case "$codec" in
    7z) "$SEVENZ" x -so "$archive" > "$output" 2>/dev/null ;;
    xz|lzma) xz -dc "$archive" > "$output" ;;
    zstd) zstd -q -dc "$archive" > "$output" ;;
    lz4) lz4 -q -dc "$archive" > "$output" ;;
    gzip) gzip -dc "$archive" > "$output" ;;
    zlib) "$ZLIB_BENCH" decompress "$archive" > "$output" ;;
  esac
}
run_timed() {
  local start end
  start="$(date +%s%N)"
  "$@"
  end="$(date +%s%N)"
  awk -v a="$start" -v b="$end" 'BEGIN { printf "%.6f\n", (b-a)/1000000000 }'
}
median() { sort -n "$1" | sed -n '2p'; }

for input in "$CORPUS/text.bin" "$CORPUS/binary.bin"; do
  name="$(basename "$input" .bin)"
  bytes="$(stat -c %s "$input")"
  hash="$(sha256sum "$input" | awk '{print $1}')"
  codecs=()
  [[ -n "$SEVENZ" ]] && codecs+=(7z)
  command -v xz >/dev/null 2>&1 && codecs+=(xz lzma)
  command -v zstd >/dev/null 2>&1 && codecs+=(zstd)
  command -v lz4 >/dev/null 2>&1 && codecs+=(lz4)
  command -v gzip >/dev/null 2>&1 && codecs+=(gzip)
  [[ -n "$ZLIB_BENCH" ]] && codecs+=(zlib)
  for codec in "${codecs[@]}"; do
    echo "Testing $name / $codec (median of $ROUNDS runs)..."
    archive="$TMP/$name-$codec.archive"
    ct="$TMP/$name-$codec-compress.times"
    dt="$TMP/$name-$codec-decompress.times"
    : > "$ct"; : > "$dt"
    for ((i=1; i<=ROUNDS; i++)); do
      rm -f "$archive"
      run_timed compress_one "$codec" "$input" "$archive" >> "$ct"
    done
    for ((i=1; i<=ROUNDS; i++)); do
      run_timed decompress_one "$codec" "$archive" "$TMP/verify.bin" >> "$dt"
    done
    decompress_one "$codec" "$archive" "$TMP/verify.bin"
    if ! cmp -s "$input" "$TMP/verify.bin"; then echo "ERROR: integrity check failed for $codec/$name" >&2; exit 1; fi
    comp="$(median "$ct")"; dec="$(median "$dt")"
    out="$(stat -c %s "$archive")"
    ratio="$(awk -v a="$bytes" -v b="$out" 'BEGIN { printf "%.3f", a/b }')"
    cspeed="$(awk -v n="$bytes" -v t="$comp" 'BEGIN { printf "%.2f", n/1048576/t }')"
    dspeed="$(awk -v n="$bytes" -v t="$dec" 'BEGIN { printf "%.2f", n/1048576/t }')"
    echo "baseline,$name,$codec,$bytes,$out,$ratio,$comp,$cspeed,$dec,$dspeed,$hash" >> "$TMP/results.csv"
    printf '  compress %6s MiB/s | decompress %6s MiB/s | ratio %s:1 | archive %s bytes\n' "$cspeed" "$dspeed" "$ratio" "$out"
  done
done
mv "$TMP/results.csv" "$CSV"
echo
echo "Done. Results: $CSV"
echo "System details: $WORK/system-baseline.txt"
echo "Fixed test data: $CORPUS (SHA-256 in $WORK/corpus-sha256.txt)"
echo 'All decompressed output was checked against the original inputs.'

```
</details>

<br>

```markdown

bash d630-compression-bench.sh
Testing text / 7z (median of 3 runs)...
  compress   2.38 MiB/s | decompress  60.56 MiB/s | ratio 19.269:1 | archive 870701 bytes
Testing text / xz (median of 3 runs)...
  compress   2.16 MiB/s | decompress  61.23 MiB/s | ratio 19.441:1 | archive 862972 bytes
Testing text / lzma (median of 3 runs)...
  compress   2.17 MiB/s | decompress  71.02 MiB/s | ratio 19.446:1 | archive 862753 bytes
Testing text / zstd (median of 3 runs)...
  compress  60.97 MiB/s | decompress  91.33 MiB/s | ratio 5.420:1 | archive 3095291 bytes
Testing text / lz4 (median of 3 runs)...
  compress 129.06 MiB/s | decompress  50.79 MiB/s | ratio 2.861:1 | archive 5863238 bytes
Testing text / gzip (median of 3 runs)...
  compress  15.35 MiB/s | decompress  59.99 MiB/s | ratio 4.025:1 | archive 4167962 bytes
Testing binary / 7z (median of 3 runs)...
  compress   2.45 MiB/s | decompress  84.74 MiB/s | ratio 1.000:1 | archive 16778388 bytes
Testing binary / xz (median of 3 runs)...
  compress   1.81 MiB/s | decompress  42.18 MiB/s | ratio 1.000:1 | archive 16778108 bytes
Testing binary / lzma (median of 3 runs)...
  compress   1.79 MiB/s | decompress   8.87 MiB/s | ratio 0.987:1 | archive 17005220 bytes
Testing binary / zstd (median of 3 runs)...
  compress 119.84 MiB/s | decompress 108.12 MiB/s | ratio 1.000:1 | archive 16777614 bytes
Testing binary / lz4 (median of 3 runs)...
  compress 190.59 MiB/s | decompress  61.34 MiB/s | ratio 1.000:1 | archive 16777247 bytes
Testing binary / gzip (median of 3 runs)...
  compress  16.93 MiB/s | decompress  63.92 MiB/s | ratio 1.000:1 | archive 16779805 bytes

Done. Results: /home/jeroen/Downloads/compression-bench-results/baseline.csv
System details: /home/jeroen/Downloads/compression-bench-results/system-baseline.txt
Fixed test data: /home/jeroen/Downloads/compression-bench-results/corpus (SHA-256 in /home/jeroen/Downloads/compression-bench-results/corpus-sha256.txt)
All decompressed output was checked against the original inputs.

```
