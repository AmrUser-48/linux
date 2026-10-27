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




## One local benchmark script

Use the single script in this repository: [`compression-benchmark.sh`](compression-benchmark.sh).

From the local repository checkout, run:

```sh
bash core2-packages/compression-benchmark.sh
```

It benchmarks your installed tools and the downloaded O3 packages in one run, using the same saved text and binary test files. It extracts the .deb files into a temporary test directory; it does not install them. Compression and decompression use the same timing method, three-run medians, and an integrity check. Results are printed to the terminal; no separate baseline/candidate commands or generated comparison reports are required.

Required local paths:
- Test data: `~/Downloads/compression-bench-results/corpus/`
- Downloaded O3 packages: `~/Downloads/core2-o3-debs-20261027/`

The script is designed for the saved 16 MiB `text.bin` and `binary.bin` inputs. It does not install dependencies or alter system packages.
