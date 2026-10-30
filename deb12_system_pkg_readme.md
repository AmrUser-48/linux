# Debian 12 system packages — ICU 72 and Core 2 rebuild plan

**Status:** planned; no custom ICU package has been published yet.  
**Target machine:** Debian 12 Bookworm amd64, Intel Core 2 (Dell Latitude D630).  
**Observed snapshot:** 2026-10-30.

## Objective

Build a smaller, Core 2-optimized replacement for Debian Bookworm's `libicu72`, while keeping it usable by applications that already depend on Debian's ICU 72 ABI.

This is a replacement for Debian's existing package, not a parallel `libicu-lite` library. The output must retain:

- Binary package name: `libicu72`.
- ICU 72 shared-library SONAMEs and exported ABI (`libicu*.so.72`).
- Debian Bookworm's ICU source and Debian patch set as the starting point.
- Dependency metadata needed by the installed applications.
- Normal APT upgrade/replacement behaviour and a straightforward rollback to Debian's package.

A filtered ICU data set is **not automatically feature-complete**. It can preserve the library ABI and still break an application that requests locale, collation, transliteration, break-iterator, conversion, or time-zone data that was removed. Filtering must therefore be conservative and tested against the real installed consumers.

## Installed package facts

Captured on the D630:

```text
Package: libicu72
Version: 72.1-3+deb12u1
Source: icu
Installed-Size: 37.0 MB
Download-Size: 9,376 kB
APT-Manual-Installed: yes
Depends: libc6 (>= 2.34), libgcc-s1 (>= 3.0), libstdc++6 (>= 12)
Homepage: https://icu.unicode.org/
```

The package description is simply **International Components for Unicode**. It is a general-purpose Unicode and internationalisation runtime, not a browser or Bluetooth-only library.

The large `libicudata.so.72.1` file contains ICU's compiled data resources. It is separate from ICU's code libraries, but it is loaded as part of the ICU runtime. Reducing this file is the main size-reduction target; deleting it or substituting an unrelated Unicode library is not a compatible solution.

## Actual installed reverse dependencies

Captured with:

```sh
apt-cache rdepends --installed libicu72
dpkg-query -W -f='${binary:Package}\t${Depends}\n' | grep -E 'libicu72|libical3'
```

Unique installed direct reverse-dependency packages reported by APT:

| Binary package | Relevant component |
|---|---|
| `libboost-locale1.74.0` | Boost locale and character-conversion support |
| `libboost-regex1.74.0` | Boost regular-expression library |
| `libical3` | iCalendar library |
| `libqt5core5a` | Qt 5 Core |
| `libqt6core6` | Qt 6 Core |
| `libvte-2.91-0` | VTE terminal widget |
| `libxml2` | XML library |
| `mpd` | Music Player Daemon |
| `ncmpcpp` | MPD terminal client |
| `samba-libs` | Samba shared libraries |

APT printed some entries more than once because of multiple dependency relationships. The table contains the unique package names from that output.

The local `dpkg-query` output also shows that these packages have an ordinary runtime dependency on `libicu72 (>= 72.1~rc-1~)`. An ABI-compatible replacement with a package version satisfying that dependency can continue to satisfy APT without rebuilding every consumer.

### Debian source-package mapping for the Core 2 rebuild pass

The following source-package names map to the affected binary packages in Bookworm:

| Debian source package | Relevant binary output(s) |
|---|---|
| `icu` | `libicu72` and ICU's associated binary packages |
| `boost1.74` | `libboost-locale1.74.0`, `libboost-regex1.74.0` |
| `libical3` | `libical3` |
| `qtbase-opensource-src` | `libqt5core5a` |
| `qt6-base` | `libqt6core6` |
| `vte2.91` | `libvte-2.91-0` |
| `libxml2` | `libxml2` |
| `mpd` | `mpd` |
| `ncmpcpp` | `ncmpcpp` |
| `samba` | `samba-libs` |

Confirm the exact source names on the target system before dispatching builds:

```sh
dpkg-query -W -f='${binary:Package}\t${source:Package}\n' \
  libicu72 libboost-locale1.74.0 libboost-regex1.74.0 libical3 \
  libqt5core5a libqt6core6 libvte-2.91-0 libxml2 mpd ncmpcpp samba-libs
```

## Build strategy

### 1. Build ICU 72 first

Use the exact Bookworm source package:

- Source: `icu`
- Debian baseline: `72.1-3+deb12u1`
- Target architecture: `amd64`
- Target CPU: `-march=core2 -mtune=core2`
- Normal system-package profile: `-O2 -pipe -march=core2 -mtune=core2`

Keep Debian's packaging and security patches. Do not jump to another ICU major version for this replacement.

Produce and inspect the normal, unfiltered Core 2 build first. Then produce a separately identifiable filtered-data candidate from the same source and packaging baseline. Use ICU 72's supported data-packaging/filtering tooling; do not remove arbitrary files from `libicudata` after linking.

### 2. Data-filtering policy

Start conservatively. Preserve:

- Core Unicode properties and normalization.
- Required character-conversion data.
- Time-zone data used by ICU's calendar/date APIs.
- Root, English, and Ukrainian locale resources.
- Locale fallback and parent data needed by those locales.
- Collation and break-iterator resources until tests demonstrate that a narrower set is safe.
- Any ICU resources used by the installed Boost, Qt, VTE, libxml2, libical, MPD, ncmpcpp, and Samba builds.

