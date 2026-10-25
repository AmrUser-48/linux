# LAME / libmp3lame — Intel Core 2 optimization

Target machine: **Dell Latitude D630, Intel Core 2 Duo T7250 (2 cores, 2.00 GHz), Debian 12 Bookworm, amd64**.

The target benchmark is deliberately CPU-intensive: 44.1 kHz stereo, 20-second synthetic audio, LAME CBR 320 kb/s with `-q0`. Keep the input, encoder arguments, and machine conditions the same when comparing builds.

## Historical D630 results

These are the original results recorded for this machine. They are **physical-machine measurements**, separate from the later GitHub-host and QEMU experiments below.

| Build | Recorded compiler flags / profile | Speed | Change vs. generic baseline |
|---|---|---:|---:|
| Debian package, generic | Debian package defaults | 4.0× | Baseline |
| Build 2 | `-O2 -march=core2 -mtune=core2` | 5.1× | +27.5% |
| Last build (historical record) | `-O3 -march=core2 -mtune=core2 -ffast-math -funroll-loops` | 6.0× | +50.0% |

The 6.0× entry is the historical figure originally recorded here; it should not be read as a result from the CI experiment. A later test of the installed Debian build measured about 5.0×, while a remembered direct-source build measured about 5.5×. Those results need a controlled repeat on the same input and machine before they can be reconciled.

### Recovered direct-source configuration

The merged shell history contains this command (repeated three times):

```sh
CFLAGS="-O3 -march=native -ffast-math -funroll-loops" ./configure \
  --prefix=/usr/local \
  --enable-nasm \
  --enable-expopt=full
```

This is the strongest recovered clue for the earlier source build, but the history does **not** prove which measured result came from this exact configuration. `-march=native` was appropriate when compiling directly on the D630; for cross-machine CI, use explicit `-march=core2 -mtune=core2` instead.

LAME's `--enable-expopt=full` is distinct from the compiler flags. Keep it explicit when trying to reproduce this configuration. Debian's Bookworm packaging already enables `--enable-nasm`; its presence in the command alone does not prove that a NASM implementation was used on x86-64.

## Controlled three-profile package experiment

