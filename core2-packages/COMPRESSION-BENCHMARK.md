# Dell D630 Core 2 compression benchmark

**The benchmark runs on the Dell, not on GitHub Actions.** GitHub Actions only builds Debian packages. Never use the runner's throughput as the performance result for the T7250.

## Build train

Workflow: `.github/workflows/d630-core2-compression-package-train.yml`

| Workflow input / Debian source | Main output packages to look for | What is measured locally |
|---|---|---|
| `p7zip` | `p7zip`, `p7zip-full` | 7z |
| `xz-utils` | `xz-utils`, `liblzma5`, development package | xz and LZMA streams |
| `zstd` (resolved from Debian package metadata to its source) | `zstd`, `libzstd1`, development package | zstd |
| `lz4` | `lz4`, `liblz4-1`, development package | lz4 |
| `gzip` | `gzip` | gzip |
| `zlib` | `zlib1g`, `zlib1g-dev` | Direct calls to libz |
| `gcc-12` | Includes `libstdc++6` and GCC runtime/toolchain packages | Candidate C++ runtime loading for compatible tools |

The compression sources use:

```text
-O3 -march=core2 -mtune=core2 -pipe -fomit-frame-pointer -ftree-vectorize
```

The foundational `gcc-12` source package stays at `-O2 -march=core2 -mtune=core2`. Its full source build is substantially heavier than the compression packages. The workflow publishes package releases; inspect the actual `.deb` assets and versions there rather than assuming every output exists before the run succeeds.

## Run the real benchmark on the Dell

Run these commands from the **same directory** in your local `AmrUser-48/linux` checkout.

### 1. Existing Debian system — baseline

```bash
bash core2-packages/compression-benchmark.sh baseline
```

This records the installed tool/library baseline and creates two fixed 16 MiB datasets. It does not install or replace system packages.

### 2. Built packages — candidate

Download the relevant `.deb` assets from the successful package-train releases and put all those `.deb` files directly into one directory, for example `~/Downloads/core2-debs/`. Then run:

```bash
bash core2-packages/compression-benchmark.sh candidate ~/Downloads/core2-debs
```

Candidate mode extracts the packages into a private test directory and uses that directory for executable and shared-library lookup. It does not run `dpkg -i` and does not overwrite the installed system libraries. It checks that the saved test-data checksums match and verifies every decompressed output.

## Results

All results are written to `compression-bench-results/` under the directory from which the commands are run:

- `baseline.csv` — installed-system timings and archive sizes.
- `candidate.csv` — rebuilt-package timings and archive sizes.
- `comparison-report.txt` — speedups, compression ratios and ratio changes.
- `candidate-packages.txt` — exact candidate package filenames, names and versions.
- `system-baseline.txt` — Dell CPU/kernel, governor and installed package versions.
- `corpus-sha256.txt` — hashes used to verify the same input data across both stages.

The test uses single-threaded, fixed codec settings and reports median throughput from three runs. Compare compression speed, decompression speed, and ratio together; a higher throughput alone does not imply a better compression result.

**Status note:** this file documents the configured build plan and local test process. Package builds and Dell benchmark results must be confirmed from their actual workflow runs and local result files.