Do not assume that English/Ukrainian-only locale selection is enough: applications can request locale identifiers dynamically, and their APIs may expect fallback data. Keep a full-data package as the rollback/reference build.

### 3. Package identity and installation

The filtered candidate must replace `libicu72`, not install beside it under a new unrelated package name.

- Keep package name `libicu72`.
- Keep ICU 72 SONAMEs and ABI.
- Use a clearly ordered local version suffix, for example `+core2.1~lite1` plus the repository build stamp. Confirm with `dpkg --compare-versions` that it is newer than the installed Debian version.
- Preserve `Depends`, `Breaks`, `Replaces`, architecture, and file ownership semantics unless a deliberate packaging change is justified.
- Include the package's checksum, source revision, compiler flags, data-filter description, and build logs in the release.
- Keep the exact stock Debian `.deb` available for rollback.

Do not overwrite the system library manually with `cp`, symlinks, or renamed shared objects. Install and test the candidate as a Debian package.

## Consumer rebuild plan

An unchanged consumer does **not** need rebuilding solely to use an ABI-compatible `libicu72` replacement. Its existing dynamic dependency is still `libicu*.so.72`, and APT still sees `libicu72` installed.

We nevertheless want Core 2 builds of all the installed reverse-dependency source packages as a separate optimization pass. Build ICU first, then build these sources against the repository's Core 2 environment:

1. `boost1.74`
2. `libical3`
3. `qtbase-opensource-src`
4. `qt6-base`
5. `vte2.91`
6. `libxml2`
7. `mpd`
8. `ncmpcpp`
9. `samba`

This rebuild pass is for Core 2 optimization and consistent package ownership, not a requirement of the ICU ABI replacement. If a filtered ICU candidate changes required runtime behaviour, rebuilding a consumer against the same filtered data will not magically restore missing ICU resources.

Use the repository's existing **Core 2 optimized Debian system package** workflow for each Debian source-package name. It accepts free-text source package names and applies the system profile. Use **Build with Deps** only where a recursive runtime dependency closure is desired; that workflow resolves forward dependencies, not the reverse-dependency list above.

Workflow links:

- [Core 2 optimized system package workflow](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-package.yml)
- [Build with Deps workflow](https://github.com/AmrUser-48/linux/actions/workflows/build-with-deps.yml)
- [Core 2 package index](https://github.com/AmrUser-48/linux/tree/master/core2-packages)

## Validation gates

Do not publish the Lite package as a replacement until all gates pass.

### Package and ABI checks

- `dpkg-deb -I` confirms package name, version, architecture, and dependencies.
- `dpkg-deb -c` confirms expected ICU libraries and data payload.
- SONAMEs remain `libicu*.so.72`.
- Compare exported dynamic symbols against the unfiltered Debian-compatible build.
- Confirm there are no missing shared-library dependencies with `ldd -r` on ICU libraries and test consumers.
- Confirm APT considers the custom package a valid replacement and does not propose removing its reverse dependencies.

### ICU data checks

- Verify the ICU data package opens and its data version matches ICU 72.1.
- Test Unicode normalization, case folding, character conversion, locale fallback, collation, date/time formatting, and time-zone lookup.
- Run tests under `en_US`, `uk_UA`, and `C`/root locale.
- Record which locale/data categories were removed and their measured size contribution.

### Installed consumer checks

Run the real applications/libraries on the D630 after installing the candidate:

- Qt 5 and Qt 6 Core smoke tests and at least one application using each.
- VTE terminal startup and a Unicode/locale rendering test.
- Boost.Locale and Boost.Regex smoke tests.
- libxml2 parse/serialization tests.
- libical date/time and timezone tests.
- MPD startup, database scan, metadata parsing, and playback.
- ncmpcpp connection and UI smoke test.
- Samba shared-library load and `smbclient` smoke test where installed.

Also run `dpkg -V libicu72`, `ldd -r` on the listed consumers, and a full application-startup check after installation.

## Measurements to publish

Compare stock Debian ICU, full-data Core 2 ICU, and filtered-data Core 2 ICU:

| Metric | Debian stock | Core 2 full data | Core 2 filtered data |
|---|---:|---:|---:|
| Installed size | measure | measure | measure |
| `libicudata.so.72.1` size | measure | measure | measure |
| Download size | measure | measure | measure |
| ICU smoke tests | pass/fail | pass/fail | pass/fail |
| Consumer tests | pass/fail | pass/fail | pass/fail |
| ABI / SONAME check | pass/fail | pass/fail | pass/fail |

Do not claim a size saving until the actual `.deb` and installed files have been measured.

## Local evidence captured on 2026-10-30

The original command output supplied for this plan is the source of the installed reverse-dependency inventory above:

```sh
apt show libicu72
apt-cache rdepends --installed libicu72
dpkg-query -W -f='${binary:Package}\t${Depends}\n' | grep -E 'libicu72|libical3'
```

The package was marked manually installed (`APT-Manual-Installed: yes`), so it should not be treated as an orphan that APT can autoremove. Its installed direct reverse dependencies are the packages listed above.
