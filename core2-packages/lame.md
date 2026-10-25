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
