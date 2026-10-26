#!/usr/bin/env python3
"""Build a Bash cache of metadata reported by the installed SoX NG binary."""

from __future__ import annotations

import argparse
import os
import re
import shlex
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

TOKEN_RE = re.compile(r"^[A-Za-z0-9_.+%:/=@-]+$")
EFFECT_FLAG_RE = re.compile(r"(?<![A-Za-z0-9_])(--[A-Za-z][A-Za-z0-9-]*|-[A-Za-z0-9])(?=$|[\s|\]\[])")


def call(sox: str, *args: str) -> str:
    env = os.environ.copy()
    env["LC_ALL"] = "C"
    env["LANG"] = "C"
    try:
        p = subprocess.run(
            [sox, *args], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
            text=True, encoding="utf-8", errors="replace", env=env, timeout=45,
            check=False,
        )
    except (OSError, subprocess.TimeoutExpired) as exc:
        raise RuntimeError(f"failed to query {sox}: {exc}") from exc
    if not p.stdout.strip():
        raise RuntimeError(f"{sox} {' '.join(args)} returned no help text")
    return p.stdout


def values_on_line(text: str, label: str) -> list[str]:
    match = re.search(r"^\s*" + re.escape(label) + r"\s*(.*)$", text, re.M)
    if not match:
        return []
    return [word for word in match.group(1).split() if TOKEN_RE.fullmatch(word)]


def parse_format_capabilities(text: str) -> tuple[list[str], list[str]]:
    readable: set[str] = set()
    writable: set[str] = set()
    current: dict[str, object] | None = None
    blocks: list[dict[str, object]] = []

    def finish() -> None:
        nonlocal current
        if current:
            blocks.append(current)
        current = None

    for line in text.splitlines():
        m = re.match(r"^Format:\s*(\S+)", line)
        if m:
            finish()
            name = m.group(1)
            current = {"names": [name] if TOKEN_RE.fullmatch(name) else [], "reads": False, "writes": False}
            continue
        if current is None:
            continue
        m = re.match(r"^Also handles:\s*(.*)$", line)
        if m:
            current["names"].extend(w for w in m.group(1).split() if TOKEN_RE.fullmatch(w))
        m = re.match(r"^Reads:\s*(yes|no)\s*$", line)
        if m:
            current["reads"] = m.group(1) == "yes"
        if re.match(r"^Writes:\s*(?:yes)?\s*$", line):
            current["writes"] = True
        elif re.match(r"^Writes:\s*no\s*$", line):
            current["writes"] = False
        elif re.match(r"^Writes:\s*$", line):
            # SoX NG prints a list of supported encodings after this header.
            current["writes"] = True
    finish()

    for block in blocks:
        names = block["names"]
        if block["reads"]:
            readable.update(names)
        if block["writes"]:
            writable.update(names)
    return sorted(readable), sorted(writable)


def parse_effect_metadata(
    text: str, effect_names: list[str]
) -> tuple[dict[str, list[str]], dict[str, list[str]]]:
    """Extract synopsis flags and documented enumerated flag arguments."""
    known = set(effect_names)
    flags: dict[str, list[str]] = {}
    flag_values: dict[str, list[str]] = {}
    current = ""
    pending_key = ""
    pending_values: list[str] = []

    def finish_values() -> None:
        nonlocal pending_key, pending_values
        if pending_key and pending_values:
            flag_values[pending_key] = sorted(set(pending_values))
        pending_key = ""
        pending_values = []

    for line in text.splitlines():
        if line and not line[0].isspace():
            finish_values()
            fields = line.split(None, 1)
            current = fields[0] if fields and fields[0] in known else ""
            if current:
                usage = fields[1] if len(fields) > 1 else ""
                flags[current] = sorted(set(EFFECT_FLAG_RE.findall(usage)))
            continue

        if not line.strip():
            finish_values()
            continue
        if not current:
            continue

        option_match = re.match(r"^\s+(-{1,2}[A-Za-z0-9][A-Za-z0-9-]*)\s+([A-Za-z][A-Za-z0-9_-]*)\b", line)
        values_match = re.search(r"\bone of:\s*(.+?)\s*$", line, re.I)
        if option_match and values_match:
            finish_values()
            pending_key = f"{current}:{option_match.group(1)}"
            value_text = values_match.group(1)
            pending_values.extend(re.findall(r"[A-Za-z0-9][A-Za-z0-9_.+-]*", value_text))
            if value_text.rstrip().endswith("."):
                if pending_values:
                    pending_values[-1] = pending_values[-1].rstrip(".,;:")
                finish_values()
            continue

        # Wrapped enumerations continue on indented lines until their final period
        # or the next documented option (which itself often ends with '!').
        if pending_key:
            if re.match(r"^\s+-{1,2}[A-Za-z0-9][A-Za-z0-9-]*\s+\S+", line):
                finish_values()
            else:
                pending_values.extend(re.findall(r"[A-Za-z0-9][A-Za-z0-9_.+-]*", line))
                if line.rstrip().endswith("."):
                    if pending_values:
                        pending_values[-1] = pending_values[-1].rstrip(".,;:")
                    finish_values()

    finish_values()
    return flags, flag_values


