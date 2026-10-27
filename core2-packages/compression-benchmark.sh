#!/usr/bin/env bash
# One run: installed compressors vs downloaded O3 .debs. No installation.
WORK="$HOME/Downloads/compression-bench-results"
CORPUS="$WORK/corpus"
DEBS="$HOME/Downloads/core2-o3-debs-20261027"
TMP="$(mktemp -d "$HOME/Downloads/compression-speed.XXXXXX")"
ROOT="$TMP/o3"
mkdir -p "$ROOT"

if [[ ! -s "$CORPUS/text.bin" || ! -s "$CORPUS/binary.bin" ]]; then
  echo "Missing saved test data: $CORPUS"
elif [[ ! -d "$DEBS" ]]; then
  echo "Missing O3 package directory: $DEBS"
else
  for deb in "$DEBS"/*.deb; do
    [[ -f "$deb" ]] && dpkg-deb -x "$deb" "$ROOT"
  done

  LIBS="$ROOT/usr/lib/x86_64-linux-gnu:$ROOT/lib/x86_64-linux-gnu:$ROOT/usr/lib:$ROOT/lib"

  pick() {
    if [[ "$profile" == O3 ]]; then
      for name in "$@"; do
        for p in "$ROOT/usr/bin/$name" "$ROOT/bin/$name" "$ROOT/usr/lib/p7zip/$name"; do
          [[ -x "$p" ]] && { echo "$p"; return; }
        done
      done
    else
      for name in "$@"; do
        p="$(command -v "$name" 2>/dev/null)"
        [[ -n "$p" ]] && { echo "$p"; return; }
      done
    fi
  }

  run() {
    if [[ "$profile" == O3 ]]; then
      LD_LIBRARY_PATH="$LIBS${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}" "$@"
    else
      "$@"
    fi
  }

  compress_one() {
    case "$codec" in
      7z) (cd "$CORPUS" && run "$SEVENZ" a -t7z -mx=5 -mmt=1 -bd -y "$archive" "$(basename "$input")" >/dev/null 2>&1) ;;
      xz) run "$XZ" -6 -T1 -c "$input" > "$archive" ;;
      lzma) run "$XZ" --format=lzma -6 -T1 -c "$input" > "$archive" ;;
      zstd) run "$ZSTD" -3 -T1 -q -c "$input" > "$archive" ;;
      lz4) run "$LZ4" -1 -q -c "$input" > "$archive" ;;
      gzip) run "$GZIP" -6 -c "$input" > "$archive" ;;
    esac
  }

  decompress_one() {
    case "$codec" in
      7z) run "$SEVENZ" x -so "$archive" 2>/dev/null ;;
      xz|lzma) run "$XZ" -dc "$archive" ;;
      zstd) run "$ZSTD" -q -dc "$archive" ;;
      lz4) run "$LZ4" -q -dc "$archive" ;;
      gzip) run "$GZIP" -dc "$archive" ;;
    esac
  }

  echo "PROFILE CORPUS  CODEC  COMPRESS_MiB/s  DECOMPRESS_MiB/s  RATIO"
  echo "Same saved 16 MiB files; three-run medians. No packages installed."
  for profile in system O3; do
    SEVENZ="$(pick 7zz 7z 7za)"
    XZ="$(pick xz)"
    ZSTD="$(pick zstd)"
    LZ4="$(pick lz4)"
    GZIP="$(pick gzip)"

    for input in "$CORPUS/text.bin" "$CORPUS/binary.bin"; do
      corpus_name="$(basename "$input" .bin)"
      bytes="$(stat -c %s "$input")"
      for codec in 7z xz lzma zstd lz4 gzip; do
        case "$codec" in
          7z) bin="$SEVENZ" ;;
          xz|lzma) bin="$XZ" ;;
          zstd) bin="$ZSTD" ;;
          lz4) bin="$LZ4" ;;
          gzip) bin="$GZIP" ;;
        esac
        if [[ -z "$bin" || ! -x "$bin" ]]; then
          echo "$profile $corpus_name $codec: missing; skipped"
          continue
        fi

        archive="$TMP/$profile-$corpus_name-$codec"
        ct="$TMP/$profile-$corpus_name-$codec-compress.times"
        dt="$TMP/$profile-$corpus_name-$codec-decompress.times"
        : > "$ct"
        : > "$dt"
        for n in 1 2 3; do
          rm -f "$archive"
          start="$(date +%s%N)"
          compress_one
          finish="$(date +%s%N)"
          echo "$((finish-start))" >> "$ct"
        done
        if [[ ! -s "$archive" ]]; then
          echo "$profile $corpus_name $codec: compression failed; skipped"
          continue
        fi

        for n in 1 2 3; do
          start="$(date +%s%N)"
          decompress_one > /dev/null
          finish="$(date +%s%N)"
          echo "$((finish-start))" >> "$dt"
        done
        decompress_one > "$TMP/verify"
        if ! cmp -s "$input" "$TMP/verify"; then
          echo "$profile $corpus_name $codec: verification failed; skipped"
          continue
        fi

        comp_ns="$(sort -n "$ct" | sed -n '2p')"
        dec_ns="$(sort -n "$dt" | sed -n '2p')"
        out_bytes="$(stat -c %s "$archive")"
        comp_speed="$(awk -v b="$bytes" -v n="$comp_ns" 'BEGIN {printf "%.2f",b/1048576/(n/1000000000)}')"
        dec_speed="$(awk -v b="$bytes" -v n="$dec_ns" 'BEGIN {printf "%.2f",b/1048576/(n/1000000000)}')"
        ratio="$(awk -v a="$bytes" -v b="$out_bytes" 'BEGIN {printf "%.3f",a/b}')"
        printf '%-7s %-7s %-6s %-15s %-17s %s:1\n' "$profile" "$corpus_name" "$codec" "$comp_speed" "$dec_speed" "$ratio"
      done
    done
  done
  echo "Temporary files: $TMP"
fi
