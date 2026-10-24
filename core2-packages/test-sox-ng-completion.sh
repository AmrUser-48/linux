#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
completion_file=${SOX_NG_COMPLETION_FILE:-$script_dir/sox-ng.bash-completion}
[[ -r $completion_file ]] || { echo "missing completion file: $completion_file" >&2; exit 1; }

real_sox_ng=$(type -P sox_ng 2>/dev/null || true)
real_sox=$(type -P sox 2>/dev/null || true)
real_sox=${real_sox_ng:-$real_sox}
[[ -n $real_sox ]] || { echo 'no SoX executable available for completion tests' >&2; exit 1; }

tmp_root=$(mktemp -d)
trap 'rm -rf "$tmp_root"' EXIT
mkdir -p "$tmp_root/bin" "$tmp_root/home" "$tmp_root/cache"
export HOME="$tmp_root/home"
export XDG_CACHE_HOME="$tmp_root/cache"
export SOX_NG_COMPLETION_TEST_LOG="$tmp_root/sox-calls.log"
: > "$SOX_NG_COMPLETION_TEST_LOG"

# Wrap SoX only in the test PATH so the test can prove that metadata is loaded
# once, then reused for every subsequent completion request.
make_wrapper() {
  local name=$1 target=$2
  cat > "$tmp_root/bin/$name" <<'WRAPPER'
#!/usr/bin/env bash
printf '%s\n' "$*" >> "$SOX_NG_COMPLETION_TEST_LOG"
exec "$SOX_NG_COMPLETION_TEST_REAL" "$@"
WRAPPER
  chmod 755 "$tmp_root/bin/$name"
  if [[ $name == sox_ng ]]; then export SOX_NG_COMPLETION_TEST_REAL="$target"; fi
}
if [[ -n $real_sox_ng ]]; then
  make_wrapper sox_ng "$real_sox_ng"
  [[ -z $real_sox ]] || :
fi
# If a separate sox_ng executable was found, the loader prefers that wrapper.
# Otherwise wrap the standard sox command instead.
if [[ -z $real_sox_ng ]]; then
  make_wrapper sox "$real_sox"
  export SOX_NG_COMPLETION_TEST_REAL="$real_sox"
fi
# Use the chosen target in the wrapper environment, avoiding recursive PATH lookup.
export PATH="$tmp_root/bin:$PATH"

# The installed script discovers this helper via its standard package path;
# local source-tree tests discover the sibling Python script automatically.
source "$completion_file"

complete_line() {
  COMP_WORDS=("$@")
  COMP_CWORD=$((${#COMP_WORDS[@]} - 1))
  _sox_ng_completion
}
contains() {
  local wanted=$1 item
  for item in "${COMPREPLY[@]}"; do [[ $item == "$wanted" ]] && return 0; done
  echo "FAIL: expected completion '$wanted', got: ${COMPREPLY[*]:-(none)}" >&2
  return 1
}

complete_line sox -t a
contains aiff
complete_line sox --buffer ''
contains 8192
complete_line sox --play-rate-arg ''
contains -l
complete_line sox -A ''
contains 440
# Device names are offered only for directions advertised by the format handler.
complete_line sox -t ''
for device in "${_SOX_NG_DEVICES[@]}"; do
  if _sox_ng_has_word "$device" "${_SOX_NG_READ_FORMATS[@]}"; then
    contains "$device"
  elif _sox_ng_has_word "$device" "${COMPREPLY[@]}"; then
    echo "FAIL: write-only device $device was offered as an input format" >&2
    exit 1
  fi
done

complete_line sox input.wav output.wav -t ''
for device in "${_SOX_NG_DEVICES[@]}"; do
  if _sox_ng_has_word "$device" "${_SOX_NG_WRITE_FORMATS[@]}"; then
    contains "$device"
  elif _sox_ng_has_word "$device" "${COMPREPLY[@]}"; then
    echo "FAIL: read-only device $device was offered as an output format" >&2
    exit 1
  fi
done

complete_line sox input.wav -t ''
for device in "${_SOX_NG_DEVICES[@]}"; do
  if _sox_ng_has_word "$device" "${_SOX_NG_READ_FORMATS[@]}" ||
     _sox_ng_has_word "$device" "${_SOX_NG_WRITE_FORMATS[@]}"; then
    contains "$device"
  elif _sox_ng_has_word "$device" "${COMPREPLY[@]}"; then
    echo "FAIL: unsupported device $device was offered for a file" >&2
    exit 1
  fi
done

complete_line sox input.wav output.wav ga
contains gain
complete_line sox input.wav output.wav lou
contains loudness

complete_line sox input.wav output.wav gain -
contains -n

complete_line sox input.wav output.wav highpass -
contains -1
contains -2

# Effect flags must not be mistaken for global/format options.
complete_line sox input.wav output.wav gain -b ''
contains -n
if _sox_ng_has_word 2 "${COMPREPLY[@]}"; then
  echo 'FAIL: gain -b was mistaken for global -b BITS' >&2
  exit 1
fi

complete_line sox input.wav output.wav dither -f ''
contains shibata

complete_line sox -n output.wav synth ''
contains synth

# SoX NG provides EBU loudness reporting as `stat -e` in versions that expose it.
if [[ " ${_SOX_NG_EFFECT_FLAGS[stat]:-} " == *' -e '* ]]; then
  complete_line sox input.wav output.wav stat -
  contains -e
fi

# Read-only formats must not be offered for the output -t position.
if _sox_ng_has_word m4a "${_SOX_NG_FORMATS[@]}" &&
   ! _sox_ng_has_word m4a "${_SOX_NG_WRITE_FORMATS[@]}"; then
  complete_line sox input.wav output.wav -t m4a
  if _sox_ng_has_word m4a "${COMPREPLY[@]}"; then
    echo 'FAIL: read-only m4a was offered at explicit output type position' >&2
    exit 1
  fi
  # After exactly one input, another input or the output is still possible;
  # allow the union of readable and writable types until the output filename exists.
  complete_line sox input.wav -t m4a
  contains m4a
fi

# The first completion should query SoX exactly three times. Subsequent Tab
# simulations must use cached data without launching SoX again.
call_count=$(wc -l < "$SOX_NG_COMPLETION_TEST_LOG")
[[ $call_count -eq 3 ]] || {
  echo "FAIL: expected 3 SoX metadata calls after first completion, got $call_count" >&2
  cat "$SOX_NG_COMPLETION_TEST_LOG" >&2
  exit 1
}
complete_line sox input.wav output.wav gain -
call_count_after=$(wc -l < "$SOX_NG_COMPLETION_TEST_LOG")
[[ $call_count_after -eq $call_count ]] || {
  echo "FAIL: completion launched SoX again ($call_count -> $call_count_after calls)" >&2
  exit 1
}

printf 'PASS: formats, effects, effect flags/values, read-only filtering, and cache reuse.\n'