Workflow: [LAME Core 2 build and QEMU benchmark — run #40207294468](https://github.com/AmrUser-48/linux/actions/runs/40207294468). The downloadable artifact contains the three package sets, CSV measurements, trial logs, output MP3s, build matrix, and SHA-256 files.

All three variants were built from Debian Bookworm's **LAME source package 3.100-6**, in separate source trees, using the same benchmark input and command: `lame -q0 -b320 input.wav output.mp3`. Each was run three times in each mode; the tables show median results.

### Build profiles

| Variant | Compiler flags appended | LAME configure profile | Purpose |
|---|---|---|---|
| Baseline | `-O2 -march=core2 -mtune=core2` | Debian default | Control |
| Recovered | `-O3 -march=core2 -mtune=core2 -ffast-math -funroll-loops` | `--enable-expopt=full` | Reproduce the recovered optimization setup with an explicit Core 2 target |
| LTO | Recovered flags plus `-flto` at compile and link | `--enable-expopt=full` | Isolate the additional effect of link-time optimization |

Debian hardening settings remain enabled. The experiment intentionally did not add PGO or other independent optimizations.

### GitHub runner timings

These measurements run on the GitHub runner's CPU, **not** on a T7250.

| Variant | Median elapsed time | Median real-time factor | Change vs. baseline |
|---|---:|---:|---:|
| Baseline | 0.9399 s | 21.2789× | Baseline |
| Recovered | 0.8038 s | 24.8818× | **+16.9% speed** |
| LTO | 0.8064 s | 24.8016× | +16.6% speed |

On the runner, the recovered profile was 16.9% faster than baseline. Adding LTO did not improve on the recovered profile: LTO was about 0.3% slower by median real-time factor.

### QEMU Conroe timings

QEMU User Mode was also run with `-cpu Conroe`, a Core 2/Merom-class CPU feature model. This checks execution against that CPU model; it is **not cycle-accurate performance emulation** and does not reproduce the T7250's execution-pipeline timing.

| Variant | Median elapsed time | Median real-time factor | Change vs. baseline |
|---|---:|---:|---:|
| Baseline | 11.7981 s | 1.6952× | Baseline |
| Recovered | 14.4376 s | 1.3853× | **−18.3% speed** |
| LTO | 14.2944 s | 1.3991× | −17.5% speed |

The QEMU timing order differs from the GitHub-host order. **Do not select the winner for the D630 based on these QEMU timings.** They are emulator-specific. The authoritative performance measurement must be run on the physical T7250.

### Output consistency

All variants produced an MP3 of **802,480 bytes** for the test sample. The recovered and LTO variants produced identical MP3 bytes; the baseline bitstream differed. Equal file size or identical bytes alone are not a full perceptual-quality evaluation.

## Conclusions and next test

1. The recovered `-O3` / fast-math / loop-unrolling profile plus `--enable-expopt=full` won on the GitHub runner: 24.8818× versus 21.2789× for baseline.
2. LTO showed no runner-side benefit over the recovered profile.
3. QEMU timings reversed the order and are not representative of physical T7250 performance.
4. **Do not declare a D630 winner yet.** Install one candidate at a time on the D630, use the identical `-q0 -b320` workload, run repeated trials under comparable CPU/load conditions, and compare medians against the historical 5.0–5.5× results and the original recorded figures above.

For reproducibility, use the package artifacts and full logs attached to [workflow run #40207294468](https://github.com/AmrUser-48/linux/actions/runs/40207294468). The test package variants are Debian Bookworm amd64 packages and are intended for the D630-class Core 2 target.


## Physical D630 retest: Debian-generic baseline

This section records the direct test on the physical Dell Latitude D630. Keep it separate from the GitHub-runner and QEMU timings above.

### Baseline identity and isolation

The benchmark baseline is the official Debian Bookworm amd64 package pair, lame and libmp3lame0, both version 3.100-6. The packages are extracted under /tmp/lame-test/baseline; they are not installed over the system packages.

The baseline was verified with ldd: its lame executable resolves libmp3lame.so.0 to /tmp/lame-test/baseline/usr/lib/x86_64-linux-gnu/libmp3lame.so.0.0.0. Running that executable reported LAME version 3.100.

The installed and extracted recovered files were verified byte-for-byte identical:

| File | SHA-256 |
|---|---|
| /usr/bin/lame and recovered/usr/bin/lame | ee796af19fde2f6cf2b0ee1a8c2e7b4a60e6545a2e6c444b2913ce161cfdf102 |
| System and recovered libmp3lame.so.0.0.0 | 84ffde71c30b7b0c5e94569423df1ff0320b95ffbb4bc1b6a377127d913ca78f |

Therefore, system is not an independent build and is excluded from the comparison. The test compares only baseline, recovered, and lto.

### Physical D630 throughput result

Reported real-time encoding factors on the D630:

| Measurement | Encoding speed | Throughput vs. Debian generic | Status |
|---|---:|---:|---|
| Debian generic baseline | 4.0× real time | Reference | Baseline reported by user |
| Earlier optimized-build result | 5.4× real time | **+35.0%** | Previously reported result |
| Latest optimized-build reading | 6.1594× real time | **+54.0%** | Preliminary mid-run reading; not a completed run |

The latest reading came from a direct terminal run of `lame -q0 -b320 f.wav`. LAME reported `play/CPU = 6.1594x` at frame 200 of 767 (26% progress); the run was then interrupted with Ctrl+C. LAME's `play/CPU` field is the ratio of encoded audio playback duration to CPU time consumed. Because the run was stopped before completion, record 6.1594× as an observed mid-run rate, not as the final benchmark result. Against the 4.0× baseline, this snapshot corresponds to (6.1594 / 4.0 − 1) × 100 = **53.99%** greater throughput.

The command reported for the CPU setting was `sudo wrmsr -a 0x199 0x0b1c`. This writes a requested performance state to IA32_PERF_CTL; it does not by itself verify the active multiplier or actual core voltage. The 5.4× result was previously associated with a reported 10× multiplier and low-voltage setting. Verify actual operating conditions independently and keep them consistent when comparing builds.

This is a physical-machine observation, not a GitHub-runner or QEMU result. The mode-specific CBR 320 and V0 wall-clock medians still need a controlled repeat with the corrected Debian generic baseline and a completed encoding run.

### Re-create the Debian generic baseline

This extracts the official Debian packages without installing them. The subshell keeps set -e from changing the interactive shell's options. The existing baseline is replaced only after both packages have downloaded, their versions have been checked, and extraction has succeeded.

~~~sh
(
    set -eu

    mkdir -p /tmp/lame-test/debian-generic-debs
    cd /tmp/lame-test/debian-generic-debs

    wget -O lame_3.100-6_amd64.deb \
      https://deb.debian.org/debian/pool/main/l/lame/lame_3.100-6_amd64.deb
    wget -O libmp3lame0_3.100-6_amd64.deb \
      https://deb.debian.org/debian/pool/main/l/lame/libmp3lame0_3.100-6_amd64.deb

    test "$(dpkg-deb -f lame_3.100-6_amd64.deb Version)" = "3.100-6"
    test "$(dpkg-deb -f lame_3.100-6_amd64.deb Architecture)" = "amd64"
    test "$(dpkg-deb -f libmp3lame0_3.100-6_amd64.deb Version)" = "3.100-6"
    test "$(dpkg-deb -f libmp3lame0_3.100-6_amd64.deb Architecture)" = "amd64"

    rm -rf /tmp/lame-test/baseline.new
    mkdir -p /tmp/lame-test/baseline.new
    dpkg-deb -x lame_3.100-6_amd64.deb /tmp/lame-test/baseline.new
    dpkg-deb -x libmp3lame0_3.100-6_amd64.deb /tmp/lame-test/baseline.new

    test -x /tmp/lame-test/baseline.new/usr/bin/lame
    test -e /tmp/lame-test/baseline.new/usr/lib/x86_64-linux-gnu/libmp3lame.so.0

    rm -rf /tmp/lame-test/baseline
    mv /tmp/lame-test/baseline.new /tmp/lame-test/baseline

    echo "Debian generic baseline prepared."
)
~~~

### Reproducible CBR 320 and V0 benchmark

Run the script from the directory containing f.wav. It expects the three extracted package trees at /tmp/lame-test/{baseline,recovered,lto}. Each build is forced to load its own libmp3lame.so.0; ldd verifies the resolved library before timing. Five rotating trials are run for each mode, and medians are compared within that mode.

~~~python
#!/usr/bin/env python3
from pathlib import Path
import os
import subprocess
import time
import statistics

root = Path("/tmp/lame-test")
wav = Path("f.wav").resolve()
variants = ["baseline", "recovered", "lto"]
modes = {
    "cbr320": ["-q0", "-b320"],
    "v0": ["-V0"],
}
trials = 5
times = {mode: {v: [] for v in variants} for mode in modes}
executables = {}
envs = {}

if not wav.is_file():
    raise SystemExit(f"Missing input WAV: {wav}")

for v in variants:
    exe = root / v / "usr/bin/lame"
    libdir = root / v / "usr/lib/x86_64-linux-gnu"

    if not exe.is_file() or not (libdir / "libmp3lame.so.0").exists():
        raise SystemExit(f"{v}: executable or libmp3lame.so.0 missing")

    env = os.environ.copy()
    env.pop("LD_PRELOAD", None)
    env["LD_LIBRARY_PATH"] = str(libdir)

    result = subprocess.run(
        ["ldd", str(exe)],
        env=env,
        capture_output=True,
        text=True,
    )
    lines = [
        line for line in result.stdout.splitlines()
        if "libmp3lame.so.0" in line and "=>" in line
    ]

    if result.returncode or len(lines) != 1 or "not found" in lines[0]:
        raise SystemExit(
            f"{v}: could not resolve libmp3lame.so.0:\n"
            f"{result.stdout}\n{result.stderr}"
        )

    libpath = Path(
        lines[0].split("=>", 1)[1].strip().split()[0]
    ).resolve()

    if libpath.parent != libdir.resolve():
        raise SystemExit(
            f"{v}: library isolation failed.\n"
            f"Expected directory: {libdir.resolve()}\n"
            f"Actual library: {libpath}"
        )

    executables[v] = exe
    envs[v] = env
    print(f"{v:9} executable: {exe}")
    print(f"{'':9} library:    {libpath}")

print("\n=== BENCHMARK ===")

for trial in range(1, trials + 1):
    mode_order = list(modes)
    if trial % 2 == 0:
        mode_order.reverse()

    for mode in mode_order:
        mode_index = list(modes).index(mode)
        offset = (trial - 1 + mode_index) % len(variants)
        order = variants[offset:] + variants[:offset]

        for v in order:
            output = root / f"bench-{mode}-{v}-{trial}.mp3"
            output.unlink(missing_ok=True)
            command = [
                str(executables[v]),
                "-S",
                *modes[mode],
                str(wav),
                str(output),
            ]

            start = time.perf_counter()
            result = subprocess.run(
                command,
                env=envs[v],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.PIPE,
                text=True,
            )
            elapsed = time.perf_counter() - start

            if result.returncode:
                raise SystemExit(
                    f"{mode}/{v} failed in trial {trial}:\n"
                    f"{result.stderr}"
                )
            if not output.is_file() or output.stat().st_size == 0:
                raise SystemExit(f"{mode}/{v}: missing or empty MP3")

            times[mode][v].append(elapsed)
            print(f"Trial {trial}: {mode:7} {v:9} {elapsed:.3f} s")

print("\n=== MEDIAN RESULTS ===")
for mode in modes:
    baseline = statistics.median(times[mode]["baseline"])
    print(f"\n[{mode}]")
    print(f"{'Variant':10} {'Median':>10} {'vs baseline':>14}")

    for v in variants:
        median = statistics.median(times[mode][v])
        change = (baseline / median - 1) * 100
        print(f"{v:10} {median:9.3f} s {change:+12.1f}%")

print(f"\nMP3 outputs: {root}/")
~~~