def bash_quote(value: str) -> str:
    # Bash %q-style quoting via shlex is safe here because generated values are
    # tokens validated against TOKEN_RE, or short help/version strings.
    return shlex.quote(value)


def bash_array(name: str, values: list[str]) -> str:
    valid = sorted({v for v in values if TOKEN_RE.fullmatch(v)})
    return f"declare -ga {name}=({ ' '.join(bash_quote(v) for v in valid) })"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--sox", default=os.environ.get("SOX_NG_COMPLETION_SOX"))
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    sox = args.sox or shutil.which("sox_ng") or shutil.which("sox")
    if not sox:
        print("sox-ng-completion-cache: cannot find sox_ng or sox", file=sys.stderr)
        return 1

    try:
        help_text = call(sox, "--help")
        effects_text = call(sox, "--help-effect", "all")
        formats_text = call(sox, "--help-format", "all")
    except RuntimeError as exc:
        print(f"sox-ng-completion-cache: {exc}", file=sys.stderr)
        return 1

    formats = values_on_line(help_text, "AUDIO FILE FORMATS:")
    devices = values_on_line(help_text, "AUDIO DEVICE DRIVERS:")
    effects = values_on_line(help_text, "EFFECTS:")
    read_formats, write_formats = parse_format_capabilities(formats_text)
    has_format_details = bool(re.search(r"^Format:\s*\S+", formats_text, re.M))

    # If this SoX-compatible binary uses a different help layout, degrade to
    # unfiltered types. Do not mark formats writable when valid metadata explicitly
    # says that no supported format can write.
    if not has_format_details:
        read_formats = formats.copy()
        write_formats = formats.copy()

    flags, flag_values = parse_effect_metadata(effects_text, effects)
    version = next((line.strip() for line in help_text.splitlines() if "SoX_ng v" in line or "SoX v" in line), "SoX NG")

    lines = [
        "# Generated by sox-ng-completion-cache.py; do not edit.",
        f"_SOX_NG_COMPLETION_VERSION={bash_quote(version)}",
        bash_array("_SOX_NG_FORMATS", formats),
        bash_array("_SOX_NG_READ_FORMATS", read_formats),
        bash_array("_SOX_NG_WRITE_FORMATS", write_formats),
        bash_array("_SOX_NG_DEVICES", devices),
        bash_array("_SOX_NG_EFFECTS", effects),
        "declare -gA _SOX_NG_EFFECT_FLAGS=()",
        "declare -gA _SOX_NG_EFFECT_FLAG_VALUES=()",
    ]
    for name in sorted(flags):
        lines.append(f"_SOX_NG_EFFECT_FLAGS[{bash_quote(name)}]={bash_quote(' '.join(flags[name]))}")
    for key in sorted(flag_values):
        lines.append(f"_SOX_NG_EFFECT_FLAG_VALUES[{bash_quote(key)}]={bash_quote(' '.join(flag_values[key]))}")
    content = "\n".join(lines) + "\n"

    try:
        args.output.parent.mkdir(mode=0o700, parents=True, exist_ok=True)
        os.chmod(args.output.parent, 0o700)
        fd, tmp_name = tempfile.mkstemp(prefix=".sox-ng-completion-", dir=args.output.parent, text=True)
        with os.fdopen(fd, "w", encoding="utf-8") as tmp:
            tmp.write(content)
            tmp.flush()
            os.fsync(tmp.fileno())
        os.chmod(tmp_name, 0o600)
        os.replace(tmp_name, args.output)
        os.chmod(args.output, 0o600)
    except OSError as exc:
        print(f"sox-ng-completion-cache: cannot write {args.output}: {exc}", file=sys.stderr)
        return 1

    print(
        f"Cached {len(formats)} formats, {len(devices)} devices, "
        f"{len(effects)} effects to {args.output}",
        file=sys.stderr,
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
