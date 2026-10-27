#!/usr/bin/env bash
set -Eeuo pipefail

die() { echo "::error::$*" >&2; exit 1; }
usage() { echo "Usage: $0 prepare DIR | run PHASE CORPUS_DIR CSV | versions FILE | compare BASELINE_CSV OPTIMIZED_CSV CSV" >&2; exit 2; }

prepare() {
  local dir="$1"
  mkdir -p "$dir"
  python3 - "$dir" <<'PY'
from pathlib import Path
import random
import sys
import hashlib

root = Path(sys.argv[1])
mib = 1024 * 1024
size = 16 * mib
pattern = (
    b'{"service":"d630","level":"info","event":"compression-benchmark",'
    b'"status":"ok","message":"repeated structured log record"}\n'
)
block = (pattern * ((mib // len(pattern)) + 1))[:mib]

with (root / "compressible.bin").open("wb") as stream:
    for _ in range(size // len(block)):
        stream.write(block)

rng = random.Random(271828)
with (root / "mixed.bin").open("wb") as stream:
    for _ in range(8):
        stream.write(block)
    for _ in range(8):
        stream.write(rng.randbytes(mib))

for path in sorted(root.glob("*.bin")):
    if path.stat().st_size != size:
        raise SystemExit(f"Unexpected corpus size for {path}: {path.stat().st_size}")
    print(f"{path.name}: {path.stat().st_size} bytes SHA256={hashlib.sha256(path.read_bytes()).hexdigest()}")
PY
}

versions() {
  local output="$1"
  {
    echo "Benchmark host: $(uname -a)"
    echo "CPU model:"
    awk -F: '/^model name[[:space:]]*:/ {sub(/^[ \t]+/, "", $2); print $2; exit}' /proc/cpuinfo || true
    echo "CPU threads: $(nproc)"
    echo
    echo "Debian runtime package versions:"
    dpkg-query -W -f='${Package} ${Version} ${Architecture}\n' \
      7zip xz-utils liblzma5 zstd libzstd1 lz4 liblz4-1 gzip zlib1g libstdc++6 gcc-12-base 2>&1 || true
    echo
    for cmd in 7zz xz lzma zstd lz4 gzip; do
      if command -v "$cmd" >/dev/null 2>&1; then
        echo "[$cmd]"
        "$cmd" --version 2>&1 | head -n 2 || true
      fi
    done
  } > "$output"
  cat "$output"
}

run_benchmark() {
  local phase="$1" corpus_dir="$2" output_csv="$3"
  [[ -d "$corpus_dir" ]] || die "Corpus directory missing: $corpus_dir"
  command -v 7zz >/dev/null || die "Debian Bookworm 7-Zip executable 7zz is missing."
  for cmd in xz lzma zstd lz4 gzip; do command -v "$cmd" >/dev/null || die "Missing benchmark command: $cmd"; done

  mkdir -p "$(dirname "$output_csv")"
  printf 'phase,corpus,tool,level,mode,iteration,input_bytes,archive_bytes,ratio_pct,seconds,mib_per_second,verified\n' > "$output_csv"
  local work input corpus input_bytes archive decoded timing seconds archive_bytes ratio speed verified
  work="$(mktemp -d)"
  trap 'rm -rf "$work"' RETURN

  for input in "$corpus_dir"/*.bin; do
    [[ -f "$input" ]] || die "No .bin corpus files found in $corpus_dir"
    corpus="$(basename "$input" .bin)"
    input_bytes="$(stat -c %s "$input")"

    while read -r tool level; do
      for iteration in 1 2; do
        archive="$work/$corpus-$tool-$level.archive"
        decoded="$work/$corpus-$tool-$level.decoded"
        timing="$work/time.txt"
        rm -f "$archive" "$decoded" "$timing"

        case "$tool" in
          7zip)
            /usr/bin/time -f '%e' -o "$timing" \
              7zz a -t7z -m0=lzma2 "-mx=$level" -mmt=1 -bd -y "$archive" "$input" \
              >"$work/tool.log" 2>&1
            ;;
          xz)
            /usr/bin/time -f '%e' -o "$timing" xz -T1 "-$level" -c "$input" > "$archive"
            ;;
          lzma)
            /usr/bin/time -f '%e' -o "$timing" lzma "-$level" -c "$input" > "$archive"
            ;;
          zstd)
            /usr/bin/time -f '%e' -o "$timing" zstd -q -T1 "-$level" -f "$input" -o "$archive"
            ;;
          lz4)
            /usr/bin/time -f '%e' -o "$timing" lz4 -q -f "-$level" "$input" "$archive"
            ;;
          gzip)
            /usr/bin/time -f '%e' -o "$timing" gzip "-$level" -c "$input" > "$archive"
            ;;
          *)
            die "Unknown benchmark tool: $tool"
            ;;
        esac

        seconds="$(cat "$timing")"
        archive_bytes="$(stat -c %s "$archive")"
        ratio="$(awk -v out="$archive_bytes" -v inbytes="$input_bytes" 'BEGIN { printf "%.2f", 100*out/inbytes }')"
        speed="$(awk -v bytes="$input_bytes" -v sec="$seconds" 'BEGIN { if (sec+0 <= 0) printf "NA"; else printf "%.2f", (bytes/1048576)/sec }')"
        printf '%s,%s,%s,%s,compress,%s,%s,%s,%s,%s,%s,not-tested\n' \
          "$phase" "$corpus" "$tool" "$level" "$iteration" "$input_bytes" \
          "$archive_bytes" "$ratio" "$seconds" "$speed" >> "$output_csv"

        rm -f "$timing"
        case "$tool" in
          7zip)
            /usr/bin/time -f '%e' -o "$timing" 7zz x -so -bd "$archive" \
              > "$decoded" 2>"$work/tool.log"
            ;;
          xz)
            /usr/bin/time -f '%e' -o "$timing" xz -dc "$archive" > "$decoded"
            ;;
          lzma)
            /usr/bin/time -f '%e' -o "$timing" lzma -dc "$archive" > "$decoded"
            ;;
          zstd)
            /usr/bin/time -f '%e' -o "$timing" zstd -q -d -f "$archive" -o "$decoded"
            ;;
          lz4)
            /usr/bin/time -f '%e' -o "$timing" lz4 -q -d -f "$archive" "$decoded"
            ;;
          gzip)
            /usr/bin/time -f '%e' -o "$timing" gzip -dc "$archive" > "$decoded"
            ;;
        esac

        seconds="$(cat "$timing")"
        if cmp -s "$input" "$decoded"; then verified=yes; else die "Integrity failure: $phase $corpus $tool level $level iteration $iteration"; fi
        speed="$(awk -v bytes="$input_bytes" -v sec="$seconds" 'BEGIN { if (sec+0 <= 0) printf "NA"; else printf "%.2f", (bytes/1048576)/sec }')"
        printf '%s,%s,%s,%s,decompress,%s,%s,%s,%s,%s,%s,%s\n' \
          "$phase" "$corpus" "$tool" "$level" "$iteration" "$input_bytes" \
          "$archive_bytes" "$ratio" "$seconds" "$speed" "$verified" >> "$output_csv"
      done
    done <<'LEVELS'
7zip 1
7zip 5
7zip 9
xz 1
xz 6
xz 9
lzma 1
lzma 6
lzma 9
zstd 1
zstd 3
zstd 9
lz4 1
lz4 9
gzip 1
gzip 6
gzip 9
LEVELS
  done
  echo "Completed $phase benchmark: $output_csv"
  wc -l "$output_csv"
}

compare() {
  local baseline="$1" optimized="$2" result="$3"
  python3 - "$baseline" "$optimized" "$result" <<'PY'
import csv
import statistics
import sys
from collections import defaultdict

baseline_path, optimized_path, output_path = sys.argv[1:]
def load(path):
    groups = defaultdict(list)
    with open(path, newline="", encoding="utf-8") as stream:
        for row in csv.DictReader(stream):
            key = (row["corpus"], row["tool"], row["level"], row["mode"])
            groups[key].append(row)
    medians = {}
    for key, rows in groups.items():
        speeds = [float(row["mib_per_second"]) for row in rows if row["mib_per_second"] != "NA"]
        medians[key] = {
            "seconds": statistics.median(float(row["seconds"]) for row in rows),
            "mib_per_second": statistics.median(speeds) if speeds else 0.0,
            "archive_bytes": statistics.median(int(row["archive_bytes"]) for row in rows),
            "input_bytes": int(rows[0]["input_bytes"]),
        }
    return medians

before, after = load(baseline_path), load(optimized_path)
keys = sorted(set(before) & set(after))
if not keys:
    raise SystemExit("Baseline and optimized benchmark files have no matching test cases.")
fields = [
    "corpus", "tool", "level", "mode", "baseline_seconds", "optimized_seconds",
    "time_change_pct", "baseline_mib_per_second", "optimized_mib_per_second",
    "speed_change_pct", "baseline_archive_bytes", "optimized_archive_bytes",
    "archive_size_change_pct", "baseline_ratio_pct", "optimized_ratio_pct",
]
with open(output_path, "w", newline="", encoding="utf-8") as stream:
    writer = csv.DictWriter(stream, fieldnames=fields)
    writer.writeheader()
    for key in keys:
        b, a = before[key], after[key]
        pct_time = 100 * (a["seconds"] / b["seconds"] - 1) if b["seconds"] else 0.0
        pct_speed = 100 * (a["mib_per_second"] / b["mib_per_second"] - 1) if b["mib_per_second"] else 0.0
        pct_size = 100 * (a["archive_bytes"] / b["archive_bytes"] - 1) if b["archive_bytes"] else 0.0
        writer.writerow({
            "corpus": key[0], "tool": key[1], "level": key[2], "mode": key[3],
            "baseline_seconds": f'{b["seconds"]:.4f}',
            "optimized_seconds": f'{a["seconds"]:.4f}',
            "time_change_pct": f"{pct_time:+.2f}",
            "baseline_mib_per_second": f'{b["mib_per_second"]:.2f}',
            "optimized_mib_per_second": f'{a["mib_per_second"]:.2f}',
            "speed_change_pct": f"{pct_speed:+.2f}",
            "baseline_archive_bytes": int(b["archive_bytes"]),
            "optimized_archive_bytes": int(a["archive_bytes"]),
            "archive_size_change_pct": f"{pct_size:+.2f}",
            "baseline_ratio_pct": f'{100*b["archive_bytes"]/b["input_bytes"]:.2f}',
            "optimized_ratio_pct": f'{100*a["archive_bytes"]/a["input_bytes"]:.2f}',
        })
print(f"Wrote {len(keys)} comparison rows to {output_path}")
PY
}

case "${1:-}" in
  prepare) [[ "$#" == 2 ]] || usage; prepare "$2" ;;
  run) [[ "$#" == 4 ]] || usage; run_benchmark "$2" "$3" "$4" ;;
  versions) [[ "$#" == 2 ]] || usage; versions "$2" ;;
  compare) [[ "$#" == 4 ]] || usage; compare "$2" "$3" "$4" ;;
  *) usage ;;
esac
