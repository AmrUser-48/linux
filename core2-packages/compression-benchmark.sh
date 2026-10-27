#!/usr/bin/env bash
# One run: compare installed compression tools with the downloaded Core 2 O3 .debs.
# No installation. Uses the already-saved 16 MiB test files.
WORK="$HOME/Downloads/compression-bench-results"
CORPUS="$WORK/corpus"
DEBS="$HOME/Downloads/core2-o3-debs-20261027"
TMP="$(mktemp -d "$HOME/Downloads/compression-speed.XXXXXX")"
ROOT="$TMP/o3-root"
mkdir -p "$ROOT"

if [[ ! -s "$CORPUS/text.bin" || ! -s "$CORPUS/binary.bin" ]]; then
  echo "Test data not found under $CORPUS; run the existing baseline setup first."
elif [[ ! -d "$DEBS" ]]; then
  echo "O3 .deb directory not found: $DEBS"
else
  count=0
  for deb in "$DEBS"/*.deb; do
    if [[ -f "$deb" ]]; then
      dpkg-deb -x "$deb" "$ROOT"
      count=$((count + 1))
    fi
  done

  if [[ "$count" -eq 0 ]]; then
    echo "No .deb files found in $DEBS"
  else
    LIBS="$ROOT/usr/lib/x86_64-linux-gnu:$ROOT/lib/x86_64-linux-gnu:$ROOT/usr/lib:$ROOT/lib"

    pick_tool() {
      if [[ "$profile" == "O3" ]]; then
        for name in "$@"; do
          for path in "$ROOT/usr/bin/$name" "$ROOT/bin/$name" "$ROOT/usr/lib/p7zip/$name"; do
            if [[ -x "$path" ]]; then printf '%s\n' "$path"; return 0; fi
          done
        done
      else
        for name in "$@"; do
          found="$(command -v "$name" 2>/dev/null)"
          if [[ -n "$found" ]]; then printf '%s\n' "$found"; return 0; fi
        done
      fi
      return 1
    }

    run_tool() {
      if [[ "$profile" == "O3" ]]; then
        LD_LIBRARY_PATH="$LIBS${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}" "$@"
      else
        "$@"
      fi
    }

    compress_one() {
      case "$codec" in
        7z) (cd "$CORPUS" && run_tool "$SEVENZ" a -t7z -mx=5 -mmt=1 -bd -y "$archive" "$(basename "$input")" >/dev/null 2>&1) ;;
        xz) run_tool "$XZ" -6 -T1 -c "$input" > "$archive" ;;
        lzma) run_tool "$XZ" --format=lzma -6 -T1 -c "$input" > "$archive" ;;
        zstd) run_tool "$ZSTD" -3 -T1 -q -c "$input" > "$archive" ;;
        lz4) run_tool "$LZ4" -1 -q -c "$input" > "$archive" ;;
        gzip) run_tool "$GZIP" -6 -c "$input" > "$archive" ;;
      esac
    }

    decompress_one() {
      case "$codec" in
        7z) run_tool "$SEVENZ" x -so "$archive" 2>/dev/null ;;
        xz|lzma) run_tool "$XZ" -dc "$archive" ;;
        zstd) run_tool "$ZSTD" -q -dc "$archive" ;;
        lz4) run_tool "$LZ4" -q -dc "$archive" ;;
        gzip) run_tool "$GZIP" -dc "$archive" ;;
      esac
    }

    median_ns() { sort -n "$1" | sed -n '2p'; }

    echo "Compression benchmark: installed system vs extracted O3 packages"
    echo "Same inputs; 3-run median; no packages installed."
    echo "Dataset: $CORPUS"
    echo "O3 packages extracted to: $ROOT"
    echo

    for profile in system O3; do
      SEVENZ="$(pick_tool 7zz 7z 7za)"
      XZ="$(pick_tool xz)"
      ZSTD="$(pick_tool zstd)"
      LZ4="$(pick_tool lz4)"
      GZIP="$(pick_tool gzip)"

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
            echo "$profile $corpus_name $codec: executable missing; skipped"
            continue
          fi

          archive="$TMP/$profile-$corpus_name-$codec.archive"
          comp_times="$TMP/$profile-$corpus_name-$codec-comp.times"
          dec_times="$TMP/$profile-$corpus_name-$codec-dec.times"
          : > "$comp_times"
          : > "$dec_times"

          for rep in 1 2 3; do
            rm -f "$archive"
            start="$(date +%s%N)"
            compress_one
            finish="$(date +%s%N)"
            printf '%s\n' "$((finish - start))" >> "$comp_times"
          done

          if [[ ! -s "$archive" ]]; then
            echo "$profile $corpus_name $codec: compression failed; skipped"
            continue
          fi

          for rep in 1 2 3; do
            start="$(date +%s%N)"
            decompress_one > /dev/null
            finish="$(date +%s%N)"
            printf '%s\n' "$((finish - start))" >> "$dec_times"
          done

          decompress_one > "$TMP/verify.bin"
          if ! cmp -s "$input" "$TMP/verify.bin"; then
            echo "$profile $corpus_name $codec: VERIFY FAILED; skipped"
            continue
          fi

          comp_ns="$(median_ns "$comp_times")"
          dec_ns="$(median_ns "$dec_times")"
          out_bytes="$(stat -c %s "$archive")"
          comp_speed="$(awk -v b="$bytes" -v n="$comp_ns" 'BEGIN { printf "%.2f", b/1048576/(n/1000000000) }')"
          dec_speed="$(awk -v b="$bytes" -v n="$dec_ns" 'BEGIN { printf "%.2f", b/1048576/(n/1000000000) }')"
          ratio="$(awk -v a="$bytes" -v b="$out_bytes" 'BEGIN { printf "%.3f", a/b }')"
          printf '%-6s %-6s %-5s compress %7s MiB/s  decompress %7s MiB/s  ratio %s:1\n' "$profile" "$corpus_name" "$codec" "$comp_speed" "$dec_speed" "$ratio"
        done
      done
      echo
    done
    echo "Finished. Temporary test files: $TMP"
  fi
fi
