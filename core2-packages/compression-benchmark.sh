#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RESULTS_DIR="$PWD/compression-bench-results"
CORPUS_DIR="$RESULTS_DIR/corpus"
TMP_DIR="$RESULTS_DIR/tmp"
SIZE=$((16 * 1024 * 1024))
REPEATS=3

usage() {
  echo "Usage:"
  echo "  bash core2-packages/compression-benchmark.sh baseline"
  echo "  bash core2-packages/compression-benchmark.sh candidate /path/to/downloaded-debs"
}

if [[ "$MODE" != "baseline" && "$MODE" != "candidate" ]]; then
  usage
  exit 2
fi

mkdir -p "$RESULTS_DIR" "$CORPUS_DIR"

make_corpus() {
  local seed="$TMP_DIR/text-seed"
  mkdir -p "$TMP_DIR"
  if [[ ! -s "$CORPUS_DIR/text.bin" ]]; then
    find /usr/share/doc /usr/include -type f \
      \( -iname 'README*' -o -iname '*.txt' -o -iname '*.md' -o -name copyright -o -iname '*.h' \) \
      -print0 2>/dev/null | sort -z | xargs -0 -r cat 2>/dev/null | head -c "$SIZE" > "$seed" || true
    if [[ ! -s "$seed" || "$(stat -c %s "$seed")" -lt 4096 ]]; then
      if [[ -r /usr/share/common-licenses/GPL-3 ]]; then
        cat /usr/share/common-licenses/GPL-3 > "$seed"
      else
        echo "Core 2 compression benchmark text corpus seed" > "$seed"
      fi
    fi
    cp "$seed" "$CORPUS_DIR/text.bin"
    while [[ "$(stat -c %s "$CORPUS_DIR/text.bin")" -lt "$SIZE" ]]; do
      cat "$seed" >> "$CORPUS_DIR/text.bin"
    done
    truncate -s "$SIZE" "$CORPUS_DIR/text.bin"
  fi
  if [[ ! -s "$CORPUS_DIR/binary.bin" ]]; then
    dd if=/dev/urandom of="$CORPUS_DIR/binary.bin" bs=1M count=16 status=none
  fi
  sha256sum "$CORPUS_DIR/text.bin" "$CORPUS_DIR/binary.bin" > "$RESULTS_DIR/corpus-sha256.txt"
}

if [[ "$MODE" == "baseline" ]]; then
  if [[ -e "$RESULTS_DIR/baseline.csv" ]]; then
    echo "Baseline already exists: $RESULTS_DIR/baseline.csv"
    echo "Remove that file deliberately before replacing the saved baseline."
    exit 1
  fi
  make_corpus
  if ! command -v cc >/dev/null 2>&1 || [[ ! -r /usr/include/zlib.h ]]; then
    echo "Direct zlib testing requires cc and zlib1g-dev (zlib.h)." >&2
    exit 1
  fi
  cc -O2 -march=core2 -mtune=core2 -pipe "$SCRIPT_DIR/zlib-benchmark.c" -lz -o "$RESULTS_DIR/zlib-bench"
  if ! ldd "$RESULTS_DIR/zlib-bench" | grep -q 'libz.so.1'; then
    echo "zlib benchmark helper did not dynamically link against libz.so.1." >&2
    exit 1
  fi
  {
    date -Is
    uname -a
    lscpu 2>/dev/null | grep -E 'Architecture:|Model name:|CPU MHz:|CPU max MHz:|CPU min MHz:' || true
    echo "CPU governor:"
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || true
    echo "Installed compression package versions:"
    for pkg in p7zip-full p7zip xz-utils liblzma5 zstd libzstd1 lz4 liblz4-1 gzip zlib1g libstdc++6; do
      dpkg-query -W "$pkg" 2>/dev/null || true
    done
  } > "$RESULTS_DIR/system-baseline.txt"
else
  DEB_DIR="${2:-}"
  if [[ -z "$DEB_DIR" || ! -d "$DEB_DIR" ]]; then
    usage
    exit 2
  fi
  if [[ ! -s "$RESULTS_DIR/baseline.csv" || ! -s "$CORPUS_DIR/text.bin" || ! -s "$CORPUS_DIR/binary.bin" ]]; then
    echo "Run the baseline benchmark first from this same working directory."
    exit 1
  fi
  if [[ -s "$RESULTS_DIR/corpus-sha256.txt" ]]; then
    sha256sum -c "$RESULTS_DIR/corpus-sha256.txt"
  fi
  CANDIDATE_ROOT="$RESULTS_DIR/candidate-root"
  rm -rf "$CANDIDATE_ROOT"
  mkdir -p "$CANDIDATE_ROOT"
  : > "$RESULTS_DIR/candidate-packages.txt"
  deb_count=0
  for deb in "$DEB_DIR"/*.deb; do
    [[ -f "$deb" ]] || continue
    dpkg-deb -x "$deb" "$CANDIDATE_ROOT"
    echo "$(basename "$deb")  $(dpkg-deb -f "$deb" Package)  $(dpkg-deb -f "$deb" Version)" >> "$RESULTS_DIR/candidate-packages.txt"
    deb_count=$((deb_count + 1))
  done
  if [[ "$deb_count" -eq 0 ]]; then
    echo "No .deb files found in $DEB_DIR"
    exit 1
  fi
  CANDIDATE_LIB_PATH="$CANDIDATE_ROOT/usr/lib/x86_64-linux-gnu:$CANDIDATE_ROOT/lib/x86_64-linux-gnu:$CANDIDATE_ROOT/usr/lib:$CANDIDATE_ROOT/lib"
  if [[ -x "$RESULTS_DIR/zlib-bench" ]]; then
    candidate_zlib="$(LD_LIBRARY_PATH="$CANDIDATE_LIB_PATH" ldd "$RESULTS_DIR/zlib-bench" | awk '/libz.so.1/ {print $3; exit}')"
    case "$candidate_zlib" in
      "$CANDIDATE_ROOT"/*) echo "Candidate zlib verified: $candidate_zlib" ;;
      *) echo "Candidate libz.so.1 was not selected by the loader: $candidate_zlib" >&2; exit 1 ;;
    esac
  else
    echo "NOTE: Direct zlib benchmark skipped; baseline did not create zlib-bench."
  fi
fi

if [[ "$MODE" == "baseline" ]]; then
  echo "profile,corpus,codec,input_bytes,archive_bytes,ratio,compress_seconds,compress_MiB_s,decompress_seconds,decompress_MiB_s,input_sha256" > "$RESULTS_DIR/baseline.csv.tmp"
else
  echo "profile,corpus,codec,input_bytes,archive_bytes,ratio,compress_seconds,compress_MiB_s,decompress_seconds,decompress_MiB_s,input_sha256" > "$RESULTS_DIR/candidate.csv.tmp"
fi

resolve_tool() {
  local codec="$1"
  if [[ "$MODE" == "candidate" ]]; then
    case "$codec" in
      7z)
        if [[ -x "$CANDIDATE_ROOT/usr/bin/7zz" ]]; then
          echo "$CANDIDATE_ROOT/usr/bin/7zz"
        elif [[ -x "$CANDIDATE_ROOT/usr/bin/7z" ]]; then
          echo "$CANDIDATE_ROOT/usr/bin/7z"
        elif [[ -x "$CANDIDATE_ROOT/usr/bin/7za" ]]; then
          echo "$CANDIDATE_ROOT/usr/bin/7za"
        elif [[ -x "$CANDIDATE_ROOT/usr/lib/p7zip/7z" ]]; then
          echo "$CANDIDATE_ROOT/usr/lib/p7zip/7z"
        else
          return 1
        fi
        ;;
      xz|lzma) [[ -x "$CANDIDATE_ROOT/usr/bin/xz" ]] && echo "$CANDIDATE_ROOT/usr/bin/xz" || return 1 ;;
      zlib) [[ -x "$RESULTS_DIR/zlib-bench" ]] && echo "$RESULTS_DIR/zlib-bench" || return 1 ;;
      zstd|lz4|gzip) [[ -x "$CANDIDATE_ROOT/usr/bin/$codec" ]] && echo "$CANDIDATE_ROOT/usr/bin/$codec" || return 1 ;;
    esac
  else
    case "$codec" in
      7z)
        if [[ -x /usr/bin/7zz ]]; then echo /usr/bin/7zz
        elif [[ -x /usr/lib/p7zip/7z ]]; then echo /usr/lib/p7zip/7z
        elif command -v 7z >/dev/null 2>&1; then command -v 7z
        elif command -v 7za >/dev/null 2>&1; then command -v 7za
        else return 1
        fi
        ;;
      xz|lzma) command -v xz || return 1 ;;
      zlib) [[ -x "$RESULTS_DIR/zlib-bench" ]] && echo "$RESULTS_DIR/zlib-bench" || return 1 ;;
      zstd|lz4|gzip) command -v "$codec" || return 1 ;;
    esac
  fi
}

run_tool() {
  if [[ "$MODE" == "candidate" ]]; then
    LD_LIBRARY_PATH="$CANDIDATE_LIB_PATH" "$@"
  else
    "$@"
  fi
}

compress_one() {
  local codec="$1" bin="$2" corpus="$3" archive="$4"
  rm -f "$archive"
  case "$codec" in
    7z)
      (cd "$CORPUS_DIR" && run_tool "$bin" a -t7z -mx=5 -mmt=1 -bd -y "$archive" "$(basename "$corpus")" >/dev/null 2>&1)
      ;;
    xz) run_tool "$bin" -6 -T1 -c "$corpus" > "$archive" ;;
    lzma) run_tool "$bin" --format=lzma -6 -T1 -c "$corpus" > "$archive" ;;
    zstd) run_tool "$bin" -3 -T1 -c "$corpus" > "$archive" ;;
    lz4) run_tool "$bin" -1 -c "$corpus" > "$archive" ;;
    gzip) run_tool "$bin" -6 -c "$corpus" > "$archive" ;;
    zlib) run_tool "$bin" compress "$corpus" > "$archive" ;;
  esac
}

decompress_one() {
  local codec="$1" bin="$2" archive="$3"
  case "$codec" in
    7z) run_tool "$bin" x -so "$archive" ;;
    xz|lzma) run_tool "$bin" -dc "$archive" ;;
    zstd) run_tool "$bin" -dc "$archive" ;;
    lz4) run_tool "$bin" -dc "$archive" ;;
    gzip) run_tool "$bin" -dc "$archive" ;;
    zlib) run_tool "$bin" decompress "$archive" ;;
  esac
}

elapsed_seconds() {
  awk -v start="$1" -v finish="$2" 'BEGIN { printf "%.6f", (finish - start) / 1000000000 }'
}

median_seconds() {
  sort -n "$1" | sed -n '2p'
}

run_benchmarks() {
  local out_csv="$1"
  local corpus codec bin corpus_name archive input_bytes input_hash archive_bytes
  local comp_times dec_times rep start finish comp_sec dec_sec comp_speed dec_speed ratio verify_hash
  local codecs=(7z xz lzma zstd lz4 gzip)
  [[ -x "$RESULTS_DIR/zlib-bench" ]] && codecs+=(zlib)
  for corpus in "$CORPUS_DIR/text.bin" "$CORPUS_DIR/binary.bin"; do
    corpus_name="$(basename "$corpus" .bin)"
    input_bytes="$(stat -c %s "$corpus")"
    input_hash="$(sha256sum "$corpus" | awk '{print $1}')"
    for codec in "${codecs[@]}"; do
      if ! bin="$(resolve_tool "$codec")"; then
        if [[ "$MODE" == "candidate" ]]; then
          echo "Missing candidate executable for $codec; package set is incomplete." >&2
          exit 1
        fi
        echo "Skipping $codec: not installed on this Dell."
        continue
      fi
      echo "[$MODE] $corpus_name / $codec"
      archive="$TMP_DIR/$corpus_name-$codec.archive"
      comp_times="$TMP_DIR/$corpus_name-$codec-compress.times"
      dec_times="$TMP_DIR/$corpus_name-$codec-decompress.times"
      : > "$comp_times"
      : > "$dec_times"
      for rep in 1 2 3; do
        start="$(date +%s%N)"
        compress_one "$codec" "$bin" "$corpus" "$archive"
        finish="$(date +%s%N)"
        elapsed_seconds "$start" "$finish" >> "$comp_times"
      done
      for rep in 1 2 3; do
        start="$(date +%s%N)"
        decompress_one "$codec" "$bin" "$archive" > /dev/null
        finish="$(date +%s%N)"
        elapsed_seconds "$start" "$finish" >> "$dec_times"
      done
      decompress_one "$codec" "$bin" "$archive" > "$TMP_DIR/verify.bin"
      if ! cmp -s "$corpus" "$TMP_DIR/verify.bin"; then
        echo "Data verification failed: $codec / $corpus_name" >&2
        exit 1
      fi
      comp_sec="$(median_seconds "$comp_times")"
      dec_sec="$(median_seconds "$dec_times")"
      archive_bytes="$(stat -c %s "$archive")"
      comp_speed="$(awk -v b="$input_bytes" -v t="$comp_sec" 'BEGIN { if (t>0) printf "%.3f", (b/1048576)/t; else print "0" }')"
      dec_speed="$(awk -v b="$input_bytes" -v t="$dec_sec" 'BEGIN { if (t>0) printf "%.3f", (b/1048576)/t; else print "0" }')"
      ratio="$(awk -v i="$input_bytes" -v o="$archive_bytes" 'BEGIN { if (o>0) printf "%.3f", i/o; else print "0" }')"
      echo "$MODE,$corpus_name,$codec,$input_bytes,$archive_bytes,$ratio,$comp_sec,$comp_speed,$dec_sec,$dec_speed,$input_hash" >> "$out_csv"
    done
  done
}

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
if [[ "$MODE" == "candidate" ]]; then
  run_benchmarks "$RESULTS_DIR/candidate.csv.tmp"
  mv "$RESULTS_DIR/candidate.csv.tmp" "$RESULTS_DIR/candidate.csv"
  awk -F, '
    NR == FNR {
      if (FNR > 1) {
        key = $2 SUBSEP $3
        bc[key] = $8
        bd[key] = $10
        br[key] = $6
      }
      next
    }
    FNR > 1 {
      key = $2 SUBSEP $3
      if (key in bc) {
        cs = (bc[key] > 0 ? $8 / bc[key] : 0)
        ds = (bd[key] > 0 ? $10 / bd[key] : 0)
        rd = (br[key] > 0 ? (($6 / br[key]) - 1) * 100 : 0)
        printf "%s\t%s\t%.3fx\t%.3fx\t%s\t%s\t%+.2f%%\n", $2, $3, cs, ds, br[key], $6, rd
      }
    }
  ' "$RESULTS_DIR/baseline.csv" "$RESULTS_DIR/candidate.csv" > "$RESULTS_DIR/comparison.tsv"
  {
    echo "Corpus  Codec  Compress_speedup  Decompress_speedup  Baseline_ratio  Candidate_ratio  Ratio_change"
    cat "$RESULTS_DIR/comparison.tsv"
  } > "$RESULTS_DIR/comparison-report.txt"
  echo "Candidate results: $RESULTS_DIR/candidate.csv"
  echo "Comparison:        $RESULTS_DIR/comparison-report.txt"
else
  run_benchmarks "$RESULTS_DIR/baseline.csv.tmp"
  mv "$RESULTS_DIR/baseline.csv.tmp" "$RESULTS_DIR/baseline.csv"
  echo "Baseline results: $RESULTS_DIR/baseline.csv"
  echo "System details:   $RESULTS_DIR/system-baseline.txt"
fi
