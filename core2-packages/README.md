# Debian Bookworm packages optimized for Intel Core 2

This directory documents the opt-in GitHub Actions workflows for rebuilding Debian Bookworm source packages with native Core 2 compiler targets.

## Build any package by source name

The [Core 2 optimized Debian package workflow](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-package.yml) accepts a free-text Debian source-package name; it is no longer limited to a YAML dropdown list. Enter any valid source package available from the configured Debian Bookworm source repositories, such as `python3.11`, `thunar`, or another package name. The workflow resolves build dependencies, builds binary packages for amd64/all, and skips publication when that package already has a Core 2 release.

## Build a package with all runtime dependencies

Use [**Build with Deps → Run workflow**](https://github.com/AmrUser-48/linux/actions/workflows/build-with-deps.yml). Enter a binary package or Debian source-package name, such as `mc`. The action resolves the recursive `Depends` and `Pre-Depends` closure using Debian Bookworm's APT metadata, maps each required binary package to its source package, and builds all source packages that do not already have a Core 2 release. Enable **include Recommends** to include recommended packages, or **force rebuild** to rebuild packages even when a Core 2 release exists. Up to eight source-package builds run concurrently, and one failed build does not cancel the other builds.

This workflow covers runtime dependencies. Each package's Debian `Build-Depends` are installed by the normal package builder from Bookworm; they are not recursively rebuilt as part of the runtime dependency closure.

The [Core 2 optimized Debian system package workflow](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-package.yml) also accepts a free-text source-package name and uses the conservative `-O2 -march=core2 -mtune=core2` profile. The package-train workflows remain predefined sequential sets.

For an update, use the [Core 2 package updater](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-update-package.yml). Select `optimized` or `system`, then enter any source-package name. It forces a build against the latest available Debian Bookworm source version, waits for successful publication, removes older releases for that package only after the new release exists, and refreshes this index. If the build fails, existing releases are left untouched.

## Auto install 

Run the command shown under a package heading to install/update that package. To preview instead of installing, add `--dry-run` after the package key and `--kind` value. To list package keys, optionally limited to a release family:

```sh
curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - --list --kind optimized
curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - --list --kind system
```

Installer source: [`install.py`](install.py).

## Runtime dependency tree

This is a compact, searchable tree of runtime binary packages from each source package's latest release. It reads actual Pre-Depends and Depends fields from the published .deb files. Dependencies built in this repository link to their release pages; stock Debian Bookworm dependencies are grouped as leaves. Development, documentation, and debug packages stay in the download index but are excluded from this runtime view. Alternatives are explicitly marked as choices, and shared dependencies identify the first tree path where they are expanded.

<!-- CORE2-PACKAGE-DEPENDENCY-TREE:START -->


Each package below shows its direct Pre-Depends and Depends from the published .deb. Core 2 dependencies link to their own entry, so follow links to inspect the next level without duplicating entire subtrees. Stock Debian dependencies are labelled; development, documentation, and debug split packages are excluded from this runtime view.

**Verified SoX NG dependency path:** <code>sox-ng</code> → <code>libsox-ng5</code> → <code>libebur128-1</code>

<details>
<summary>Graphics (81 packages)</summary>

<details>
<summary id="core2-package-cairo-perf-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cairo-1.16.0-7-core2.1-20261016135244">cairo-perf-utils 1.16.0-7</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo-script-interpreter2"><code>libcairo-script-interpreter2 (= 1.16.0-7+core2.1~BUILD)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (= 1.16.0-7+core2.1~BUILD)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0 (&gt;= 0.10.0)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxcb-render0"><code>libxcb-render0</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>; <a href="#core2-package-libxrender1"><code>libxrender1</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libcairo-gobject2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cairo-1.16.0-7-core2.1-20261016135244">libcairo-gobject2 1.16.0-7 — Cairo 2D vector graphics library (GObject library)</a></code></summary>

- **Depends:** <a href="#core2-package-libcairo2"><code>libcairo2 (= 1.16.0-7+core2.1~BUILD)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.14.0)</code></a>

</details>

<details>
<summary id="core2-package-libcairo-script-interpreter2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cairo-1.16.0-7-core2.1-20261016135244">libcairo-script-interpreter2 1.16.0-7</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (= 1.16.0-7+core2.1~BUILD)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <code>liblzo2-2 (&gt;= 2.02)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libcairo2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cairo-1.16.0-7-core2.1-20261016135244">libcairo2 1.16.0-7</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.9.1)</code></a>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0 (&gt;= 0.30.0)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxcb-render0"><code>libxcb-render0</code></a>; <a href="#core2-package-libxcb-shm0"><code>libxcb-shm0</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.6)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxrender1"><code>libxrender1</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libdrm-amdgpu1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libdrm-2.4.114-1-core2.1-20261016115216">libdrm-amdgpu1 2.4.114-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.108)</code></a>

</details>

<details>
<summary id="core2-package-libdrm-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libdrm-2.4.114-1-core2.1-20261016115216">libdrm-common 2.4.114-1 — Userspace interface to kernel DRM services -- common files</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libdrm-intel1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libdrm-2.4.114-1-core2.1-20261016115216">libdrm-intel1 2.4.114-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.108)</code></a>; <a href="#core2-package-libpciaccess0"><code>libpciaccess0</code></a>

</details>

<details>
<summary id="core2-package-libdrm-nouveau2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libdrm-2.4.114-1-core2.1-20261016115216">libdrm-nouveau2 2.4.114-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.108)</code></a>

</details>

<details>
<summary id="core2-package-libdrm-radeon1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libdrm-2.4.114-1-core2.1-20261016115216">libdrm-radeon1 2.4.114-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.108)</code></a>

</details>

<details>
<summary id="core2-package-libdrm-tests"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libdrm-2.4.114-1-core2.1-20261016115216">libdrm-tests 2.4.114-1</a></code></summary>

- **Depends:** <a href="#core2-package-libdrm2"><code>libdrm2 (= 2.4.114-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdrm-amdgpu1"><code>libdrm-amdgpu1 (&gt;= 2.4.77)</code></a>

</details>

<details>
<summary id="core2-package-libdrm2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libdrm-2.4.114-1-core2.1-20261016115216">libdrm2 2.4.114-1</a></code></summary>

- **Depends:** <a href="#core2-package-libdrm-common"><code>libdrm-common (&gt;= 2.4.114-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>

</details>

<details>
<summary id="core2-package-libegl-mesa0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">libegl-mesa0 22.3.6-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.109)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.0.1)</code></a>; <a href="#core2-package-libgbm1"><code>libgbm1 (= 22.3.6-1+deb12u2+core2.1~BUILD)</code></a>; <code>libgcc-s1 (&gt;= 3.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglapi-mesa"><code>libglapi-mesa (= 22.3.6-1+deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libwayland-server0"><code>libwayland-server0 (&gt;= 1.15.0)</code></a>; <a href="#core2-package-libx11-xcb1"><code>libx11-xcb1 (&gt;= 2:1.8.4)</code></a>; <a href="#core2-package-libxcb-dri2-0"><code>libxcb-dri2-0 (&gt;= 1.8)</code></a>; <a href="#core2-package-libxcb-dri3-0"><code>libxcb-dri3-0 (&gt;= 1.13)</code></a>; <a href="#core2-package-libxcb-present0"><code>libxcb-present0</code></a>; <a href="#core2-package-libxcb-randr0"><code>libxcb-randr0 (&gt;= 1.3)</code></a>; <a href="#core2-package-libxcb-sync1"><code>libxcb-sync1</code></a>; <a href="#core2-package-libxcb-xfixes0"><code>libxcb-xfixes0</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.9.2)</code></a>; <code>libxshmfence1</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libegl1-mesa"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">libegl1-mesa 22.3.6-1+deb12u2</a></code></summary>

- **Depends:** <code>libegl1</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libgbm1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">libgbm1 22.3.6-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.75)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.0.1)</code></a>; <a href="#core2-package-libwayland-server0"><code>libwayland-server0 (&gt;= 1.15.0)</code></a>

</details>

<details>
<summary id="core2-package-libgl1-mesa-dri"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">libgl1-mesa-dri 22.3.6-1+deb12u2 — free implementation of the OpenGL API -- DRI modules</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdrm-intel1"><code>libdrm-intel1 (&gt;= 2.4.38)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.75)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.0.1)</code></a>; <code>libgcc-s1 (&gt;= 3.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglapi-mesa"><code>libglapi-mesa (= 22.3.6-1+deb12u2+core2.1~BUILD)</code></a>; <code>libsensors5 (&gt;= 1:3.5.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libgl1-mesa-glx"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">libgl1-mesa-glx 22.3.6-1+deb12u2</a></code></summary>

- **Depends:** <code>libgl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglx-mesa0"><code>libglx-mesa0</code></a>

</details>

<details>
<summary id="core2-package-libglapi-mesa"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">libglapi-mesa 22.3.6-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libgles2-mesa"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">libgles2-mesa 22.3.6-1+deb12u2</a></code></summary>

- **Depends:** <code>libgles2</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libglib2.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158">libglib2.0-0 2.74.6-2+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libffi8"><code>libffi8 (&gt;= 3.4)</code></a>; <code>libmount1 (&gt;= 2.35.2-7~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.22)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.2)</code></a>

</details>

<details>
<summary id="core2-package-libglib2.0-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158">libglib2.0-bin 2.74.6-2+deb12u9 — Programs for the GLib library</a></code></summary>

- **Depends:** <a href="#core2-package-libglib2.0-data"><code>libglib2.0-data</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libelf1 (&gt;= 0.142)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (= 2.74.6-2+deb12u9+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libglib2.0-data"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158">libglib2.0-data 2.74.6-2+deb12u9</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libglib2.0-dev-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158">libglib2.0-dev-bin 2.74.6-2+deb12u9</a></code></summary>

- **Depends:** <code>python3-distutils</code> <em>(Debian Bookworm)</em>; <code>python3:any</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (= 2.74.6-2+deb12u9+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libglib2.0-tests"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158">libglib2.0-tests 2.74.6-2+deb12u9</a></code></summary>

- **Depends:** <code>desktop-file-utils</code> <em>(Debian Bookworm)</em>; <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-dev-bin"><code>libglib2.0-dev-bin</code></a>; <code>python3-dbus</code> <em>(Debian Bookworm)</em>; <code>python3-dbusmock</code> <em>(Debian Bookworm)</em>; <code>python3-gi</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-shared-mime-info"><code>shared-mime-info</code></a>; <a href="#core2-package-python3.11"><code>python3.11</code></a>; <code>python3:any</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (= 2.74.6-2+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.22)</code></a>; <code>libstdc++6 (&gt;= 4.1.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libglx-mesa0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">libglx-mesa0 22.3.6-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.75)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.0.1)</code></a>; <a href="#core2-package-libglapi-mesa"><code>libglapi-mesa (= 22.3.6-1+deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.4.99.1)</code></a>; <a href="#core2-package-libx11-xcb1"><code>libx11-xcb1 (&gt;= 2:1.8.4)</code></a>; <a href="#core2-package-libxcb-dri2-0"><code>libxcb-dri2-0 (&gt;= 1.8)</code></a>; <a href="#core2-package-libxcb-dri3-0"><code>libxcb-dri3-0 (&gt;= 1.13)</code></a>; <a href="#core2-package-libxcb-glx0"><code>libxcb-glx0 (&gt;= 1.8)</code></a>; <a href="#core2-package-libxcb-present0"><code>libxcb-present0</code></a>; <a href="#core2-package-libxcb-randr0"><code>libxcb-randr0</code></a>; <a href="#core2-package-libxcb-shm0"><code>libxcb-shm0</code></a>; <a href="#core2-package-libxcb-sync1"><code>libxcb-sync1</code></a>; <a href="#core2-package-libxcb-xfixes0"><code>libxcb-xfixes0</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.9.2)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxfixes3"><code>libxfixes3</code></a>; <code>libxshmfence1</code> <em>(Debian Bookworm)</em>; <code>libxxf86vm1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgl1-mesa-dri"><code>libgl1-mesa-dri</code></a>

</details>

<details>
<summary id="core2-package-libosmesa6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">libosmesa6 22.3.6-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglapi-mesa"><code>libglapi-mesa (= 22.3.6-1+deb12u2+core2.1~BUILD)</code></a>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libpangocairo-1.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751">libpangocairo-1.0-0 1.50.12+ds-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.12.10)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.13.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62.0)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 2.6.0)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libpangoft2-1.0-0"><code>libpangoft2-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libpixman-1-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-pixman-0.42.2-1-core2.1-20261011154041">libpixman-1-0 0.42.2-1 — pixel-manipulation library for X and cairo</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>

</details>

<details>
<summary id="core2-package-libva-drm2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libva-2.17.0-1-core2.1-20261016135745">libva-drm2 2.17.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.60)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.17.0)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&lt;&lt; 2.17.0.1)</code></a>

</details>

<details>
<summary id="core2-package-libva-wayland2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libva-2.17.0-1-core2.1-20261016135745">libva-wayland2 2.17.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.60)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.17.0)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&lt;&lt; 2.17.0.1), libwayland-client0 (&gt;= 1.20.0)</code></a>

</details>

<details>
<summary id="core2-package-libwayland-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-wayland-1.21.0-1-core2.1-20261016133904">libwayland-bin 1.21.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.0.1)</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>

</details>

<details>
<summary id="core2-package-libwayland-client0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-wayland-1.21.0-1-core2.1-20261016133904">libwayland-client0 1.21.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.28)</code></a>; <a href="#core2-package-libffi8"><code>libffi8 (&gt;= 3.4)</code></a>

</details>

<details>
<summary id="core2-package-libwayland-cursor0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-wayland-1.21.0-1-core2.1-20261016133904">libwayland-cursor0 1.21.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.28)</code></a>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>

</details>

<details>
<summary id="core2-package-libwayland-egl1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-wayland-1.21.0-1-core2.1-20261016133904">libwayland-egl1 1.21.0-1 — wayland compositor infrastructure - EGL library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.2.5)</code></a>

</details>

<details>
<summary id="core2-package-libwayland-egl1-mesa"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">libwayland-egl1-mesa 22.3.6-1+deb12u2</a></code></summary>

- **Depends:** <code>libegl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libwayland-egl1"><code>libwayland-egl1</code></a>

</details>

<details>
<summary id="core2-package-libwayland-server0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-wayland-1.21.0-1-core2.1-20261016133904">libwayland-server0 1.21.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libffi8"><code>libffi8 (&gt;= 3.4)</code></a>

</details>

<details>
<summary id="core2-package-libx11-6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libx11-2-1.8.4-2-deb12u2-core2.1-20261016131846">libx11-6 2:1.8.4-2+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.11.1)</code></a>; <a href="#core2-package-libx11-data"><code>libx11-data</code></a>

</details>

<details>
<summary id="core2-package-libx11-data"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libx11-2-1.8.4-2-deb12u2-core2.1-20261016131846">libx11-data 2:1.8.4-2+deb12u2</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libx11-xcb1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libx11-2-1.8.4-2-deb12u2-core2.1-20261016131846">libx11-xcb1 2:1.8.4-2+deb12u2 — Xlib/XCB interface library</a></code></summary>

- **Depends:** <a href="#core2-package-libx11-6"><code>libx11-6 (= 2:1.8.4-2+deb12u2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libxcb-composite0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-composite0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-damage0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-damage0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-dpms0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-dpms0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-dri2-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-dri2-0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-dri3-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-dri3-0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.12)</code></a>

</details>

<details>
<summary id="core2-package-libxcb-glx0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-glx0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-present0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-present0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-randr0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-randr0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.9.2)</code></a>

</details>

<details>
<summary id="core2-package-libxcb-record0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-record0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-render0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-render0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.8)</code></a>

</details>

<details>
<summary id="core2-package-libxcb-res0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-res0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-screensaver0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-screensaver0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-shape0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-shape0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-shm0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-shm0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.12)</code></a>

</details>

<details>
<summary id="core2-package-libxcb-sync1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-sync1 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-xf86dri0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-xf86dri0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-xfixes0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-xfixes0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-xinerama0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-xinerama0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-xinput0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-xinput0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.8)</code></a>

</details>

<details>
<summary id="core2-package-libxcb-xkb1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-xkb1 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-xtest0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-xtest0 1.15-1 — X C Binding, xtest extension</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-xv0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-xv0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb-xvmc0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb-xvmc0 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libxcb1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016">libxcb1 1.15-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libxau6"><code>libxau6 (&gt;= 1:1.0.9)</code></a>; <a href="#core2-package-libxdmcp6"><code>libxdmcp6</code></a>

</details>

<details>
<summary id="core2-package-libxext6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxext-2-1.3.4-1-core2.1-20261016132313">libxext6 2:1.3.4-1 — X11 miscellaneous extension library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.6.0)</code></a>

</details>

<details>
<summary id="core2-package-libxi6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxi-2-1.8-1-core2.1-20261020161349">libxi6 2:1.8-1 — X11 Input extension library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.6.0)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>

</details>

<details>
<summary id="core2-package-libxinerama1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxinerama-2-1.1.4-3-core2.1-20261020161404">libxinerama1 2:1.1.4-3 — X11 Xinerama extension library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.6.0)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>

</details>

<details>
<summary id="core2-package-libxrandr2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxrandr-2-1.5.2-2-core2.1-20261016132856">libxrandr2 2:1.5.2-2 — X11 RandR extension library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.6.0)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxrender1"><code>libxrender1</code></a>

</details>

<details>
<summary id="core2-package-libxrender1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxrender-1-0.9.10-1.1-core2.1-20261020161528">libxrender1 1:0.9.10-1.1 — X Rendering Extension client library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.6.0)</code></a>

</details>

<details>
<summary id="core2-package-mesa-va-drivers"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">mesa-va-drivers 22.3.6-1+deb12u2</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-mesa-vdpau-drivers"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939">mesa-vdpau-drivers 22.3.6-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libvdpau1"><code>libvdpau1</code></a>

</details>

<details>
<summary id="core2-package-tigervnc-xorg-extension"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436">tigervnc-xorg-extension 1.12.0+dfsg-8</a></code></summary>

- **Depends:** <a href="#core2-package-xserver-xorg-core"><code>xserver-xorg-core (&gt;= 2:1.7.7)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.5)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0</code></a>; <code>libstdc++6 (&gt;= 5.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-xnest"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435">xnest 2:21.1.7-3+deb12u13</a></code></summary>

- **Depends:** <a href="#core2-package-xserver-common"><code>xserver-common (&gt;= 2:21.1.7-3+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libbsd0"><code>libbsd0 (&gt;= 0.7.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgcrypt20"><code>libgcrypt20 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0 (&gt;= 0.13.2)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>; <code>libunwind8</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxau6"><code>libxau6 (&gt;= 1:1.0.9)</code></a>; <a href="#core2-package-libxdmcp6"><code>libxdmcp6</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <code>libxfont2 (&gt;= 1:2.0.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-xorg-server-source"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435">xorg-server-source 2:21.1.7-3+deb12u13</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-xserver-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435">xserver-common 2:21.1.7-3+deb12u13</a></code></summary>

- **Depends:** <code>x11-common</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-xkb-data"><code>xkb-data</code></a>; <code>x11-xkb-utils</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-xserver-xephyr"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435">xserver-xephyr 2:21.1.7-3+deb12u13</a></code></summary>

- **Depends:** <a href="#core2-package-xserver-common"><code>xserver-common (&gt;= 2:21.1.7-3+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libbsd0"><code>libbsd0 (&gt;= 0.7.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libepoxy0"><code>libepoxy0 (&gt;= 1.0)</code></a>; <a href="#core2-package-libgcrypt20"><code>libgcrypt20 (&gt;= 1.10.0)</code></a>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0 (&gt;= 0.30.0)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>; <a href="#core2-package-libudev1"><code>libudev1 (&gt;= 183)</code></a>; <code>libunwind8</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libx11-xcb1"><code>libx11-xcb1 (&gt;= 2:1.8.4)</code></a>; <a href="#core2-package-libxau6"><code>libxau6 (&gt;= 1:1.0.9)</code></a>; <code>libxcb-icccm4 (&gt;= 0.4.1)</code> <em>(Debian Bookworm)</em>; <code>libxcb-image0 (&gt;= 0.2.1)</code> <em>(Debian Bookworm)</em>; <code>libxcb-keysyms1 (&gt;= 0.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxcb-randr0"><code>libxcb-randr0 (&gt;= 1.1)</code></a>; <code>libxcb-render-util0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxcb-render0"><code>libxcb-render0</code></a>; <a href="#core2-package-libxcb-shape0"><code>libxcb-shape0</code></a>; <a href="#core2-package-libxcb-shm0"><code>libxcb-shm0 (&gt;= 1.10)</code></a>; <code>libxcb-util1 (&gt;= 0.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxcb-xkb1"><code>libxcb-xkb1</code></a>; <a href="#core2-package-libxcb-xv0"><code>libxcb-xv0 (&gt;= 1.2)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.8)</code></a>; <a href="#core2-package-libxdmcp6"><code>libxdmcp6</code></a>; <code>libxfont2 (&gt;= 1:2.0.1)</code> <em>(Debian Bookworm)</em>; <code>libxshmfence1</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-xserver-xorg-core"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435">xserver-xorg-core 2:21.1.7-3+deb12u13 — Xorg X server - core server</a></code></summary>

- **Depends:** <a href="#core2-package-xserver-common"><code>xserver-common (&gt;= 2:21.1.7-3+deb12u13+core2.1~BUILD)</code></a>; <code>keyboard-configuration</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-udev"><code>udev (&gt;= 149)</code></a>; <code>libegl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libbsd0"><code>libbsd0 (&gt;= 0.7.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.66)</code></a>; <a href="#core2-package-libepoxy0"><code>libepoxy0 (&gt;= 1.5.4)</code></a>; <a href="#core2-package-libgbm1"><code>libgbm1 (&gt;= 17.1.0~rc2)</code></a>; <a href="#core2-package-libgcrypt20"><code>libgcrypt20 (&gt;= 1.10.0)</code></a>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpciaccess0"><code>libpciaccess0 (&gt;= 0.12.902)</code></a>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0 (&gt;= 0.30.0)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>; <a href="#core2-package-libudev1"><code>libudev1 (&gt;= 183)</code></a>; <code>libunwind8</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxau6"><code>libxau6 (&gt;= 1:1.0.9)</code></a>; <code>libxcvt0 (&gt;= 0.1.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxdmcp6"><code>libxdmcp6</code></a>; <code>libxfont2 (&gt;= 1:2.0.1)</code> <em>(Debian Bookworm)</em>; <code>libxshmfence1</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-xserver-xorg-input-kbd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xserver-xorg-input-keyboard-1-1.9.0-1-core2.1-20261016112635">xserver-xorg-input-kbd 1:1.9.0-1 — X.Org X server -- keyboard input driver</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.2.5)</code></a>; <code>xorg-input-abi-24</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-xserver-xorg-core"><code>xserver-xorg-core (&gt;= 2:21.1.1)</code></a>

</details>

<details>
<summary id="core2-package-xserver-xorg-input-libinput"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xserver-xorg-input-libinput-1.2.1-1-core2.1-20261016112819">xserver-xorg-input-libinput 1.2.1-1 — X.Org X server -- libinput input driver</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.7)</code></a>; <code>libinput10 (&gt;= 1.19.1)</code> <em>(Debian Bookworm)</em>; <code>xorg-input-abi-24</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-xserver-xorg-core"><code>xserver-xorg-core (&gt;= 2:21.1.1)</code></a>

</details>

<details>
<summary id="core2-package-xserver-xorg-input-synaptics"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xserver-xorg-input-synaptics-1.9.2-1-core2.1-20261016113016">xserver-xorg-input-synaptics 1.9.2-1 — Synaptics TouchPad driver for X.Org server</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libevdev2 (&gt;= 1.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxi6"><code>libxi6 (&gt;= 2:1.2.0)</code></a>; <code>libxtst6</code> <em>(Debian Bookworm)</em>; <code>xorg-input-abi-24</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-xserver-xorg-core"><code>xserver-xorg-core (&gt;= 2:21.1.1)</code></a>

</details>

<details>
<summary id="core2-package-xserver-xorg-legacy"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435">xserver-xorg-legacy 2:21.1.7-3+deb12u13</a></code></summary>

- **Depends:** <a href="#core2-package-xserver-common"><code>xserver-common (&gt;= 2:21.1.7-3+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-xserver-xorg-video-intel"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xserver-xorg-video-intel-2-2.99.917-git20210115-1-core2.1-20261016113213">xserver-xorg-video-intel 2:2.99.917+git20210115-1 — X.Org X server -- Intel i8xx, i9xx display driver</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdrm-intel1"><code>libdrm-intel1 (&gt;= 2.4.38)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.62)</code></a>; <a href="#core2-package-libpciaccess0"><code>libpciaccess0 (&gt;= 0.8.0+git20071002)</code></a>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0 (&gt;= 0.30.0)</code></a>; <a href="#core2-package-libudev1"><code>libudev1 (&gt;= 183)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libx11-xcb1"><code>libx11-xcb1 (&gt;= 2:1.8.4)</code></a>; <a href="#core2-package-libxcb-dri2-0"><code>libxcb-dri2-0</code></a>; <code>libxcb-util1 (&gt;= 0.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>; <a href="#core2-package-libxcursor1"><code>libxcursor1 (&gt;&gt; 1.1.2)</code></a>; <a href="#core2-package-libxdamage1"><code>libxdamage1 (&gt;= 1:1.1)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxfixes3"><code>libxfixes3</code></a>; <a href="#core2-package-libxinerama1"><code>libxinerama1 (&gt;= 2:1.1.4)</code></a>; <a href="#core2-package-libxrandr2"><code>libxrandr2 (&gt;= 2:1.2.99.2)</code></a>; <a href="#core2-package-libxrender1"><code>libxrender1</code></a>; <code>libxss1</code> <em>(Debian Bookworm)</em>; <code>libxtst6</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxvmc1"><code>libxvmc1 (&gt;= 2:1.0.12)</code></a>; <code>xorg-video-abi-25</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-xserver-xorg-core"><code>xserver-xorg-core (&gt;= 2:21.1.1)</code></a>

</details>

<details>
<summary id="core2-package-xvfb"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435">xvfb 2:21.1.7-3+deb12u13</a></code></summary>

- **Depends:** <a href="#core2-package-xserver-common"><code>xserver-common (&gt;= 2:21.1.7-3+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libbsd0"><code>libbsd0 (&gt;= 0.7.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libgcrypt20"><code>libgcrypt20 (&gt;= 1.10.0)</code></a>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0 (&gt;= 0.30.0)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>; <code>libunwind8</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxau6"><code>libxau6 (&gt;= 1:1.0.9)</code></a>; <a href="#core2-package-libxdmcp6"><code>libxdmcp6</code></a>; <code>libxfont2 (&gt;= 1:2.0.1)</code> <em>(Debian Bookworm)</em>

</details>

</details>

<details>
<summary>Audio &amp; video (66 packages)</summary>

<details>
<summary id="core2-package-ffmpeg"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">ffmpeg 7:5.1.9-0+deb12u1 — Tools for transcoding, streaming and playing of multimedia files</a></code></summary>

- **Depends:** <a href="#core2-package-libavcodec59"><code>libavcodec59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavdevice59"><code>libavdevice59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavfilter8"><code>libavfilter8 (&gt;= 7:5.1)</code></a>; <a href="#core2-package-libavformat59"><code>libavformat59 (&gt;= 7:5.1)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (&gt;= 7:5.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libpostproc56"><code>libpostproc56 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libsdl2-2.0-0"><code>libsdl2-2.0-0 (&gt;= 2.0.12)</code></a>; <a href="#core2-package-libswresample4"><code>libswresample4 (&gt;= 7:5.1)</code></a>; <a href="#core2-package-libswscale6"><code>libswscale6 (&gt;= 7:5.0)</code></a>

</details>

<details>
<summary id="core2-package-flac"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-flac-1.4.2-ds-2-core2.1-20261023192521">flac 1.4.2+ds-2 — Free Lossless Audio Codec - command line tools</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libflac12"><code>libflac12 (&gt;= 1.4.1)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-gst-plugins-bad-1.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835">gir1.2-gst-plugins-bad-1.0 1.22.0-4+deb12u8</a></code></summary>

- **Depends:** <code>gir1.2-freedesktop (&gt;= 0.9.12-4~)</code> <em>(Debian Bookworm)</em>; <code>gir1.2-glib-2.0 (&gt;= 0.9.12-4~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-gst-plugins-base-1.0"><code>gir1.2-gst-plugins-base-1.0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-gir1.2-gstreamer-1.0"><code>gir1.2-gstreamer-1.0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-bad1.0-0"><code>libgstreamer-plugins-bad1.0-0 (&gt;= 1.22.0)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-gst-plugins-base-1.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019">gir1.2-gst-plugins-base-1.0 1.22.0-3+deb12u7</a></code></summary>

- **Depends:** <code>gir1.2-glib-2.0 (&gt;= 0.9.12-4~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-gstreamer-1.0"><code>gir1.2-gstreamer-1.0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-gl1.0-0"><code>libgstreamer-gl1.0-0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-gstreamer-1.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gstreamer1.0-1.22.0-2-deb12u1-core2.1-20261011064624">gir1.2-gstreamer-1.0 1.22.0-2+deb12u1</a></code></summary>

- **Depends:** <code>gir1.2-glib-2.0 (&gt;= 0.9.12-4~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-alsa"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019">gstreamer1.0-alsa 1.22.0-3+deb12u7</a></code></summary>

- **Depends:** <code>libasound2 (&gt;= 1.0.27)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.3)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-gl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019">gstreamer1.0-gl 1.22.0-3+deb12u7</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.27)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62)</code></a>; <code>libgraphene-1.0-0 (&gt;= 1.5.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgstreamer-gl1.0-0"><code>libgstreamer-gl1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-gtk3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-good1.0-1.22.0-5-deb12u4-core2.1-20261016120601">gstreamer1.0-gtk3 1.22.0-5+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62)</code></a>; <a href="#core2-package-libgstreamer-gl1.0-0"><code>libgstreamer-gl1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.16.2)</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-libav"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-libav1.0-1.22.0-2-core2.1-20261016151258">gstreamer1.0-libav 1.22.0-2 — ffmpeg plugin for GStreamer</a></code></summary>

- **Depends:** <a href="#core2-package-libavcodec59"><code>libavcodec59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavfilter8"><code>libavfilter8 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavformat59"><code>libavformat59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.37.3)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-opencv"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835">gstreamer1.0-opencv 1.22.0-4+deb12u8</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.32)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.68)</code></a>; <a href="#core2-package-libgstreamer-opencv1.0-0"><code>libgstreamer-opencv1.0-0 (= 1.22.0-4+deb12u8+core2.1~BUILD)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <code>libopencv-calib3d406 (&gt;= 4.6.0+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libopencv-contrib406 (&gt;= 4.6.0+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libopencv-core406 (&gt;= 4.6.0+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libopencv-features2d406 (&gt;= 4.6.0+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libopencv-imgcodecs406 (&gt;= 4.6.0+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libopencv-imgproc406 (&gt;= 4.6.0+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libopencv-objdetect406 (&gt;= 4.6.0+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libopencv-video406 (&gt;= 4.6.0+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gstreamer1.0-plugins-base"><code>gstreamer1.0-plugins-base</code></a>; <a href="#core2-package-libgstreamer-plugins-bad1.0-0"><code>libgstreamer-plugins-bad1.0-0 (= 1.22.0-4+deb12u8+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-plugins-bad"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835">gstreamer1.0-plugins-bad 1.22.0-4+deb12u8</a></code></summary>

- **Depends:** <a href="#core2-package-libaom3"><code>libaom3 (&gt;= 3.2.0)</code></a>; <a href="#core2-package-libass9"><code>libass9 (&gt;= 1:0.13.6)</code></a>; <code>libbs2b0 (&gt;= 3.1.0+dfsg)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.6.0)</code></a>; <code>libchromaprint1 (&gt;= 1.3.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libcurl3-gnutls"><code>libcurl3-gnutls (&gt;= 7.55.0)</code></a>; <code>libdc1394-25 (&gt;= 2.2.6)</code> <em>(Debian Bookworm)</em>; <code>libdca0 (&gt;= 0.0.5)</code> <em>(Debian Bookworm)</em>; <code>libde265-0 (&gt;= 0.9)</code> <em>(Debian Bookworm)</em>; <code>libdirectfb-1.7-7 (&gt;= 1.7.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.62)</code></a>; <code>libdvdnav4 (&gt;= 4.1.3)</code> <em>(Debian Bookworm)</em>; <code>libdvdread8 (&gt;= 4.1.3)</code> <em>(Debian Bookworm)</em>; <code>libfaad2 (&gt;= 2.7)</code> <em>(Debian Bookworm)</em>; <code>libflite1 (&gt;= 1.4-release-9~)</code> <em>(Debian Bookworm)</em>; <code>libfluidsynth3 (&gt;= 2.2.0)</code> <em>(Debian Bookworm)</em>; <code>libfreeaptx0 (&gt;= 0.1.1)</code> <em>(Debian Bookworm)</em>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.68)</code></a>; <code>libgme0 (&gt;= 0.6.0)</code> <em>(Debian Bookworm)</em>; <code>libgsm1 (&gt;= 1.0.18)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgstreamer-gl1.0-0"><code>libgstreamer-gl1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-bad1.0-0"><code>libgstreamer-plugins-bad1.0-0 (= 1.22.0-4+deb12u8+core2.1~BUILD)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.15.0)</code></a>; <code>libgudev-1.0-0 (&gt;= 165)</code> <em>(Debian Bookworm)</em>; <code>libimath-3-1-29 (&gt;= 3.1.6)</code> <em>(Debian Bookworm)</em>; <code>libjson-glib-1.0-0 (&gt;= 1.5.2)</code> <em>(Debian Bookworm)</em>; <code>libkate1 (&gt;= 0.4.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.7)</code></a>; <code>libldacbt-enc2 (&gt;= 2.0.2)</code> <em>(Debian Bookworm)</em>; <code>liblilv-0-0 (&gt;= 0.22)</code> <em>(Debian Bookworm)</em>; <code>liblrdf0 (&gt;= 0.4.0-1.2)</code> <em>(Debian Bookworm)</em>; <code>libltc11 (&gt;= 1.2.0)</code> <em>(Debian Bookworm)</em>; <code>libmfx1 (&gt;= 18.4.0)</code> <em>(Debian Bookworm)</em>; <code>libmjpegutils-2.1-0 (&gt;= 1:2.1.0+debian)</code> <em>(Debian Bookworm)</em>; <code>libmodplug1 (&gt;= 1:0.8.8.5)</code> <em>(Debian Bookworm)</em>; <code>libmpcdec6 (&gt;= 1:0.1~r435)</code> <em>(Debian Bookworm)</em>; <code>libmpeg2encpp-2.1-0 (&gt;= 1:2.1.0+debian)</code> <em>(Debian Bookworm)</em>; <code>libmplex2-2.1-0 (&gt;= 1:2.1.0+debian)</code> <em>(Debian Bookworm)</em>; <code>libneon27</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libnettle8"><code>libnettle8 (&gt;= 3)</code></a>; <code>libopenal1 (&gt;= 1.14)</code> <em>(Debian Bookworm)</em>; <code>libopenexr-3-1-30 (&gt;= 3.1.5)</code> <em>(Debian Bookworm)</em>; <code>libopenh264-7 (&gt;= 2.3.1+dfsg)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libopenjp2-7"><code>libopenjp2-7 (&gt;= 2.2.0)</code></a>; <a href="#core2-package-libopenmpt0"><code>libopenmpt0 (&gt;= 0.5.10)</code></a>; <code>libopenni2-0 (&gt;= 2.2.0.33+dfsg)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libopus0"><code>libopus0 (&gt;= 1.1)</code></a>; <a href="#core2-package-liborc-0.4-0"><code>liborc-0.4-0 (&gt;= 1:0.4.25)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (&gt;= 1.22)</code></a>; <code>libqrencode4 (&gt;= 3.2.0)</code> <em>(Debian Bookworm)</em>; <code>librsvg2-2 (&gt;= 2.36.2)</code> <em>(Debian Bookworm)</em>; <code>librtmp1 (&gt;= 2.3)</code> <em>(Debian Bookworm)</em>; <code>libsbc1 (&gt;= 2.0)</code> <em>(Debian Bookworm)</em>; <code>libsndfile1 (&gt;= 1.0.20)</code> <em>(Debian Bookworm)</em>; <code>libsoundtouch1 (&gt;= 2.0.0)</code> <em>(Debian Bookworm)</em>; <code>libspandsp2 (&gt;= 0.0.6~pre18)</code> <em>(Debian Bookworm)</em>; <code>libsrt1.5-gnutls (&gt;= 1.5.1)</code> <em>(Debian Bookworm)</em>; <code>libsrtp2-1 (&gt;= 2.0.0+20170516)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <code>libstdc++6 (&gt;= 5.2)</code> <em>(Debian Bookworm)</em>; <code>libusb-1.0-0 (&gt;= 2:1.0.8)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.2.0)</code></a>; <code>libvo-aacenc0 (&gt;= 0.1.3)</code> <em>(Debian Bookworm)</em>; <code>libvo-amrwbenc0 (&gt;= 0.1.3)</code> <em>(Debian Bookworm)</em>; <code>libvulkan1 (&gt;= 1.2.131.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libwebp7"><code>libwebp7 (&gt;= 1.2.4)</code></a>; <code>libwebrtc-audio-processing1</code> <em>(Debian Bookworm)</em>; <code>libwildmidi2 (&gt;= 0.2.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libx265-199"><code>libx265-199 (&gt;= 3.5)</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.9.0)</code></a>; <code>libzbar0 (&gt;= 0.10)</code> <em>(Debian Bookworm)</em>; <code>libzvbi0 (&gt;= 0.2.35)</code> <em>(Debian Bookworm)</em>; <code>libzxing2 (&gt;= 1.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gstreamer1.0-plugins-base"><code>gstreamer1.0-plugins-base (&gt;= 1.22.0)</code></a>; <a href="#core2-package-gstreamer1.0-plugins-good"><code>gstreamer1.0-plugins-good (&gt;= 1.22.0)</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-plugins-bad-apps"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835">gstreamer1.0-plugins-bad-apps 1.22.0-4+deb12u8</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.68)</code></a>; <a href="#core2-package-libgstreamer-plugins-bad1.0-0"><code>libgstreamer-plugins-bad1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-gstreamer1.0-plugins-bad"><code>gstreamer1.0-plugins-bad (= 1.22.0-4+deb12u8+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-plugins-base"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019">gstreamer1.0-plugins-base 1.22.0-3+deb12u7</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <code>libcdparanoia0 (&gt;= 3.10.2+debian)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.3)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libogg0"><code>libogg0 (&gt;= 1.0rc3)</code></a>; <a href="#core2-package-libopus0"><code>libopus0 (&gt;= 1.1)</code></a>; <a href="#core2-package-liborc-0.4-0"><code>liborc-0.4-0 (&gt;= 1:0.4.25)</code></a>; <a href="#core2-package-libtheora0"><code>libtheora0 (&gt;= 1.1)</code></a>; <code>libvisual-0.4-0 (&gt;= 0.4.0)</code> <em>(Debian Bookworm)</em>; <code>libvorbis0a (&gt;= 1.3.1)</code> <em>(Debian Bookworm)</em>; <code>libvorbisenc2 (&gt;= 1.3.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-gstreamer1.0-plugins-base-apps"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019">gstreamer1.0-plugins-base-apps 1.22.0-3+deb12u7 — GStreamer helper programs from the "base" set</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-gstreamer1.0-tools"><code>gstreamer1.0-tools</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-plugins-good"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-good1.0-1.22.0-5-deb12u4-core2.1-20261016120601">gstreamer1.0-plugins-good 1.22.0-5+deb12u4</a></code></summary>

- **Depends:** <code>libaa1 (&gt;= 1.4p5)</code> <em>(Debian Bookworm)</em>; <code>libavc1394-0 (&gt;= 0.5.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libcaca0 (&gt;= 0.99.beta20)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libcairo-gobject2"><code>libcairo-gobject2 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.10.0)</code></a>; <code>libdv4 (&gt;= 1.0.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libflac12"><code>libflac12 (&gt;= 1.3.0)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.3)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <code>libgudev-1.0-0 (&gt;= 147)</code> <em>(Debian Bookworm)</em>; <code>libiec61883-0 (&gt;= 1.2.0)</code> <em>(Debian Bookworm)</em>; one of: <code>libjack-jackd2-0 (&gt;= 1.9.10+20150825)</code> <em>(Debian Bookworm)</em> | <code>libjack-0.125</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-libmp3lame0"><code>libmp3lame0 (&gt;= 3.100)</code></a>; <code>libmpg123-0 (&gt;= 1.28.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liborc-0.4-0"><code>liborc-0.4-0 (&gt;= 1:0.4.25)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <code>libpulse0 (&gt;= 2.0)</code> <em>(Debian Bookworm)</em>; <code>libraw1394-11 (&gt;= 2.1.2)</code> <em>(Debian Bookworm)</em>; <code>libshout3 (&gt;= 2.4.6)</code> <em>(Debian Bookworm)</em>; <code>libspeex1 (&gt;= 1.2~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <code>libtag1v5 (&gt;= 1.9.1-2.2~)</code> <em>(Debian Bookworm)</em>; <code>libtwolame0 (&gt;= 0.3.10)</code> <em>(Debian Bookworm)</em>; <code>libv4l-0 (&gt;= 0.5.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvpx7"><code>libvpx7 (&gt;= 1.12.0)</code></a>; <code>libwavpack1 (&gt;= 4.60)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxdamage1"><code>libxdamage1 (&gt;= 1:1.1)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxfixes3"><code>libxfixes3</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.9.0)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <a href="#core2-package-gstreamer1.0-plugins-base"><code>gstreamer1.0-plugins-base (&gt;= 1.22.0)</code></a>; one of: <code>libsoup2.4-1 (&gt;= 2.48)</code> <em>(Debian Bookworm)</em> | <code>libsoup-3.0-0</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-gstreamer1.0-pulseaudio"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-good1.0-1.22.0-5-deb12u4-core2.1-20261016120601">gstreamer1.0-pulseaudio 1.22.0-5+deb12u4 — GStreamer plugin for PulseAudio (transitional package)</a></code></summary>

- **Depends:** <a href="#core2-package-gstreamer1.0-plugins-good"><code>gstreamer1.0-plugins-good (&gt;= 1.22.0)</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-qt5"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-good1.0-1.22.0-5-deb12u4-core2.1-20261016120601">gstreamer1.0-qt5 1.22.0-5+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62)</code></a>; <a href="#core2-package-libgstreamer-gl1.0-0"><code>libgstreamer-gl1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <code>libqt5core5a (&gt;= 5.15.1)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.4.0)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.4.0)</code> <em>(Debian Bookworm)</em>; <code>libqt5qml5 (&gt;= 5.0.2)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5quick5 (&gt;= 5.15.1)</code> <em>(Debian Bookworm)</em> | <code>libqt5quick5-gles (&gt;= 5.15.1)</code> <em>(Debian Bookworm)</em>; <code>libqt5waylandclient5 (&gt;= 5.10.1)</code> <em>(Debian Bookworm)</em>; <code>libqt5x11extras5 (&gt;= 5.6.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 4.5)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-gstreamer1.0-qt6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-good1.0-1.22.0-5-deb12u4-core2.1-20261016120601">gstreamer1.0-qt6 1.22.0-5+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libgles2</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62)</code></a>; <a href="#core2-package-libgstreamer-gl1.0-0"><code>libgstreamer-gl1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <code>libqt6core6 (&gt;= 6.4.0)</code> <em>(Debian Bookworm)</em>; <code>libqt6gui6 (&gt;= 6.2.0)</code> <em>(Debian Bookworm)</em>; <code>libqt6qml6 (&gt;= 6.2.0)</code> <em>(Debian Bookworm)</em>; <code>libqt6quick6 (&gt;= 6.2.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-gstreamer1.0-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gstreamer1.0-1.22.0-2-deb12u1-core2.1-20261011064624">gstreamer1.0-tools 1.22.0-2+deb12u1 — Tools for use with GStreamer</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.20.0)</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-vaapi"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gstreamer-vaapi-1.22.0-2-core2.1-20261016151532">gstreamer1.0-vaapi 1.22.0-2 — VA-API plugins for GStreamer</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libegl1</code> <em>(Debian Bookworm)</em>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <code>libgles2 (&gt;= 1.0.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.3)</code></a>; <a href="#core2-package-libgstreamer-gl1.0-0"><code>libgstreamer-gl1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-bad1.0-0"><code>libgstreamer-plugins-bad1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libudev1"><code>libudev1 (&gt;= 183)</code></a>; <a href="#core2-package-libva-drm2"><code>libva-drm2 (&gt;= 1.1.0)</code></a>; <a href="#core2-package-libva-wayland2"><code>libva-wayland2 (&gt;= 1.3.0)</code></a>; <a href="#core2-package-libva-x11-2"><code>libva-x11-2 (&gt;= 1.0.3)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.2.0)</code></a>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxrandr2"><code>libxrandr2</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-wpe"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835">gstreamer1.0-wpe 1.22.0-4+deb12u8</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.68)</code></a>; <a href="#core2-package-libgstreamer-gl1.0-0"><code>libgstreamer-gl1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libwayland-server0"><code>libwayland-server0 (&gt;= 1.11.0)</code></a>; <code>libwpe-1.0-1 (&gt;= 1.3.0)</code> <em>(Debian Bookworm)</em>; <code>libwpebackend-fdo-1.0-1 (&gt;= 1.8.0)</code> <em>(Debian Bookworm)</em>; <code>libwpewebkit-1.1-0 (&gt;= 2.28.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxkbcommon0"><code>libxkbcommon0 (&gt;= 1.0.0)</code></a>; <a href="#core2-package-gstreamer1.0-plugins-base"><code>gstreamer1.0-plugins-base</code></a>; <a href="#core2-package-libgstreamer-plugins-bad1.0-0"><code>libgstreamer-plugins-bad1.0-0 (= 1.22.0-4+deb12u8+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-gstreamer1.0-x"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019">gstreamer1.0-x 1.22.0-3+deb12u7</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (&gt;= 1.22)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.2.99.901)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxi6"><code>libxi6 (&gt;= 2:1.2.99.4)</code></a>; <a href="#core2-package-libxv1"><code>libxv1</code></a>

</details>

<details>
<summary id="core2-package-lame"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libmp3lame0-3.100-6-core2.1-20261016213051">lame 3.100-6</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libmp3lame0"><code>libmp3lame0 (&gt;= 3.100)</code></a>; <code>libsndfile1 (&gt;= 1.0.20)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>

</details>

<details>
<summary id="core2-package-libavahi-client3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">libavahi-client3 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>

</details>

<details>
<summary id="core2-package-libavahi-common-data"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">libavahi-common-data 0.8-10+deb12u1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libavahi-common3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">libavahi-common3 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libavahi-common-data"><code>libavahi-common-data (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libavahi-compat-libdnssd1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">libavahi-compat-libdnssd1 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavahi-client3"><code>libavahi-client3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libavahi-core7"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">libavahi-core7 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.15)</code></a>

</details>

<details>
<summary id="core2-package-libavahi-glib1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">libavahi-glib1 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.2.5)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.16.0)</code></a>

</details>

<details>
<summary id="core2-package-libavahi-gobject0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">libavahi-gobject0 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavahi-client3"><code>libavahi-client3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavahi-glib1"><code>libavahi-glib1 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.37.3)</code></a>

</details>

<details>
<summary id="core2-package-libavahi-ui-gtk3-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">libavahi-ui-gtk3-0 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavahi-client3"><code>libavahi-client3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavahi-glib1"><code>libavahi-glib1 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libgdbm6"><code>libgdbm6 (&gt;= 1.16)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.37.3)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.0.0)</code></a>

</details>

<details>
<summary id="core2-package-libavcodec-extra"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libavcodec-extra 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavcodec-extra59"><code>libavcodec-extra59 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libavcodec-extra59"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libavcodec-extra59 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libaom3"><code>libaom3 (&gt;= 3.2.0)</code></a>; <code>libaribb24-0 (&gt;= 1.0.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libavutil57"><code>libavutil57 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.2.4)</code></a>; <code>libcodec2-1.0 (&gt;= 1.0.5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdav1d6"><code>libdav1d6 (&gt;= 0.9.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.12.0)</code></a>; <code>libgsm1 (&gt;= 1.0.18)</code> <em>(Debian Bookworm)</em>; <code>libjxl0.7 (&gt;= 0.7.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <code>libmfx1 (&gt;= 18.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libmp3lame0"><code>libmp3lame0 (&gt;= 3.100)</code></a>; <code>libopencore-amrnb0 (&gt;= 0.1.6)</code> <em>(Debian Bookworm)</em>; <code>libopencore-amrwb0 (&gt;= 0.1.6)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libopenjp2-7"><code>libopenjp2-7 (&gt;= 2.0.0)</code></a>; <a href="#core2-package-libopus0"><code>libopus0 (&gt;= 1.1)</code></a>; <code>librav1e0 (&gt;= 0.5.1)</code> <em>(Debian Bookworm)</em>; <code>librsvg2-2 (&gt;= 2.14.4)</code> <em>(Debian Bookworm)</em>; <code>libshine3 (&gt;= 3.1.0)</code> <em>(Debian Bookworm)</em>; <code>libsnappy1v5 (&gt;= 1.1.9)</code> <em>(Debian Bookworm)</em>; <code>libspeex1 (&gt;= 1.2~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsvtav1enc1"><code>libsvtav1enc1 (&gt;= 1.4.1+dfsg)</code></a>; <a href="#core2-package-libswresample4"><code>libswresample4 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libtheora0"><code>libtheora0 (&gt;= 1.0)</code></a>; <code>libtwolame0 (&gt;= 0.3.10)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.9.0)</code></a>; <code>libvo-amrwbenc0 (&gt;= 0.1.3)</code> <em>(Debian Bookworm)</em>; <code>libvorbis0a (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <code>libvorbisenc2 (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvpx7"><code>libvpx7 (&gt;= 1.12.0)</code></a>; <a href="#core2-package-libwebp7"><code>libwebp7 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libwebpmux3"><code>libwebpmux3 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libx264-164"><code>libx264-164 (&gt;= 2:0.164.3095+gitbaee400)</code></a>; <a href="#core2-package-libx265-199"><code>libx265-199 (&gt;= 3.5)</code></a>; <a href="#core2-package-libxvidcore4"><code>libxvidcore4 (&gt;= 1.2.2)</code></a>; <code>libzvbi0 (&gt;= 0.2.35)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-libavcodec59"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libavcodec59 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libaom3"><code>libaom3 (&gt;= 3.2.0)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.2.4)</code></a>; <code>libcodec2-1.0 (&gt;= 1.0.5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdav1d6"><code>libdav1d6 (&gt;= 0.9.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.12.0)</code></a>; <code>libgsm1 (&gt;= 1.0.18)</code> <em>(Debian Bookworm)</em>; <code>libjxl0.7 (&gt;= 0.7.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <code>libmfx1 (&gt;= 18.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libmp3lame0"><code>libmp3lame0 (&gt;= 3.100)</code></a>; <a href="#core2-package-libopenjp2-7"><code>libopenjp2-7 (&gt;= 2.0.0)</code></a>; <a href="#core2-package-libopus0"><code>libopus0 (&gt;= 1.1)</code></a>; <code>librav1e0 (&gt;= 0.5.1)</code> <em>(Debian Bookworm)</em>; <code>librsvg2-2 (&gt;= 2.14.4)</code> <em>(Debian Bookworm)</em>; <code>libshine3 (&gt;= 3.1.0)</code> <em>(Debian Bookworm)</em>; <code>libsnappy1v5 (&gt;= 1.1.9)</code> <em>(Debian Bookworm)</em>; <code>libspeex1 (&gt;= 1.2~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsvtav1enc1"><code>libsvtav1enc1 (&gt;= 1.4.1+dfsg)</code></a>; <a href="#core2-package-libswresample4"><code>libswresample4 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libtheora0"><code>libtheora0 (&gt;= 1.0)</code></a>; <code>libtwolame0 (&gt;= 0.3.10)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.9.0)</code></a>; <code>libvorbis0a (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <code>libvorbisenc2 (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvpx7"><code>libvpx7 (&gt;= 1.12.0)</code></a>; <a href="#core2-package-libwebp7"><code>libwebp7 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libwebpmux3"><code>libwebpmux3 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libx264-164"><code>libx264-164 (&gt;= 2:0.164.3095+gitbaee400)</code></a>; <a href="#core2-package-libx265-199"><code>libx265-199 (&gt;= 3.5)</code></a>; <a href="#core2-package-libxvidcore4"><code>libxvidcore4 (&gt;= 1.2.2)</code></a>; <code>libzvbi0 (&gt;= 0.2.35)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-libavdevice59"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libavdevice59 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <code>libasound2 (&gt;= 1.0.16)</code> <em>(Debian Bookworm)</em>; <code>libavc1394-0 (&gt;= 0.5.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libavcodec59"><code>libavcodec59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavfilter8"><code>libavfilter8 (&gt;= 7:5.1)</code></a>; <a href="#core2-package-libavformat59"><code>libavformat59 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libcaca0 (&gt;= 0.99.beta20)</code> <em>(Debian Bookworm)</em>; <code>libcdio-cdda2 (&gt;= 10.2+2.0.0)</code> <em>(Debian Bookworm)</em>; <code>libcdio-paranoia2 (&gt;= 10.2+2.0.0)</code> <em>(Debian Bookworm)</em>; <code>libdc1394-25 (&gt;= 2.2.6)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.101)</code></a>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <code>libiec61883-0 (&gt;= 1.2.0)</code> <em>(Debian Bookworm)</em>; one of: <code>libjack-jackd2-0 (&gt;= 1.9.10+20150825)</code> <em>(Debian Bookworm)</em> | <code>libjack-0.125</code> <em>(Debian Bookworm)</em>; <code>libopenal1 (&gt;= 1.14)</code> <em>(Debian Bookworm)</em>; <code>libpulse0 (&gt;= 0.99.1)</code> <em>(Debian Bookworm)</em>; <code>libraw1394-11 (&gt;= 2.1.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsdl2-2.0-0"><code>libsdl2-2.0-0 (&gt;= 2.0.12)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxcb-shape0"><code>libxcb-shape0</code></a>; <a href="#core2-package-libxcb-shm0"><code>libxcb-shm0</code></a>; <a href="#core2-package-libxcb-xfixes0"><code>libxcb-xfixes0</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxv1"><code>libxv1</code></a>

</details>

<details>
<summary id="core2-package-libavfilter-extra"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libavfilter-extra 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavfilter-extra8"><code>libavfilter-extra8 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libavfilter-extra8"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libavfilter-extra8 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libass9"><code>libass9 (&gt;= 1:0.13.6)</code></a>; <a href="#core2-package-libavcodec59"><code>libavcodec59 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavformat59"><code>libavformat59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <code>libbs2b0 (&gt;= 3.1.0+dfsg)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <code>libflite1 (&gt;= 1.4-release-9~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-libfribidi0"><code>libfribidi0 (&gt;= 0.19.2)</code></a>; <code>liblilv-0-0 (&gt;= 0.14.2~dfsg0)</code> <em>(Debian Bookworm)</em>; <code>libmfx1 (&gt;= 18.4.0)</code> <em>(Debian Bookworm)</em>; <code>libmysofa1 (&gt;= 0.7~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libplacebo208"><code>libplacebo208 (&gt;= 4.208.0)</code></a>; <code>libpocketsphinx3 (&gt;= 0.8+5prealpha+1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpostproc56"><code>libpostproc56 (&gt;= 7:5.0)</code></a>; <code>librubberband2 (&gt;= 3.1.2+dfsg0)</code> <em>(Debian Bookworm)</em>; <code>libsphinxbase3 (&gt;= 0.8+5prealpha)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libswresample4"><code>libswresample4 (&gt;= 7:5.1)</code></a>; <a href="#core2-package-libswscale6"><code>libswscale6 (&gt;= 7:5.0)</code></a>; <code>libtesseract5 (&gt;= 5.3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 1.7.3)</code></a>; <code>libvidstab1.1</code> <em>(Debian Bookworm)</em>; <code>libzimg2 (&gt;= 0.3.1)</code> <em>(Debian Bookworm)</em>; <code>libzmq5 (&gt;= 3.2.3+dfsg)</code> <em>(Debian Bookworm)</em>; one of: <code>ocl-icd-libopencl1</code> <em>(Debian Bookworm)</em> | <code>libopencl1</code> <em>(Debian Bookworm)</em>; one of: <code>ocl-icd-libopencl1 (&gt;= 1.0)</code> <em>(Debian Bookworm)</em> | <code>libopencl-1.2-1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libavfilter8"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libavfilter8 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libass9"><code>libass9 (&gt;= 1:0.13.6)</code></a>; <a href="#core2-package-libavcodec59"><code>libavcodec59 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavformat59"><code>libavformat59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <code>libbs2b0 (&gt;= 3.1.0+dfsg)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <code>libflite1 (&gt;= 1.4-release-9~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-libfribidi0"><code>libfribidi0 (&gt;= 0.19.2)</code></a>; <code>liblilv-0-0 (&gt;= 0.14.2~dfsg0)</code> <em>(Debian Bookworm)</em>; <code>libmfx1 (&gt;= 18.4.0)</code> <em>(Debian Bookworm)</em>; <code>libmysofa1 (&gt;= 0.7~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libplacebo208"><code>libplacebo208 (&gt;= 4.208.0)</code></a>; <code>libpocketsphinx3 (&gt;= 0.8+5prealpha+1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpostproc56"><code>libpostproc56 (&gt;= 7:5.0)</code></a>; <code>librubberband2 (&gt;= 3.1.2+dfsg0)</code> <em>(Debian Bookworm)</em>; <code>libsphinxbase3 (&gt;= 0.8+5prealpha)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libswresample4"><code>libswresample4 (&gt;= 7:5.1)</code></a>; <a href="#core2-package-libswscale6"><code>libswscale6 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 1.7.3)</code></a>; <code>libvidstab1.1</code> <em>(Debian Bookworm)</em>; <code>libzimg2 (&gt;= 0.3.1)</code> <em>(Debian Bookworm)</em>; <code>libzmq5 (&gt;= 3.2.3+dfsg)</code> <em>(Debian Bookworm)</em>; one of: <code>ocl-icd-libopencl1</code> <em>(Debian Bookworm)</em> | <code>libopencl1</code> <em>(Debian Bookworm)</em>; one of: <code>ocl-icd-libopencl1 (&gt;= 1.0)</code> <em>(Debian Bookworm)</em> | <code>libopencl-1.2-1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libavformat-extra"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libavformat-extra 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavformat-extra59"><code>libavformat-extra59 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libavformat-extra59"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libavformat-extra59 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavcodec59"><code>libavcodec59 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <code>libbluray2 (&gt;= 1:0.2.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <code>libchromaprint1 (&gt;= 1.3.2)</code> <em>(Debian Bookworm)</em>; <code>libgme0 (&gt;= 0.5.5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.5)</code></a>; <a href="#core2-package-libopenmpt0"><code>libopenmpt0 (&gt;= 0.3.0)</code></a>; <code>librabbitmq4 (&gt;= 0.6.0)</code> <em>(Debian Bookworm)</em>; <code>librist4 (&gt;= 0.2.6+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libsmbclient (&gt;= 2:4.0.3+dfsg1)</code> <em>(Debian Bookworm)</em>; <code>libsrt1.5-gnutls (&gt;= 1.5.1)</code> <em>(Debian Bookworm)</em>; <code>libssh-gcrypt-4 (&gt;= 0.8.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>; <code>libzmq5 (&gt;= 4.0.1+dfsg)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0.2)</code></a>

</details>

<details>
<summary id="core2-package-libavformat59"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libavformat59 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavcodec59"><code>libavcodec59 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <code>libbluray2 (&gt;= 1:0.2.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <code>libchromaprint1 (&gt;= 1.3.2)</code> <em>(Debian Bookworm)</em>; <code>libgme0 (&gt;= 0.5.5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.5)</code></a>; <a href="#core2-package-libopenmpt0"><code>libopenmpt0 (&gt;= 0.3.0)</code></a>; <code>librabbitmq4 (&gt;= 0.6.0)</code> <em>(Debian Bookworm)</em>; <code>librist4 (&gt;= 0.2.6+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libsrt1.5-gnutls (&gt;= 1.5.1)</code> <em>(Debian Bookworm)</em>; <code>libssh-gcrypt-4 (&gt;= 0.8.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>; <code>libzmq5 (&gt;= 4.0.1+dfsg)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0.2)</code></a>

</details>

<details>
<summary id="core2-package-libavutil57"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libavutil57 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.66)</code></a>; <code>libmfx1 (&gt;= 18.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libva-drm2"><code>libva-drm2 (&gt;= 1.3)</code></a>; <a href="#core2-package-libva-x11-2"><code>libva-x11-2 (&gt;= 1.3)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.1.0)</code></a>; <a href="#core2-package-libvdpau1"><code>libvdpau1 (&gt;= 0.2)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; one of: <code>ocl-icd-libopencl1</code> <em>(Debian Bookworm)</em> | <code>libopencl1</code> <em>(Debian Bookworm)</em>; one of: <code>ocl-icd-libopencl1 (&gt;= 1.0)</code> <em>(Debian Bookworm)</em> | <code>libopencl-1.2-1</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libflac++10"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-flac-1.4.2-ds-2-core2.1-20261023192521">libflac++10 1.4.2+ds-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libflac12"><code>libflac12 (&gt;= 1.4.1)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libflac12"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-flac-1.4.2-ds-2-core2.1-20261023192521">libflac12 1.4.2+ds-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libogg0"><code>libogg0 (&gt;= 1.0rc3)</code></a>

</details>

<details>
<summary id="core2-package-libgstreamer-gl1.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019">libgstreamer-gl1.0-0 1.22.0-3+deb12u7</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.17)</code></a>; <code>libegl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgbm1"><code>libgbm1 (&gt;= 8.1~0)</code></a>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.3)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.18.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <code>libgudev-1.0-0 (&gt;= 165)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libwayland-cursor0"><code>libwayland-cursor0 (&gt;= 1.11)</code></a>; <a href="#core2-package-libwayland-egl1"><code>libwayland-egl1 (&gt;= 1.15.0)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libx11-xcb1"><code>libx11-xcb1 (&gt;= 2:1.8.4)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>

</details>

<details>
<summary id="core2-package-libgstreamer-opencv1.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835">libgstreamer-opencv1.0-0 1.22.0-4+deb12u8 — GStreamer OpenCV libraries</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.68)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <code>libopencv-core406 (&gt;= 4.6.0+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 4.1.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libgstreamer-plugins-bad1.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835">libgstreamer-plugins-bad1.0-0 1.22.0-4+deb12u8</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.3.1)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.68)</code></a>; <a href="#core2-package-libgstreamer-gl1.0-0"><code>libgstreamer-gl1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <code>libnice10 (&gt;= 0.1.21)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libva-drm2"><code>libva-drm2 (&gt;= 1.8)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.10.0)</code></a>; <code>libvulkan1 (&gt;= 1.2.131.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>; <a href="#core2-package-libxkbcommon-x11-0"><code>libxkbcommon-x11-0 (&gt;= 0.5.0)</code></a>; <a href="#core2-package-libxkbcommon0"><code>libxkbcommon0 (&gt;= 0.5.0)</code></a>

</details>

<details>
<summary id="core2-package-libgstreamer-plugins-base1.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019">libgstreamer-plugins-base1.0-0 1.22.0-3+deb12u7</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.3)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-liborc-0.4-0"><code>liborc-0.4-0 (&gt;= 1:0.4.25)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <code>iso-codes</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libgstreamer1.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gstreamer1.0-1.22.0-2-deb12u1-core2.1-20261011064624">libgstreamer1.0-0 1.22.0-2+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <code>libdw1 (&gt;= 0.126)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.70.0)</code></a>; <code>libunwind8</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libcap2-bin"><code>libcap2-bin</code></a>

</details>

<details>
<summary id="core2-package-libmp3lame0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libmp3lame0-3.100-6-core2.1-20261016213051">libmp3lame0 3.100-6 — MP3 encoding library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>

</details>

<details>
<summary id="core2-package-libmpv2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mpv-0.35.1-4-core2.1-20261009190224">libmpv2 0.35.1-4</a></code></summary>

- **Depends:** <code>libarchive13 (&gt;= 3.4.0)</code> <em>(Debian Bookworm)</em>; <code>libasound2 (&gt;= 1.0.27)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libass9"><code>libass9 (&gt;= 1:0.15.0)</code></a>; <a href="#core2-package-libavcodec59"><code>libavcodec59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavdevice59"><code>libavdevice59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavfilter8"><code>libavfilter8 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavformat59"><code>libavformat59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (&gt;= 7:5.1)</code></a>; <code>libbluray2 (&gt;= 1:0.2.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libcaca0 (&gt;= 0.99.beta20)</code> <em>(Debian Bookworm)</em>; <code>libcdio-cdda2 (&gt;= 10.2+2.0.0)</code> <em>(Debian Bookworm)</em>; <code>libcdio-paranoia2 (&gt;= 10.2+2.0.0)</code> <em>(Debian Bookworm)</em>; <code>libcdio19 (&gt;= 2.1.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.105)</code></a>; <code>libdvdnav4 (&gt;= 4.1.3)</code> <em>(Debian Bookworm)</em>; <code>libegl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgbm1"><code>libgbm1 (&gt;= 17.1.0~rc2)</code></a>; one of: <code>libjack-jackd2-0 (&gt;= 1.9.10+20150825)</code> <em>(Debian Bookworm)</em> | <code>libjack-0.125</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.6)</code></a>; <code>liblua5.2-0 (&gt;= 5.2.4)</code> <em>(Debian Bookworm)</em>; <code>libmujs2 (&gt;= 1.0.7)</code> <em>(Debian Bookworm)</em>; <code>libpipewire-0.3-0 (&gt;= 0.3.50)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libplacebo208"><code>libplacebo208 (&gt;= 4.208.0)</code></a>; <code>libpulse0 (&gt;= 0.99.4)</code> <em>(Debian Bookworm)</em>; <code>librubberband2 (&gt;= 3.1.2+dfsg0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsdl2-2.0-0"><code>libsdl2-2.0-0 (&gt;= 2.0.12)</code></a>; <code>libsixel1 (&gt;= 1.10.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libswresample4"><code>libswresample4 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libswscale6"><code>libswscale6 (&gt;= 7:5.0)</code></a>; <code>libuchardet0 (&gt;= 0.0.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libva-drm2"><code>libva-drm2 (&gt;= 1.1.0)</code></a>; <a href="#core2-package-libva-wayland2"><code>libva-wayland2 (&gt;= 1.3.0)</code></a>; <a href="#core2-package-libva-x11-2"><code>libva-x11-2 (&gt;= 1.0.3)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.2.0)</code></a>; <a href="#core2-package-libvdpau1"><code>libvdpau1 (&gt;= 0.2)</code></a>; <code>libvulkan1 (&gt;= 1.2.131.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libwayland-cursor0"><code>libwayland-cursor0 (&gt;= 1.15.0)</code></a>; <a href="#core2-package-libwayland-egl1"><code>libwayland-egl1 (&gt;= 1.15.0)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.2.99.901)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxinerama1"><code>libxinerama1 (&gt;= 2:1.1.4)</code></a>; <a href="#core2-package-libxkbcommon0"><code>libxkbcommon0 (&gt;= 0.5.0)</code></a>; <code>libxpresent1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxrandr2"><code>libxrandr2 (&gt;= 2:1.4.0)</code></a>; <code>libxss1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxv1"><code>libxv1</code></a>; <code>libzimg2 (&gt;= 0.3.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libopus0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-opus-1.3.1-3-core2.1-20261023192526">libopus0 1.3.1-3 — Opus codec runtime library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>

</details>

<details>
<summary id="core2-package-libopusenc0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libopusenc-0.2.1-2-core2.1-20261023192524">libopusenc0 0.2.1-2 — High-level API for encoding Opus audio streams (library)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libopus0"><code>libopus0 (&gt;= 1.3~beta+20180516)</code></a>

</details>

<details>
<summary id="core2-package-libopusfile0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-opusfile-0.12-4-core2.1-20261023192513">libopusfile0 0.12-4 — High-level API for basic manipulation of Ogg Opus audio streams</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.28)</code></a>; <a href="#core2-package-libogg0"><code>libogg0 (&gt;= 1.1.0)</code></a>; <a href="#core2-package-libopus0"><code>libopus0 (&gt;= 1.1)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>

</details>

<details>
<summary id="core2-package-libpostproc56"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libpostproc56 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavutil57"><code>libavutil57 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libsox-ng5"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-sox-ng-14.8.1-core2.1-20261023214105">libsox-ng5 14.8.1</a></code></summary>

- **Depends:** <code>libao4 (&gt;= 1.1.0)</code> <em>(Debian Bookworm)</em>; <code>libasound2 (&gt;= 1.0.16)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libebur128-1"><code>libebur128-1 (&gt;= 1.0.1)</code></a>; <a href="#core2-package-libfftw3-double3"><code>libfftw3-double3 (&gt;= 3.3.10)</code></a>; <a href="#core2-package-libflac12"><code>libflac12 (&gt;= 1.3.0)</code></a>; <code>libgomp1 (&gt;= 4.9)</code> <em>(Debian Bookworm)</em>; <code>libgsm1 (&gt;= 1.0.18)</code> <em>(Debian Bookworm)</em>; <code>libid3tag0 (&gt;= 0.15.1b)</code> <em>(Debian Bookworm)</em>; <code>libltdl7 (&gt;= 2.4.7)</code> <em>(Debian Bookworm)</em>; <code>libmad0 (&gt;= 0.15.1b-3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libmagic1"><code>libmagic1 (&gt;= 5.12)</code></a>; <a href="#core2-package-libmp3lame0"><code>libmp3lame0 (&gt;= 3.100)</code></a>; <a href="#core2-package-libogg0"><code>libogg0 (&gt;= 1.0rc3)</code></a>; <code>libopencore-amrnb0 (&gt;= 0.1.6)</code> <em>(Debian Bookworm)</em>; <code>libopencore-amrwb0 (&gt;= 0.1.6)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libopusenc0"><code>libopusenc0 (&gt;= 0.2.1)</code></a>; <a href="#core2-package-libopusfile0"><code>libopusfile0 (&gt;= 0.5)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <code>libpulse0 (&gt;= 0.99.1)</code> <em>(Debian Bookworm)</em>; <code>libsndfile1 (&gt;= 1.0.20)</code> <em>(Debian Bookworm)</em>; <code>libsndio7.0 (&gt;= 1.8.1)</code> <em>(Debian Bookworm)</em>; <code>libspeexdsp1 (&gt;= 1.2.1)</code> <em>(Debian Bookworm)</em>; <code>libtwolame0 (&gt;= 0.3.10)</code> <em>(Debian Bookworm)</em>; <code>libvorbis0a (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <code>libvorbisenc2 (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <code>libvorbisfile3 (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <code>libwavpack1 (&gt;= 4.40.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libswresample4"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libswresample4 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavutil57"><code>libavutil57 (&gt;= 7:5.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <code>libsoxr0 (&gt;= 0.1.0)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libswscale6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944">libswscale6 7:5.1.9-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavutil57"><code>libavutil57 (= 7:5.1.9-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libvpx7"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libvpx-1.12.0-1-deb12u5-core2.1-20261016115550">libvpx7 1.12.0-1+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libx265-199"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-x265-3.5-2-core2.1-20261016145405">libx265-199 3.5-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libnuma1 (&gt;= 2.0.11)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 4.1.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-mpd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mpd-0.23.12-1-core2.1-20261009114100">mpd 0.23.12-1 — Music Player Daemon</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.54~)</code> <em>(Debian Bookworm)</em>
- **Depends:** <code>adduser</code> <em>(Debian Bookworm)</em>; <code>libadplug-2.3.3-0 (&gt;= 2.3.3+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libao4 (&gt;= 1.1.0)</code> <em>(Debian Bookworm)</em>; <code>libasound2 (&gt;= 1.0.18)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libavahi-client3"><code>libavahi-client3 (&gt;= 0.6.16)</code></a>; <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (&gt;= 0.6.16)</code></a>; <a href="#core2-package-libavcodec59"><code>libavcodec59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavformat59"><code>libavformat59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libcdio-cdda2 (&gt;= 10.2+2.0.0)</code> <em>(Debian Bookworm)</em>; <code>libcdio-paranoia2 (&gt;= 10.2+2.0.0)</code> <em>(Debian Bookworm)</em>; <code>libcdio19 (&gt;= 2.1.0)</code> <em>(Debian Bookworm)</em>; <code>libchromaprint1 (&gt;= 1.3.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libcurl3-gnutls"><code>libcurl3-gnutls (&gt;= 7.55)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.0.1)</code></a>; <code>libfaad2 (&gt;= 2.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libflac12"><code>libflac12 (&gt;= 1.3.0)</code></a>; <code>libfluidsynth3 (&gt;= 2.0.5)</code> <em>(Debian Bookworm)</em>; <code>libfmt9 (&gt;= 9.1.0+ds1)</code> <em>(Debian Bookworm)</em>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libgme0 (&gt;= 0.6.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libicu72"><code>libicu72 (&gt;= 72.1~rc-1~)</code></a>; <code>libid3tag0 (&gt;= 0.15.1b)</code> <em>(Debian Bookworm)</em>; <code>libiso9660-11 (&gt;= 2.0.0)</code> <em>(Debian Bookworm)</em>; <code>libixml10 (&gt;= 1:1.8.0)</code> <em>(Debian Bookworm)</em>; one of: <code>libjack-jackd2-0 (&gt;= 1.9.10+20150825)</code> <em>(Debian Bookworm)</em> | <code>libjack-0.125</code> <em>(Debian Bookworm)</em>; <code>libmad0 (&gt;= 0.15.1b-3)</code> <em>(Debian Bookworm)</em>; <code>libmikmod3 (&gt;= 3.3.3)</code> <em>(Debian Bookworm)</em>; <code>libmms0 (&gt;= 0.4)</code> <em>(Debian Bookworm)</em>; <code>libmodplug1 (&gt;= 1:0.8.8.5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libmp3lame0"><code>libmp3lame0 (&gt;= 3.100)</code></a>; <code>libmpcdec6 (&gt;= 1:0.1~r435)</code> <em>(Debian Bookworm)</em>; <code>libmpdclient2 (&gt;= 2.16)</code> <em>(Debian Bookworm)</em>; <code>libmpg123-0 (&gt;= 1.28.0)</code> <em>(Debian Bookworm)</em>; <code>libnfs13 (&gt;= 1.9.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libogg0"><code>libogg0 (&gt;= 1.1.0)</code></a>; <code>libopenal1 (&gt;= 1.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libopenmpt0"><code>libopenmpt0 (&gt;= 0.5.10)</code></a>; <a href="#core2-package-libopus0"><code>libopus0 (&gt;= 1.1)</code></a>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.22)</code></a>; <code>libpipewire-0.3-0 (&gt;= 0.3.38)</code> <em>(Debian Bookworm)</em>; <code>libpulse0 (&gt;= 0.99.1)</code> <em>(Debian Bookworm)</em>; <code>libsamplerate0 (&gt;= 0.1.7)</code> <em>(Debian Bookworm)</em>; <code>libshout3 (&gt;= 2.4.6)</code> <em>(Debian Bookworm)</em>; <code>libsidplayfp6 (&gt;= 2.4.2)</code> <em>(Debian Bookworm)</em>; <code>libsmbclient (&gt;= 2:4.0.3+dfsg1)</code> <em>(Debian Bookworm)</em>; <code>libsndfile1 (&gt;= 1.0.20)</code> <em>(Debian Bookworm)</em>; <code>libsndio7.0 (&gt;= 1.8.1)</code> <em>(Debian Bookworm)</em>; <code>libsoxr0 (&gt;= 0.1.0)</code> <em>(Debian Bookworm)</em>; <code>libsqlite3-0 (&gt;= 3.5.9)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 12)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>; <code>libupnp13 (&gt;= 1:1.8.3)</code> <em>(Debian Bookworm)</em>; <code>liburing2 (&gt;= 2.3)</code> <em>(Debian Bookworm)</em>; <code>libvorbis0a (&gt;= 1.2.3)</code> <em>(Debian Bookworm)</em>; <code>libvorbisenc2 (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <code>libwavpack1 (&gt;= 5.0.0)</code> <em>(Debian Bookworm)</em>; <code>libwildmidi2 (&gt;= 0.4.0)</code> <em>(Debian Bookworm)</em>; <code>libyajl2 (&gt;= 2.0.4)</code> <em>(Debian Bookworm)</em>; <code>libzzip-0-13 (&gt;= 0.13.56)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <code>libjs-sphinxdoc (&gt;= 5.2)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-mpv"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mpv-0.35.1-4-core2.1-20261009190224">mpv 0.35.1-4 — video player based on MPlayer/mplayer2</a></code></summary>

- **Depends:** <code>libarchive13 (&gt;= 3.4.0)</code> <em>(Debian Bookworm)</em>; <code>libasound2 (&gt;= 1.0.27)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libass9"><code>libass9 (&gt;= 1:0.15.0)</code></a>; <a href="#core2-package-libavcodec59"><code>libavcodec59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavdevice59"><code>libavdevice59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavfilter8"><code>libavfilter8 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavformat59"><code>libavformat59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (&gt;= 7:5.1)</code></a>; <code>libbluray2 (&gt;= 1:0.2.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libcaca0 (&gt;= 0.99.beta20)</code> <em>(Debian Bookworm)</em>; <code>libcdio-cdda2 (&gt;= 10.2+2.0.0)</code> <em>(Debian Bookworm)</em>; <code>libcdio-paranoia2 (&gt;= 10.2+2.0.0)</code> <em>(Debian Bookworm)</em>; <code>libcdio19 (&gt;= 2.1.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.105)</code></a>; <code>libdvdnav4 (&gt;= 4.1.3)</code> <em>(Debian Bookworm)</em>; <code>libegl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgbm1"><code>libgbm1 (&gt;= 17.1.0~rc2)</code></a>; one of: <code>libjack-jackd2-0 (&gt;= 1.9.10+20150825)</code> <em>(Debian Bookworm)</em> | <code>libjack-0.125</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.6)</code></a>; <code>liblua5.2-0 (&gt;= 5.2.4)</code> <em>(Debian Bookworm)</em>; <code>libmujs2 (&gt;= 1.0.7)</code> <em>(Debian Bookworm)</em>; <code>libpipewire-0.3-0 (&gt;= 0.3.50)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libplacebo208"><code>libplacebo208 (&gt;= 4.208.0)</code></a>; <code>libpulse0 (&gt;= 0.99.4)</code> <em>(Debian Bookworm)</em>; <code>librubberband2 (&gt;= 3.1.2+dfsg0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsdl2-2.0-0"><code>libsdl2-2.0-0 (&gt;= 2.0.12)</code></a>; <code>libsixel1 (&gt;= 1.10.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libswresample4"><code>libswresample4 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libswscale6"><code>libswscale6 (&gt;= 7:5.0)</code></a>; <code>libuchardet0 (&gt;= 0.0.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libva-drm2"><code>libva-drm2 (&gt;= 1.1.0)</code></a>; <a href="#core2-package-libva-wayland2"><code>libva-wayland2 (&gt;= 1.3.0)</code></a>; <a href="#core2-package-libva-x11-2"><code>libva-x11-2 (&gt;= 1.0.3)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.2.0)</code></a>; <a href="#core2-package-libvdpau1"><code>libvdpau1 (&gt;= 0.2)</code></a>; <code>libvulkan1 (&gt;= 1.2.131.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libwayland-cursor0"><code>libwayland-cursor0 (&gt;= 1.15.0)</code></a>; <a href="#core2-package-libwayland-egl1"><code>libwayland-egl1 (&gt;= 1.15.0)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.2.99.901)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxinerama1"><code>libxinerama1 (&gt;= 2:1.1.4)</code></a>; <a href="#core2-package-libxkbcommon0"><code>libxkbcommon0 (&gt;= 0.5.0)</code></a>; <code>libxpresent1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxrandr2"><code>libxrandr2 (&gt;= 2:1.4.0)</code></a>; <code>libxss1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxv1"><code>libxv1</code></a>; <code>libzimg2 (&gt;= 0.3.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-opus-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-opus-tools-0.2-1-core2.1-20261023192504">opus-tools 0.2-1 — Opus codec command line tools</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libflac12"><code>libflac12 (&gt;= 1.3.0)</code></a>; <a href="#core2-package-libogg0"><code>libogg0 (&gt;= 1.0rc3)</code></a>; <a href="#core2-package-libopus0"><code>libopus0 (&gt;= 1.1)</code></a>; <a href="#core2-package-libopusenc0"><code>libopusenc0 (&gt;= 0.2.1)</code></a>; <a href="#core2-package-libopusfile0"><code>libopusfile0 (&gt;= 0.5)</code></a>

</details>

<details>
<summary id="core2-package-sox-ng"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-sox-ng-14.8.1-core2.1-20261023214105">sox-ng 14.8.1 — Swiss Army knife of sound processing (SoX NG)</a></code></summary>

- **Depends:** <a href="#core2-package-libsox-ng5"><code>libsox-ng5 (= 14.8.1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-vpx-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libvpx-1.12.0-1-deb12u5-core2.1-20261016115550">vpx-tools 1.12.0-1+deb12u5 — VP8 and VP9 video codec encoding/decoding tools</a></code></summary>

- **Depends:** <a href="#core2-package-libvpx7"><code>libvpx7 (= 1.12.0-1+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5.2)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-x265"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-x265-3.5-2-core2.1-20261016145405">x265 3.5-2 — H.265/HEVC video stream encoder</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libstdc++6 (&gt;= 4.2.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx265-199"><code>libx265-199 (&gt;= 3.5)</code></a>; <a href="#core2-package-libx265-199"><code>libx265-199 (&lt;&lt; 3.6)</code></a>

</details>

</details>

<details>
<summary>Development (83 packages)</summary>

<details>
<summary id="core2-package-alacritty"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-rust-alacritty-0.11.0-4-core2.1-20261016151054">alacritty 0.11.0-4 — Fast, cross-platform, OpenGL terminal emulator</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.8)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.11.1)</code></a>

</details>

<details>
<summary id="core2-package-bat"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-rust-bat-0.22.1-4-core2.1-20261018000710">bat 0.22.1-4 — cat(1) clone with syntax highlighting and git integration</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libgit2-1.5 (&gt;= 1.5.0)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-binutils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils 2.40-2 — GNU assembler, linker and binary utilities</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-binutils-x86-64-linux-gnu"><code>binutils-x86-64-linux-gnu (= 2.40-2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-binutils-aarch64-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-aarch64-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-alpha-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-alpha-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-arc-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-arc-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-arm-linux-gnueabi"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-arm-linux-gnueabi 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-arm-linux-gnueabihf"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-arm-linux-gnueabihf 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-common 2.40-2</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-binutils-for-build"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-for-build 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils"><code>binutils (&gt;= 2.30-2)</code></a>; <a href="#core2-package-binutils-common"><code>binutils-common (&gt;= 2.30-2)</code></a>

</details>

<details>
<summary id="core2-package-binutils-for-host"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-for-host 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-x86-64-linux-gnu"><code>binutils-x86-64-linux-gnu:any (&gt;= 2.30-2)</code></a>; <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-binutils-hppa-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-hppa-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-hppa64-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-hppa64-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>; <a href="#core2-package-binutils"><code>binutils (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-binutils-i686-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-i686-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-i686-kfreebsd-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-i686-kfreebsd-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-i686-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-i686-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-ia64-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-ia64-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-m68k-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-m68k-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-multiarch"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-multiarch 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>; <a href="#core2-package-binutils"><code>binutils (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-binutils-powerpc-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-powerpc-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-powerpc64-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-powerpc64-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-powerpc64le-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-powerpc64le-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-riscv64-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-riscv64-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-s390x-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-s390x-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-sh4-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-sh4-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-source"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-source 2.40-2</a></code></summary>

- **Depends:** <code>texinfo</code> <em>(Debian Bookworm)</em>; <a href="https://github.com/AmrUser-48/linux/releases/tag/core2-zlib-1-1.2.13.dfsg-1-core2.1-20261016151112"><code>zlib1g-dev</code></a> <em>(non-runtime Core 2 package)</em>; <code>make</code> <em>(Debian Bookworm)</em>; <code>python3</code> <em>(Debian Bookworm)</em>; <code>libjansson-dev</code> <em>(Debian Bookworm)</em>; <code>pkg-config</code> <em>(Debian Bookworm)</em>; <a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libzstd-1.5.4-dfsg2-5-core2.1-20261020161546"><code>libzstd-dev</code></a> <em>(non-runtime Core 2 package)</em>

</details>

<details>
<summary id="core2-package-binutils-sparc64-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-sparc64-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-x86-64-kfreebsd-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-x86-64-kfreebsd-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-x86-64-linux-gnu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-x86-64-linux-gnu 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <a href="#core2-package-libctf-nobfd0"><code>libctf-nobfd0 (&gt;= 2.36)</code></a>; <a href="#core2-package-libctf0"><code>libctf0 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgprofng0"><code>libgprofng0 (&gt;= 2.40-2+core2.1~BUILD)</code></a>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-binutils-x86-64-linux-gnux32"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">binutils-x86-64-linux-gnux32 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libbinutils"><code>libbinutils (&gt;= 2.39.50)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <code>libjansson4 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-fd-find"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-rust-fd-find-8.6.0-3-core2.1-20261009114655">fd-find 8.6.0-3 — Simple, fast and user-friendly alternative to find</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-gdbm-l10n"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gdbm-1.23-3-core2.1-20261020155702">gdbm-l10n 1.23-3</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-gdbmtool"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gdbm-1.23-3-core2.1-20261020155702">gdbmtool 1.23-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgdbm6"><code>libgdbm6 (&gt;= 1.21)</code></a>; <a href="#core2-package-libreadline8"><code>libreadline8 (&gt;= 6.0)</code></a>

</details>

<details>
<summary id="core2-package-idle-python3.11"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835">idle-python3.11 3.11.2-6+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-python3.11"><code>python3.11</code></a>; <code>python3-tk</code> <em>(Debian Bookworm)</em>; <code>python3.11-tk</code> <em>(Debian Bookworm)</em>; <code>libjs-mathjax</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libbinutils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">libbinutils 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>; <a href="#core2-package-binutils-common"><code>binutils-common (= 2.40-2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libc-dev-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">libc-dev-bin 2.36-9+deb12u14</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;&gt; 2.36)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&lt;&lt; 2.37)</code></a>

</details>

<details>
<summary id="core2-package-libc6-dev-i386"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">libc6-dev-i386 2.36-9+deb12u14</a></code></summary>

- **Depends:** <a href="#core2-package-libc6-i386"><code>libc6-i386 (= 2.36-9+deb12u14+core2.1~BUILD)</code></a>; <a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854"><code>libc6-dev (= 2.36-9+deb12u14+core2.1~BUILD)</code></a> <em>(non-runtime Core 2 package)</em>

</details>

<details>
<summary id="core2-package-libc6-dev-x32"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">libc6-dev-x32 2.36-9+deb12u14</a></code></summary>

- **Depends:** <a href="#core2-package-libc6-x32"><code>libc6-x32 (= 2.36-9+deb12u14+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6-dev-i386"><code>libc6-dev-i386 (= 2.36-9+deb12u14+core2.1~BUILD)</code></a>; <a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854"><code>libc6-dev (= 2.36-9+deb12u14+core2.1~BUILD)</code></a> <em>(non-runtime Core 2 package)</em>

</details>

<details>
<summary id="core2-package-libctf-nobfd0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">libctf-nobfd0 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-libctf0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">libctf0 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-libbinutils"><code>libbinutils (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-libfile-find-rule-perl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libfile-find-rule-perl-0.34-4-deb12u1-core2.1-20261020160848">libfile-find-rule-perl 0.34-4~deb12u1 — module to search for files based on rules</a></code></summary>

- **Depends:** <a href="#core2-package-perl"><code>perl:any</code></a>; <a href="#core2-package-libnumber-compare-perl"><code>libnumber-compare-perl</code></a>; <a href="#core2-package-libtext-glob-perl"><code>libtext-glob-perl</code></a>

</details>

<details>
<summary id="core2-package-libgdbm-compat4"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gdbm-1.23-3-core2.1-20261020155702">libgdbm-compat4 1.23-3 — GNU dbm database routines (legacy support runtime version)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libgdbm6"><code>libgdbm6 (&gt;= 1.16)</code></a>

</details>

<details>
<summary id="core2-package-libgdbm6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gdbm-1.23-3-core2.1-20261020155702">libgdbm6 1.23-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libgprofng0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258">libgprofng0 2.40-2</a></code></summary>

- **Depends:** <a href="#core2-package-libbinutils"><code>libbinutils (= 2.40-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.3.1)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libimage-magick-perl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libimage-magick-perl 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.15.7.2)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-perl"><code>perl:any</code></a>; <a href="#core2-package-imagemagick-6-common"><code>imagemagick-6-common (= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-libimage-magick-q16-perl"><code>libimage-magick-q16-perl</code></a>

</details>

<details>
<summary id="core2-package-libimage-magick-q16-perl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libimage-magick-q16-perl 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.17.11)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-perl"><code>perl (&gt;= 5.36.0-7+deb12u4)</code></a>; <code>perlapi-5.36.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.7)</code></a>; <a href="#core2-package-libmagickcore-6.q16-6"><code>libmagickcore-6.q16-6 (&gt;= 8:6.9.10.2)</code></a>; <a href="#core2-package-libperl5.36"><code>libperl5.36 (&gt;= 5.36.0)</code></a>

</details>

<details>
<summary id="core2-package-libimage-magick-q16hdri-perl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libimage-magick-q16hdri-perl 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.17.11)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-perl"><code>perl (&gt;= 5.36.0-7+deb12u4)</code></a>; <code>perlapi-5.36.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.7)</code></a>; <a href="#core2-package-libmagickcore-6.q16hdri-6"><code>libmagickcore-6.q16hdri-6 (&gt;= 8:6.9.10.2)</code></a>; <a href="#core2-package-libperl5.36"><code>libperl5.36 (&gt;= 5.36.0)</code></a>

</details>

<details>
<summary id="core2-package-libnumber-compare-perl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libnumber-compare-perl-0.03-3-core2.1-20261020161009">libnumber-compare-perl 0.03-3 — module for performing numeric comparisons in Perl</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-liborc-0.4-dev-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-orc-1-0.4.33-2-core2.1-20261016143016">liborc-0.4-dev-bin 1:0.4.33-2 — Library of Optimized Inner Loops Runtime Compiler (development tools)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-liborc-0.4-0"><code>liborc-0.4-0 (&gt;= 1:0.4.25)</code></a>

</details>

<details>
<summary id="core2-package-libperl5.36"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002">libperl5.36 5.36.0-7+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libcrypt1"><code>libcrypt1 (&gt;= 1:4.1.0)</code></a>; <a href="#core2-package-libdb5.3"><code>libdb5.3</code></a>; <a href="#core2-package-libgdbm-compat4"><code>libgdbm-compat4 (&gt;= 1.18-3)</code></a>; <a href="#core2-package-libgdbm6"><code>libgdbm6 (&gt;= 1.21)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.2.3)</code></a>; <a href="#core2-package-perl-modules-5.36"><code>perl-modules-5.36 (&gt;= 5.36.0-7+deb12u4+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libpython3.11"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835">libpython3.11 3.11.2-6+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-libpython3.11-stdlib"><code>libpython3.11-stdlib (= 3.11.2-6+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.1~beta3)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-libpython3.11-minimal"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835">libpython3.11-minimal 3.11.2-6+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>

</details>

<details>
<summary id="core2-package-libpython3.11-stdlib"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835">libpython3.11-stdlib 3.11.2-6+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-libpython3.11-minimal"><code>libpython3.11-minimal (= 3.11.2-6+deb12u9+core2.1~BUILD)</code></a>; one of: <code>media-types</code> <em>(Debian Bookworm)</em> | <code>mime-support</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcrypt1"><code>libcrypt1 (&gt;= 1:4.1.0)</code></a>; <a href="#core2-package-libdb5.3"><code>libdb5.3</code></a>; <a href="#core2-package-libffi8"><code>libffi8 (&gt;= 3.4)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-libncursesw6"><code>libncursesw6 (&gt;= 6.1)</code></a>; <code>libnsl2 (&gt;= 1.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libreadline8"><code>libreadline8 (&gt;= 7.0~beta)</code></a>; <code>libsqlite3-0 (&gt;= 3.36.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>; <a href="#core2-package-libtirpc3"><code>libtirpc3 (&gt;= 1.0.2)</code></a>; <code>libuuid1 (&gt;= 2.20.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libpython3.11-testsuite"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835">libpython3.11-testsuite 3.11.2-6+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-python3.11"><code>python3.11 (&gt;= 3.11.2-6+deb12u9+core2.1~BUILD)</code></a>; <code>net-tools</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libtext-glob-perl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libtext-glob-perl-0.11-3-core2.1-20261020161151">libtext-glob-perl 0.11-3 — Perl module for matching globbing patterns against text</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-perl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002">perl 5.36.0-7+deb12u4 — Larry Wall's Practical Extraction and Report Language</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.17.17)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-perl-base"><code>perl-base (= 5.36.0-7+deb12u4+core2.1~BUILD)</code></a>; <a href="#core2-package-perl-modules-5.36"><code>perl-modules-5.36 (&gt;= 5.36.0-7+deb12u4+core2.1~BUILD)</code></a>; <a href="#core2-package-libperl5.36"><code>libperl5.36 (= 5.36.0-7+deb12u4+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-perl-base"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002">perl-base 5.36.0-7+deb12u4</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libcrypt1"><code>libcrypt1 (&gt;= 1:4.1.0)</code></a>; <code>dpkg (&gt;= 1.17.17)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-perl-modules-5.36"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002">perl-modules-5.36 5.36.0-7+deb12u4</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.17.17)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-perl-base"><code>perl-base (&gt;= 5.36.0-1)</code></a>

</details>

<details>
<summary id="core2-package-perlmagick"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">perlmagick 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.15.7.2)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-imagemagick-6-common"><code>imagemagick-6-common (= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-libimage-magick-perl"><code>libimage-magick-perl</code></a>

</details>

<details>
<summary id="core2-package-python3-apparmor"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-apparmor-3.0.8-3-core2.1-20261020155241">python3-apparmor 3.0.8-3</a></code></summary>

- **Depends:** <a href="#core2-package-python3-libapparmor"><code>python3-libapparmor (&gt;= 3.0.8)</code></a>; <code>python3:any</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-python3-audit"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-audit-1-3.0.9-1-core2.1-20261020155244">python3-audit 1:3.0.9-1</a></code></summary>

- **Depends:** <a href="#core2-package-libaudit1"><code>libaudit1 (= 1:3.0.9-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libauparse0"><code>libauparse0 (= 1:3.0.9-1+core2.1~BUILD)</code></a>; <code>python3 (&lt;&lt; 3.12), python3 (&gt;= 3.11~), python3:any, libc6 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-python3-avahi"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">python3-avahi 0.8-10+deb12u1</a></code></summary>

- **Depends:** <code>python3:any</code> <em>(Debian Bookworm)</em>; <code>python3-gdbm</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libavahi-common-data"><code>libavahi-common-data (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <code>python3-dbus</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-python3-boto"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python-boto-2.49.0-4.1-core2.1-20261012055353">python3-boto 2.49.0-4.1 — Python interface to Amazon's Web Services - Python 3.x</a></code></summary>

- **Depends:** <code>python3-requests</code> <em>(Debian Bookworm)</em>; <code>python3:any</code> <em>(Debian Bookworm)</em>; <code>python3-six</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-python3-brotli"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-brotli-1.0.9-2-core2.1-20261016150736">python3-brotli 1.0.9-2</a></code></summary>

- **Depends:** <code>python3 (&lt;&lt; 3.12), python3 (&gt;= 3.11~), python3:any, libc6 (&gt;= 2.29)</code> <em>(Debian Bookworm)</em>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-python3-cap-ng"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libcap-ng-0.8.3-1-core2.1-20261020160633">python3-cap-ng 0.8.3-1</a></code></summary>

- **Depends:** <code>python3 (&lt;&lt; 3.12), python3 (&gt;= 3.11~), python3:any, libc6 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libcap-ng0"><code>libcap-ng0 (&gt;= 0.8.3)</code></a>

</details>

<details>
<summary id="core2-package-python3-graphite2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-graphite2-1.3.14-1-deb12u1-core2.1-20261020160000">python3-graphite2 1.3.14-1+deb12u1 — Python bindings for libgraphite2</a></code></summary>

- **Depends:** <a href="#core2-package-libgraphite2-3"><code>libgraphite2-3</code></a>; <code>python3-future</code> <em>(Debian Bookworm)</em>; <code>python3:any</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-python3-lerc"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-lerc-4.0.0-ds-2-core2.1-20261020160636">python3-lerc 4.0.0+ds-2 — Python 3 bindings to the Limited Error Raster Compression library</a></code></summary>

- **Depends:** <a href="#core2-package-liblerc4"><code>liblerc4</code></a>; <code>python3-numpy</code> <em>(Debian Bookworm)</em>; <code>python3:any</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-python3-libapparmor"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-apparmor-3.0.8-3-core2.1-20261020155241">python3-libapparmor 3.0.8-3</a></code></summary>

- **Depends:** <code>python3 (&lt;&lt; 3.12), python3 (&gt;= 3.11~), python3:any, libapparmor1 (&gt;= 2.10.95)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-python3-libxml2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxml2-2.9.14-dfsg-1.3-deb12u6-core2.1-20261020161513">python3-libxml2 2.9.14+dfsg-1.3~deb12u6</a></code></summary>

- **Depends:** <code>python3 (&lt;&lt; 3.12), python3 (&gt;= 3.11~), python3:any, libc6 (&gt;= 2.28)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.9.11)</code></a>

</details>

<details>
<summary id="core2-package-python3-seccomp"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libseccomp-2.5.4-1-deb12u1-core2.1-20261017010131">python3-seccomp 2.5.4-1+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <code>python3 (&lt;&lt; 3.12), python3 (&gt;= 3.11~)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-python3-selinux"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libselinux-3.4-1-core2.1-20261009190433">python3-selinux 3.4-1</a></code></summary>

- **Depends:** <code>python3 (&lt;&lt; 3.12), python3 (&gt;= 3.11~), python3:any, libc6 (&gt;= 2.26)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.4)</code></a>

</details>

<details>
<summary id="core2-package-python3-semanage"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libsemanage-3.4-1-core2.1-20261020161025">python3-semanage 3.4-1</a></code></summary>

- **Depends:** <code>python3 (&lt;&lt; 3.12), python3 (&gt;= 3.11~), python3:any, libc6 (&gt;= 2.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsemanage2"><code>libsemanage2 (&gt;= 3.4)</code></a>

</details>

<details>
<summary id="core2-package-python3-tz"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python-tz-2022.7.1-4-core2.1-20261012055311">python3-tz 2022.7.1-4 — Python3 version of the Olson timezone database</a></code></summary>

- **Depends:** <code>tzdata</code> <em>(Debian Bookworm)</em>; <code>python3:any</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-python3.11"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835">python3.11 3.11.2-6+deb12u9 — Interactive high-level object-oriented language (version 3.11)</a></code></summary>

- **Depends:** <a href="#core2-package-python3.11-minimal"><code>python3.11-minimal (= 3.11.2-6+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libpython3.11-stdlib"><code>libpython3.11-stdlib (= 3.11.2-6+deb12u9+core2.1~BUILD)</code></a>; one of: <code>media-types</code> <em>(Debian Bookworm)</em> | <code>mime-support</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-python3.11-examples"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835">python3.11-examples 3.11.2-6+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-python3.11"><code>python3.11:any (&gt;= 3.11.2-6+deb12u9+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-python3.11-full"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835">python3.11-full 3.11.2-6+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-python3.11"><code>python3.11 (= 3.11.2-6+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libpython3.11-testsuite"><code>libpython3.11-testsuite</code></a>; <a href="#core2-package-python3.11-venv"><code>python3.11-venv (= 3.11.2-6+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-idle-python3.11"><code>idle-python3.11</code></a>; <code>python3.11-distutils</code> <em>(Debian Bookworm)</em>; <code>python3.11-gdbm</code> <em>(Debian Bookworm)</em>; <code>python3.11-lib2to3</code> <em>(Debian Bookworm)</em>; <code>python3.11-tk</code> <em>(Debian Bookworm)</em>; <code>ca-certificates</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-python3.11-minimal"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835">python3.11-minimal 3.11.2-6+deb12u9</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>
- **Depends:** <a href="#core2-package-libpython3.11-minimal"><code>libpython3.11-minimal (= 3.11.2-6+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.1~beta3)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-python3.11-nopie"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835">python3.11-nopie 3.11.2-6+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-python3.11-minimal"><code>python3.11-minimal (= 3.11.2-6+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.1~beta3)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-python3.11-venv"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835">python3.11-venv 3.11.2-6+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-python3.11"><code>python3.11 (= 3.11.2-6+deb12u9+core2.1~BUILD)</code></a>; <code>python3-pip-whl (&gt;= 22.2)</code> <em>(Debian Bookworm)</em>; <code>python3-setuptools-whl</code> <em>(Debian Bookworm)</em>; <code>python3.11-distutils</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-ripgrep"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-rust-ripgrep-13.0.0-4-core2.1-20261009115443">ripgrep 13.0.0-4 — Recursively searches directories for a regex pattern</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.22)</code></a>

</details>

<details>
<summary id="core2-package-ruby-selinux"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libselinux-3.4-1-core2.1-20261009190433">ruby-selinux 3.4-1 — Ruby bindings to SELinux shared libraries</a></code></summary>

- **Depends:** one of: <code>ruby</code> <em>(Debian Bookworm)</em> | <code>ruby-interpreter</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.4)</code></a>; <code>libruby3.1 (&gt;= 3.1.2)</code> <em>(Debian Bookworm)</em>; <code>libruby (&gt;= 1:3.1~0)</code> <em>(Debian Bookworm)</em>; <code>libruby (&lt;&lt; 1:3.2~)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-ruby-semanage"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libsemanage-3.4-1-core2.1-20261020161025">ruby-semanage 3.4-1</a></code></summary>

- **Depends:** one of: <code>ruby</code> <em>(Debian Bookworm)</em> | <code>ruby-interpreter</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libsemanage2"><code>libsemanage2 (&gt;= 3.4)</code></a>; <code>libruby3.1 (&gt;= 3.1.2)</code> <em>(Debian Bookworm)</em>; <code>libruby (&gt;= 1:3.1~0)</code> <em>(Debian Bookworm)</em>; <code>libruby (&lt;&lt; 1:3.2~)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-sd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-rust-sd-0.7.6-1-deb12u1-core2.1-20261009163957">sd 0.80.really.0.7.6-1+deb12u1 — intuitive find and replace CLI</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 4.2)</code> <em>(Debian Bookworm)</em>

</details>

</details>

<details>
<summary>System &amp; libraries (74 packages)</summary>

<details>
<summary id="core2-package-ash"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-dash-0.5.12-2-core2.1-20261009104558">ash 0.5.12-2</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-dash"><code>dash</code></a>

</details>

<details>
<summary id="core2-package-bash"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-bash-5.2.15-2-core2.1-20261009104102">bash 5.2.15-2 — GNU Bourne Again SHell</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>
- **Depends:** <code>base-files (&gt;= 2.1.12)</code> <em>(Debian Bookworm)</em>; <code>debianutils (&gt;= 5.6-0.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-bash-builtins"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-bash-5.2.15-2-core2.1-20261009104102">bash-builtins 5.2.15-2</a></code></summary>

- **Depends:** <a href="#core2-package-bash"><code>bash (= 5.2.15-2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-bash-static"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-bash-5.2.15-2-core2.1-20261009104102">bash-static 5.2.15-2</a></code></summary>

- **Depends:** <a href="#core2-package-passwd"><code>passwd (&gt;= 1:4.0.3-10)</code></a>; <code>debianutils (&gt;= 5.6-0.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-busybox"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-busybox-1-1.35.0-4-deb12u1-core2.1-20261012093022">busybox 1:1.35.0-4+deb12u1 — Tiny utilities for small and embedded systems</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-busybox-static"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-busybox-1-1.35.0-4-deb12u1-core2.1-20261012093022">busybox-static 1:1.35.0-4+deb12u1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-busybox-syslogd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-busybox-1-1.35.0-4-deb12u1-core2.1-20261012093022">busybox-syslogd 1:1.35.0-4+deb12u1</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.54~)</code> <em>(Debian Bookworm)</em>
- **Depends:** one of: <a href="#core2-package-busybox"><code>busybox (&gt;&gt; 1:1.35.0)</code></a> | <a href="#core2-package-busybox-static"><code>busybox-static (&gt;&gt; 1:1.35.0)</code></a>; <code>lsb-base</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-bzip2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-bzip2-1.0.8-5-core2.1-20261012055218">bzip2 1.0.8-5 — high-quality block-sorting file compressor - utilities</a></code></summary>

- **Depends:** <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0 (= 1.0.8-5+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-coreutils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-coreutils-9.1-1-core2.1-20261009103756">coreutils 9.1-1 — GNU core utilities</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libacl1"><code>libacl1 (&gt;= 2.2.23)</code></a>; <a href="#core2-package-libattr1"><code>libattr1 (&gt;= 1:2.4.44)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgmp10"><code>libgmp10 (&gt;= 2:6.2.1+dfsg1)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>

</details>

<details>
<summary id="core2-package-dash"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-dash-0.5.12-2-core2.1-20261009104558">dash 0.5.12-2 — POSIX-compliant shell</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>
- **Depends:** <code>debianutils (&gt;= 5.6-0.1)</code> <em>(Debian Bookworm)</em>; <code>dpkg (&gt;= 1.19.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-glibc-source"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">glibc-source 2.36-9+deb12u14</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-grep"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-grep-3.8-5-core2.1-20261009191150">grep 3.8-5 — GNU grep, egrep and fgrep</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.32)</code></a>
- **Depends:** one of: <code>dpkg (&gt;= 1.15.4)</code> <em>(Debian Bookworm)</em> | <code>install-info</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-gzip"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-gzip-1.12-1-core2.1-20261009191817">gzip 1.12-1 — GNU compression utilities</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>
- **Depends:** one of: <code>dpkg (&gt;= 1.15.4)</code> <em>(Debian Bookworm)</em> | <code>install-info</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-gzip-win32"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-gzip-1.12-1-core2.1-20261009191817">gzip-win32 1.12-1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-kmod"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-kmod-30-20221128-1-core2.1-20261009193535">kmod 30+20221128-1 — tools for managing Linux kernel modules</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-libkmod2"><code>libkmod2 (= 30+20221128-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libatk-adaptor"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253">libatk-adaptor 2.46.0-5</a></code></summary>

- **Depends:** <a href="#core2-package-libatk-bridge2.0-0"><code>libatk-bridge2.0-0 (&gt;= 2.46.0-5+core2.1~BUILD)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62)</code></a>

</details>

<details>
<summary id="core2-package-libbz2-1.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-bzip2-1.0.8-5-core2.1-20261012055218">libbz2-1.0 1.0.8-5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>

</details>

<details>
<summary id="core2-package-libc-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">libc-bin 2.36-9+deb12u14</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;&gt; 2.36)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&lt;&lt; 2.37)</code></a>

</details>

<details>
<summary id="core2-package-libc-devtools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">libc-devtools 2.36-9+deb12u14</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgd3 (&gt;= 2.1.0~alpha~)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libc-l10n"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">libc-l10n 2.36-9+deb12u14</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libc6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">libc6 2.36-9+deb12u14 — GNU C Library: Shared libraries</a></code></summary>

- **Depends:** <code>libgcc-s1</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libc6-i386"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">libc6-i386 2.36-9+deb12u14</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (= 2.36-9+deb12u14+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libc6-x32"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">libc6-x32 2.36-9+deb12u14</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (= 2.36-9+deb12u14+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libgnutls-openssl27"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800">libgnutls-openssl27 3.7.9-2+deb12u7</a></code></summary>

- **Depends:** <a href="#core2-package-libgnutls30"><code>libgnutls30 (= 3.7.9-2+deb12u7+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libkmod2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-kmod-30-20221128-1-core2.1-20261009193535">libkmod2 30+20221128-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>

</details>

<details>
<summary id="core2-package-liblzma5"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709">liblzma5 5.4.1-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libnss-myhostname"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">libnss-myhostname 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libnss-mymachines"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">libnss-mymachines 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-systemd-container"><code>systemd-container (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libnss-resolve"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">libnss-resolve 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-systemd-resolved"><code>systemd-resolved (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libnss-systemd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">libnss-systemd 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-systemd"><code>systemd (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libpam-apparmor"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-apparmor-3.0.8-3-core2.1-20261020155241">libpam-apparmor 3.0.8-3</a></code></summary>

- **Depends:** <a href="#core2-package-libapparmor1"><code>libapparmor1 (&gt;= 2.6~devel)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>

</details>

<details>
<summary id="core2-package-libpam-cap"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327">libpam-cap 1:2.66-4+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libpam-runtime"><code>libpam-runtime (&gt;= 1.1.3-2~)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.63)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>

</details>

<details>
<summary id="core2-package-libpam-modules"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111">libpam-modules 1.5.2-6+deb12u2</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcrypt1"><code>libcrypt1 (&gt;= 1:4.3.0)</code></a>; <a href="#core2-package-libdb5.3"><code>libdb5.3</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 1.4.1)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpam-modules-bin"><code>libpam-modules-bin (= 1.5.2-6+deb12u2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libpam-modules-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111">libpam-modules-bin 1.5.2-6+deb12u2 — Pluggable Authentication Modules for PAM - helper binaries</a></code></summary>

- **Depends:** <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcrypt1"><code>libcrypt1 (&gt;= 1:4.3.0)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>

</details>

<details>
<summary id="core2-package-libpam-runtime"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111">libpam-runtime 1.5.2-6+deb12u2</a></code></summary>

- **Depends:** one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>; one of: <code>debconf (&gt;= 1.5.19)</code> <em>(Debian Bookworm)</em> | <code>cdebconf</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpam-modules"><code>libpam-modules (&gt;= 1.0.1-6)</code></a>

</details>

<details>
<summary id="core2-package-libpam-systemd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">libpam-systemd 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>; <a href="#core2-package-systemd"><code>systemd (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-libpam-runtime"><code>libpam-runtime</code></a>; one of: <code>default-dbus-system-bus</code> <em>(Debian Bookworm)</em> | <code>dbus-system-bus</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-systemd-sysv"><code>systemd-sysv</code></a>

</details>

<details>
<summary id="core2-package-libpam0g"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111">libpam0g 1.5.2-6+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libssl3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-openssl-3.0.22-1-deb12u1-core2.1-20261011040326">libssl3 3.0.22-1~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libsubid4"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822">libsubid4 1:4.13+dfsg1-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <a href="#core2-package-libcrypt1"><code>libcrypt1 (&gt;= 1:4.1.0)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libsemanage2"><code>libsemanage2 (&gt;= 2.0.32)</code></a>

</details>

<details>
<summary id="core2-package-libsystemd-shared"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">libsystemd-shared 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libacl1"><code>libacl1 (&gt;= 2.2.23)</code></a>; <a href="#core2-package-libapparmor1"><code>libapparmor1 (&gt;= 2.13)</code></a>; <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <code>libblkid1 (&gt;= 2.24)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-libcrypt1"><code>libcrypt1 (&gt;= 1:4.4.0)</code></a>; <a href="#core2-package-libgcrypt20"><code>libgcrypt20 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-libip4tc2"><code>libip4tc2 (&gt;= 1.8.3)</code></a>; <a href="#core2-package-libkmod2"><code>libkmod2 (&gt;= 15)</code></a>; <a href="#core2-package-liblz4-1"><code>liblz4-1 (&gt;= 0.0~r130)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <code>libmount1 (&gt;= 2.30)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>; <a href="#core2-package-libseccomp2"><code>libseccomp2 (&gt;= 2.4.1)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>

</details>

<details>
<summary id="core2-package-libsystemd0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">libsystemd0 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-libgcrypt20"><code>libgcrypt20 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-liblz4-1"><code>liblz4-1 (&gt;= 0.0~r122)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>

</details>

<details>
<summary id="core2-package-libudev1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">libudev1 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libzstd1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libzstd-1.5.4-dfsg2-5-core2.1-20261020161546">libzstd1 1.5.4+dfsg2-5 — fast lossless compression algorithm</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-locales"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">locales 2.36-9+deb12u14</a></code></summary>

- **Depends:** <a href="#core2-package-libc-bin"><code>libc-bin (&gt;&gt; 2.36)</code></a>; <a href="#core2-package-libc-l10n"><code>libc-l10n (&gt;&gt; 2.36)</code></a>; one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-locales-all"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">locales-all 2.36-9+deb12u14</a></code></summary>

- **Depends:** <a href="#core2-package-libc-l10n"><code>libc-l10n (&gt;&gt; 2.36)</code></a>

</details>

<details>
<summary id="core2-package-login"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822">login 1:4.13+dfsg1-1+deb12u2</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcrypt1"><code>libcrypt1 (&gt;= 1:4.1.0)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>; <a href="#core2-package-libpam-runtime"><code>libpam-runtime</code></a>; <a href="#core2-package-libpam-modules"><code>libpam-modules</code></a>

</details>

<details>
<summary id="core2-package-nscd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854">nscd 2.36-9+deb12u14</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.54~)</code> <em>(Debian Bookworm)</em>
- **Depends:** <code>lsb-base (&gt;= 3.0-6)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;&gt; 2.36)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&lt;&lt; 2.37), libcap2 (&gt;= 1:2.10), libselinux1 (&gt;= 3.1~)</code></a>

</details>

<details>
<summary id="core2-package-openssl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-openssl-3.0.22-1-deb12u1-core2.1-20261011040326">openssl 3.0.22-1~deb12u1 — Secure Sockets Layer toolkit - cryptographic utility</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.9)</code></a>

</details>

<details>
<summary id="core2-package-passwd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822">passwd 1:4.13+dfsg1-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <a href="#core2-package-libcrypt1"><code>libcrypt1 (&gt;= 1:4.1.0)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libsemanage2"><code>libsemanage2 (&gt;= 2.0.32)</code></a>; <a href="#core2-package-libpam-modules"><code>libpam-modules</code></a>

</details>

<details>
<summary id="core2-package-sed"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-sed-4.9-1-deb12u1-core2.1-20261009191427">sed 4.9-1+deb12u1 — GNU stream editor for filtering/transforming text</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libacl1"><code>libacl1 (&gt;= 2.2.23)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>

</details>

<details>
<summary id="core2-package-systemd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd 252.39-1~deb12u2 — system and service manager</a></code></summary>

- **Pre-Depends:** <code>libblkid1 (&gt;= 2.24)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-libgcrypt20"><code>libgcrypt20 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-liblz4-1"><code>liblz4-1 (&gt;= 0.0~r122)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <code>libmount1 (&gt;= 2.30)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>
- **Depends:** <a href="#core2-package-libacl1"><code>libacl1 (&gt;= 2.2.23)</code></a>; <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <code>libblkid1 (&gt;= 2.24.2)</code> <em>(Debian Bookworm)</em>; <code>libcryptsetup12 (&gt;= 2:2.4)</code> <em>(Debian Bookworm)</em>; <code>libfdisk1 (&gt;= 2.33)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libkmod2"><code>libkmod2 (&gt;= 15)</code></a>; <a href="#core2-package-libp11-kit0"><code>libp11-kit0 (&gt;= 0.23.18.1)</code></a>; <a href="#core2-package-libseccomp2"><code>libseccomp2 (&gt;= 2.3.1)</code></a>; <a href="#core2-package-libsystemd-shared"><code>libsystemd-shared (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0 (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <code>mount</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-systemd-boot"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-boot 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libsystemd-shared"><code>libsystemd-shared (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-systemd-boot-efi"><code>systemd-boot-efi (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-systemd-boot-efi"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-boot-efi 252.39-1~deb12u2</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-systemd-container"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-container 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libacl1"><code>libacl1 (&gt;= 2.2.23)</code></a>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcurl4"><code>libcurl4 (&gt;= 7.16.3)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-libseccomp2"><code>libseccomp2 (&gt;= 2.3.1)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libsystemd-shared"><code>libsystemd-shared (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <a href="#core2-package-systemd"><code>systemd</code></a>; one of: <code>default-dbus-system-bus</code> <em>(Debian Bookworm)</em> | <code>dbus-system-bus</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-systemd-coredump"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-coredump 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-liblz4-1"><code>liblz4-1 (&gt;= 0.0~r130)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-libsystemd-shared"><code>libsystemd-shared (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-systemd"><code>systemd</code></a>

</details>

<details>
<summary id="core2-package-systemd-homed"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-homed 252.39-1~deb12u2</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.64~)</code> <em>(Debian Bookworm)</em>
- **Depends:** <code>libblkid1 (&gt;= 2.24)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <code>libfdisk1 (&gt;= 2.33)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libp11-kit0"><code>libp11-kit0 (&gt;= 0.23.18.1)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 1.1.1)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libsystemd-shared"><code>libsystemd-shared (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-systemd-userdbd"><code>systemd-userdbd (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-systemd"><code>systemd (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-libpam-runtime"><code>libpam-runtime</code></a>

</details>

<details>
<summary id="core2-package-systemd-journal-remote"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-journal-remote 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcurl4"><code>libcurl4 (&gt;= 7.16.2)</code></a>; <code>libmicrohttpd12 (&gt;= 0.9.50)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsystemd-shared"><code>libsystemd-shared (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-systemd"><code>systemd</code></a>

</details>

<details>
<summary id="core2-package-systemd-oomd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-oomd 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libsystemd-shared"><code>libsystemd-shared (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; one of: <a href="#core2-package-systemd"><code>systemd</code></a> | <a href="#core2-package-systemd-standalone-sysusers"><code>systemd-standalone-sysusers</code></a> | <code>systemd-sysusers</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-systemd-resolved"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-resolved 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libsystemd-shared"><code>libsystemd-shared (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-systemd"><code>systemd (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; one of: <code>default-dbus-system-bus</code> <em>(Debian Bookworm)</em> | <code>dbus-system-bus</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-systemd-standalone-sysusers"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-standalone-sysusers 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-libcrypt1"><code>libcrypt1 (&gt;= 1:4.4.0)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>

</details>

<details>
<summary id="core2-package-systemd-standalone-tmpfiles"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-standalone-tmpfiles 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libacl1"><code>libacl1 (&gt;= 2.2.23)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>

</details>

<details>
<summary id="core2-package-systemd-sysv"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-sysv 252.39-1~deb12u2</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-systemd"><code>systemd</code></a>

</details>

<details>
<summary id="core2-package-systemd-tests"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-tests 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libacl1"><code>libacl1 (&gt;= 2.2.23)</code></a>; <code>libblkid1 (&gt;= 2.37.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-libcrypt1"><code>libcrypt1 (&gt;= 1:4.4.0)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <a href="#core2-package-libgcrypt20"><code>libgcrypt20 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.26.0)</code></a>; <a href="#core2-package-libkmod2"><code>libkmod2 (&gt;= 15)</code></a>; <a href="#core2-package-liblz4-1"><code>liblz4-1 (&gt;= 0.0~r130)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <code>libmount1 (&gt;= 2.30)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libseccomp2"><code>libseccomp2 (&gt;= 2.3.1)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libsystemd-shared"><code>libsystemd-shared (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0 (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-libudev1"><code>libudev1 (&gt;= 247)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <a href="#core2-package-systemd"><code>systemd (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <code>python3</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-systemd-timesyncd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-timesyncd 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libsystemd-shared"><code>libsystemd-shared (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-systemd"><code>systemd</code></a>

</details>

<details>
<summary id="core2-package-systemd-userdbd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">systemd-userdbd 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libsystemd-shared"><code>libsystemd-shared (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-systemd"><code>systemd (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-tar"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-tar-1.34-dfsg-1.2-deb12u1-core2.1-20261009152714">tar 1.34+dfsg-1.2+deb12u1 — GNU version of the tar archiving utility</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libacl1"><code>libacl1 (&gt;= 2.2.23)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>

</details>

<details>
<summary id="core2-package-tar-scripts"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-tar-1.34-dfsg-1.2-deb12u1-core2.1-20261009152714">tar-scripts 1.34+dfsg-1.2+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-tar"><code>tar (&gt;= 1.26+dfsg-9)</code></a>

</details>

<details>
<summary id="core2-package-udev"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144">udev 252.39-1~deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libacl1"><code>libacl1 (&gt;= 2.2.23)</code></a>; <code>libblkid1 (&gt;= 2.37.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-libkmod2"><code>libkmod2 (&gt;= 15)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <code>adduser</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libudev1"><code>libudev1 (= 252.39-1~deb12u2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-udhcpc"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-busybox-1-1.35.0-4-deb12u1-core2.1-20261012093022">udhcpc 1:1.35.0-4+deb12u1</a></code></summary>

- **Depends:** one of: <a href="#core2-package-busybox"><code>busybox (&gt;&gt; 1:1.35.0)</code></a> | <a href="#core2-package-busybox-static"><code>busybox-static (&gt;&gt; 1:1.35.0)</code></a>

</details>

<details>
<summary id="core2-package-udhcpd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-busybox-1-1.35.0-4-deb12u1-core2.1-20261012093022">udhcpd 1:1.35.0-4+deb12u1</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.54~)</code> <em>(Debian Bookworm)</em>
- **Depends:** one of: <a href="#core2-package-busybox"><code>busybox (&gt;&gt; 1:1.35.0)</code></a> | <a href="#core2-package-busybox-static"><code>busybox-static (&gt;&gt; 1:1.35.0)</code></a>; <code>lsb-base</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-uidmap"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822">uidmap 1:4.13+dfsg1-1+deb12u2 — programs to help use subuids</a></code></summary>

- **Depends:** <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libsubid4"><code>libsubid4 (&gt;= 1:4.11.1)</code></a>

</details>

<details>
<summary id="core2-package-xz-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709">xz-utils 5.4.1-1+deb12u2 — XZ-format compression utilities</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.4.0)</code></a>

</details>

<details>
<summary id="core2-package-xzdec"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709">xzdec 5.4.1-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-zstd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libzstd-1.5.4-dfsg2-5-core2.1-20261020161546">zstd 1.5.4+dfsg2-5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liblz4-1"><code>liblz4-1 (&gt;= 1.8.0)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <code>libstdc++6 (&gt;= 12)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

</details>

<details>
<summary>Applications &amp; utilities (496 packages)</summary>

<details>
<summary id="core2-package-7zip"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-7zip-22.01-really26.02-dfsg-0-deb12u1-core2.1-20261009183500">7zip 22.01+really26.02+dfsg-0+deb12u1 — 7-Zip file archiver with a high compression ratio</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-acl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-acl-2.3.1-3-core2.1-20261009190907">acl 2.3.1-3 — access control list - utilities</a></code></summary>

- **Depends:** <a href="#core2-package-libacl1"><code>libacl1 (= 2.3.1-3+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-adwaita-icon-theme"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-adwaita-icon-theme-43-1-core2.1-20261020155234">adwaita-icon-theme 43-1 — default icon theme of GNOME</a></code></summary>

- **Depends:** <a href="#core2-package-hicolor-icon-theme"><code>hicolor-icon-theme</code></a>; <a href="#core2-package-gtk-update-icon-cache"><code>gtk-update-icon-cache</code></a>

</details>

<details>
<summary id="core2-package-aom-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-aom-3.6.0-1-deb12u3-core2.1-20261016144330">aom-tools 3.6.0-1+deb12u3 — AV1 Video Codec Library -- Tools</a></code></summary>

- **Depends:** <a href="#core2-package-libaom3"><code>libaom3 (&gt;= 3.2.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5.2)</code> <em>(Debian Bookworm)</em>; <code>libyuv0 (&gt;= 0.0~git20221206)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-apparmor"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-apparmor-3.0.8-3-core2.1-20261020155241">apparmor 3.0.8-3 — user-space parser utility for AppArmor</a></code></summary>

- **Depends:** <code>debconf</code> <em>(Debian Bookworm)</em>; one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>

</details>

<details>
<summary id="core2-package-apparmor-notify"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-apparmor-3.0.8-3-core2.1-20261020155241">apparmor-notify 3.0.8-3</a></code></summary>

- **Depends:** <a href="#core2-package-python3-apparmor"><code>python3-apparmor</code></a>; <a href="#core2-package-python3-libapparmor"><code>python3-libapparmor</code></a>; <code>python3-notify2</code> <em>(Debian Bookworm)</em>; <code>python3-psutil</code> <em>(Debian Bookworm)</em>; <code>python3:any</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-apparmor-profiles"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-apparmor-3.0.8-3-core2.1-20261020155241">apparmor-profiles 3.0.8-3</a></code></summary>

- **Depends:** <a href="#core2-package-apparmor"><code>apparmor</code></a>

</details>

<details>
<summary id="core2-package-apparmor-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-apparmor-3.0.8-3-core2.1-20261020155241">apparmor-utils 3.0.8-3</a></code></summary>

- **Depends:** <a href="#core2-package-apparmor"><code>apparmor</code></a>; <a href="#core2-package-python3-apparmor"><code>python3-apparmor (= 3.0.8-3+core2.1~BUILD)</code></a>; <code>python3:any</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-apvlv"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-apvlv-0.4.0-repack-1-core2.1-20261012055524">apvlv 0.4.0+repack-1 — PDF viewer with Vim-like behaviour</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.6.0)</code></a>; <a href="#core2-package-libepub0"><code>libepub0 (&gt;= 0.1.1)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.35.9)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.21.5)</code></a>; <code>libjavascriptcoregtk-4.0-18</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libpoppler-glib8"><code>libpoppler-glib8 (&gt;= 0.26.0)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <code>libwebkit2gtk-4.0-37 (&gt;= 2.5.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>

</details>

<details>
<summary id="core2-package-argon2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-argon2-0-20171227-0.3-deb12u1-core2.1-20261020155240">argon2 0~20171227-0.3+deb12u1 — memory-hard hashing function - utility</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-arj"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-arj-3.10.22-26-core2.1-20261012055158">arj 3.10.22-26 — archiver for .arj files</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-aspell"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-aspell-0.60.8-4-core2.1-20261012055250">aspell 0.60.8-4 — GNU Aspell spell-checker</a></code></summary>

- **Depends:** <a href="#core2-package-libaspell15"><code>libaspell15 (= 0.60.8-4+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libncursesw6"><code>libncursesw6 (&gt;= 6)</code></a>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>; <code>dictionaries-common</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-at-spi2-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253">at-spi2-common 2.46.0-5</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-at-spi2-core"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253">at-spi2-core 2.46.0-5 — Assistive Technology Service Provider Interface (D-Bus core)</a></code></summary>

- **Depends:** <a href="#core2-package-libatspi2.0-0"><code>libatspi2.0-0 (&gt;= 2.9.90)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.4)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <code>libxtst6</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-at-spi2-common"><code>at-spi2-common</code></a>; <code>gsettings-desktop-schemas</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-atril"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510">atril 1.26.0-2+deb12u4 — MATE document viewer</a></code></summary>

- **Depends:** <a href="#core2-package-atril-common"><code>atril-common (&gt;= 1.26.0-2+deb12u4+core2.1~BUILD)</code></a>; <a href="#core2-package-libatrildocument3"><code>libatrildocument3 (= 1.26.0-2+deb12u4+core2.1~BUILD)</code></a>; <a href="#core2-package-libatrilview3"><code>libatrilview3 (= 1.26.0-2+deb12u4+core2.1~BUILD)</code></a>; <a href="#core2-package-shared-mime-info"><code>shared-mime-info</code></a>; one of: <a href="#core2-package-dconf-gsettings-backend"><code>dconf-gsettings-backend</code></a> | <code>gsettings-backend</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 1.12.4)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libcaja-extension1 (&gt;= 1.18)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.61.2)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.21.5)</code></a>; <code>libice6 (&gt;= 1:1.0.0)</code> <em>(Debian Bookworm)</em>; <code>libsecret-1-0 (&gt;= 0.7)</code> <em>(Debian Bookworm)</em>; <code>libsm6</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>

</details>

<details>
<summary id="core2-package-atril-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510">atril-common 1.26.0-2+deb12u4</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-attr"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-attr-1-2.5.1-4-core2.1-20261009191027">attr 1:2.5.1-4 — utilities for manipulating filesystem extended attributes</a></code></summary>

- **Depends:** <a href="#core2-package-libattr1"><code>libattr1 (= 1:2.5.1-4+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-audispd-plugins"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-audit-1-3.0.9-1-core2.1-20261020155244">audispd-plugins 1:3.0.9-1</a></code></summary>

- **Depends:** <a href="#core2-package-auditd"><code>auditd (= 1:3.0.9-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libauparse0"><code>libauparse0 (= 1:3.0.9-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap-ng0"><code>libcap-ng0 (&gt;= 0.7.9)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (&gt;= 1.6.dfsg.2)</code></a>; <code>libldap-2.5-0 (&gt;= 2.5.4)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-auditd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-audit-1-3.0.9-1-core2.1-20261020155244">auditd 1:3.0.9-1</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.54~)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-libaudit1"><code>libaudit1 (= 1:3.0.9-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libauparse0"><code>libauparse0 (= 1:3.0.9-1+core2.1~BUILD)</code></a>; one of: <code>mawk</code> <em>(Debian Bookworm)</em> | <a href="#core2-package-gawk"><code>gawk</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap-ng0"><code>libcap-ng0 (&gt;= 0.7.9)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (&gt;= 1.6.dfsg.2)</code></a>; <code>libwrap0 (&gt;= 7.6-4~)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-avahi-autoipd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">avahi-autoipd 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libdaemon0 (&gt;= 0.14)</code> <em>(Debian Bookworm)</em>; <code>adduser</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-avahi-daemon"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">avahi-daemon 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavahi-core7"><code>libavahi-core7 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <code>libdaemon0 (&gt;= 0.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.0.1)</code></a>; <code>adduser</code> <em>(Debian Bookworm)</em>; one of: <code>default-dbus-system-bus</code> <em>(Debian Bookworm)</em> | <code>dbus-system-bus</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-avahi-discover"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">avahi-discover 0.8-10+deb12u1</a></code></summary>

- **Depends:** <code>python3:any</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-python3-avahi"><code>python3-avahi (&gt;= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <code>python3-dbus</code> <em>(Debian Bookworm)</em>; <code>python3-gi</code> <em>(Debian Bookworm)</em>; <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-gtk-3.0"><code>gir1.2-gtk-3.0</code></a>; <a href="#core2-package-avahi-daemon"><code>avahi-daemon (&gt;= 0.8-10+deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-avahi-dnsconfd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">avahi-dnsconfd 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libdaemon0 (&gt;= 0.10)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-avahi-daemon"><code>avahi-daemon (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-avahi-ui-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">avahi-ui-utils 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavahi-client3"><code>libavahi-client3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavahi-ui-gtk3-0"><code>libavahi-ui-gtk3-0 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.12.0)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.0.0)</code></a>

</details>

<details>
<summary id="core2-package-avahi-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">avahi-utils 0.8-10+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libavahi-client3"><code>libavahi-client3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgdbm6"><code>libgdbm6 (&gt;= 1.16)</code></a>; <a href="#core2-package-avahi-daemon"><code>avahi-daemon (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-brotli"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-brotli-1.0.9-2-core2.1-20261016150736">brotli 1.0.9-2 — lossless compression algorithm and format (command line utility)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-btop"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-btop-1.2.13-1-core2.1-20261009120005">btop 1.2.13-1 — Modern and colorful command line resource monitor that shows usage and stats</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.3.1)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 12)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-catdvi"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-catdvi-0.14-14-core2.1-20261012055215">catdvi 0.14-14 — DVI to plain text translator</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libkpathsea6"><code>libkpathsea6 (&gt;= 2022.20220321.62855)</code></a>; <code>texlive-base</code> <em>(Debian Bookworm)</em>; <code>texlive-base-bin</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-colord"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-colord-1.4.6-2.2-core2.1-20261020155348">colord 1.4.6-2.2 — system service to manage device colour profiles -- system daemon</a></code></summary>

- **Depends:** <a href="#core2-package-acl"><code>acl</code></a>; <code>adduser</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-colord-data"><code>colord-data</code></a>; one of: <code>polkitd</code> <em>(Debian Bookworm)</em> | <code>policykit-1 (&gt;= 0.103)</code> <em>(Debian Bookworm)</em>; one of: <a href="#core2-package-dconf-gsettings-backend"><code>dconf-gsettings-backend</code></a> | <code>gsettings-backend</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcolord2"><code>libcolord2 (&gt;= 1.4.3)</code></a>; <a href="#core2-package-libcolorhug2"><code>libcolorhug2 (&gt;= 0.1.30)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.58)</code></a>; <code>libgudev-1.0-0 (&gt;= 146)</code> <em>(Debian Bookworm)</em>; <code>libgusb2 (&gt;= 0.2.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.2+git20110628)</code></a>; <code>libpolkit-gobject-1-0 (&gt;= 0.103)</code> <em>(Debian Bookworm)</em>; <code>libsane1 (&gt;= 1.0.27)</code> <em>(Debian Bookworm)</em>; <code>libsqlite3-0 (&gt;= 3.5.9)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>

</details>

<details>
<summary id="core2-package-colord-data"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-colord-1.4.6-2.2-core2.1-20261020155348">colord-data 1.4.6-2.2</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-colord-sensor-argyll"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-colord-1.4.6-2.2-core2.1-20261020155348">colord-sensor-argyll 1.4.6-2.2</a></code></summary>

- **Depends:** <code>argyll</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-colord"><code>colord</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.28)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.58)</code></a>

</details>

<details>
<summary id="core2-package-colord-tests"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-colord-1.4.6-2.2-core2.1-20261020155348">colord-tests 1.4.6-2.2</a></code></summary>

- **Depends:** <a href="#core2-package-colord"><code>colord</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcolord2"><code>libcolord2 (&gt;= 1.4.3)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.58)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.2+git20110628)</code></a>

</details>

<details>
<summary id="core2-package-cups"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438">cups 2.4.2-3+deb12u9 — Common UNIX Printing System(tm) - PPD/driver support, web interface</a></code></summary>

- **Depends:** <a href="#core2-package-cups-client"><code>cups-client (&gt;= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-cups-common"><code>cups-common (&gt;= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-cups-core-drivers"><code>cups-core-drivers (&gt;= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-cups-daemon"><code>cups-daemon (&gt;= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <code>cups-filters</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-cups-ppdc"><code>cups-ppdc</code></a>; <a href="#core2-package-cups-server-common"><code>cups-server-common (&gt;= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>; <code>ghostscript</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libcups2"><code>libcups2 (= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-poppler-utils"><code>poppler-utils</code></a>; <code>procps</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libavahi-client3"><code>libavahi-client3 (&gt;= 0.6.16)</code></a>; <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (&gt;= 0.6.16)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <code>libusb-1.0-0 (&gt;= 2:1.0.16)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-cups-bsd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438">cups-bsd 2.4.2-3+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-cups-client"><code>cups-client (= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-cups-common"><code>cups-common (&gt;= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libcups2"><code>libcups2 (= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-cups-client"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438">cups-client 2.4.2-3+deb12u9</a></code></summary>

- **Depends:** <code>adduser</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-cups-common"><code>cups-common (&gt;= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libcups2"><code>libcups2 (= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-cups-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438">cups-common 2.4.2-3+deb12u9</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-cups-core-drivers"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438">cups-core-drivers 2.4.2-3+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-cups-daemon"><code>cups-daemon (&gt;= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <code>cups-filters-core-drivers</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libcups2"><code>libcups2 (= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-cups-daemon"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438">cups-daemon 2.4.2-3+deb12u9</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.54~)</code> <em>(Debian Bookworm)</em>
- **Depends:** <code>adduser</code> <em>(Debian Bookworm)</em>; <code>bc</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libcups2"><code>libcups2 (= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <code>lsb-base</code> <em>(Debian Bookworm)</em>; <code>procps</code> <em>(Debian Bookworm)</em>; <code>ssl-cert</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libavahi-client3"><code>libavahi-client3 (&gt;= 0.6.16)</code></a>; <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (&gt;= 0.6.16)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>; <code>libpaper1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>

</details>

<details>
<summary id="core2-package-cups-ipp-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438">cups-ipp-utils 2.4.2-3+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-libcups2"><code>libcups2 (= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libavahi-client3"><code>libavahi-client3 (&gt;= 0.6.16)</code></a>; <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (&gt;= 0.6.16)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>

</details>

<details>
<summary id="core2-package-cups-ppdc"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438">cups-ppdc 2.4.2-3+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-cups-common"><code>cups-common (&gt;= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcups2"><code>libcups2 (&gt;= 2.3~b6)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-cups-server-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438">cups-server-common 2.4.2-3+deb12u9</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-curl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528">curl 7.88.1-10+deb12u15 — command line tool for transferring data with URL syntax</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcurl4"><code>libcurl4 (= 7.88.1-10+deb12u15+core2.1~BUILD)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-dav1d"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dav1d-1.0.0-2-deb12u1-core2.1-20261016144008">dav1d 1.0.0-2+deb12u1 — fast and small AV1 video stream decoder</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdav1d6"><code>libdav1d6 (&gt;= 0.1.0)</code></a>

</details>

<details>
<summary id="core2-package-db5.3-sql-util"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531">db5.3-sql-util 5.3.28+dfsg2-1 — Berkeley v5.3 SQL Database Utilities</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdb5.3-sql"><code>libdb5.3-sql</code></a>; <a href="#core2-package-libdb5.3"><code>libdb5.3 (= 5.3.28+dfsg2-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-db5.3-util"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531">db5.3-util 5.3.28+dfsg2-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdb5.3"><code>libdb5.3 (= 5.3.28+dfsg2-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-dbus"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524">dbus 1.14.10-1~deb12u1 — simple interprocess messaging system (system message bus)</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.54~)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-dbus-bin"><code>dbus-bin (= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-dbus-daemon"><code>dbus-daemon (= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-dbus-system-bus-common"><code>dbus-system-bus-common (&gt;= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.1~beta3)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>

</details>

<details>
<summary id="core2-package-dbus-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524">dbus-bin 1.14.10-1~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-dbus-daemon"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524">dbus-daemon 1.14.10-1~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-dbus-bin"><code>dbus-bin (= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-dbus-session-bus-common"><code>dbus-session-bus-common (&gt;= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libapparmor1"><code>libapparmor1 (&gt;= 2.8.94)</code></a>; <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap-ng0"><code>libcap-ng0 (&gt;= 0.7.9)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.1~beta3)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>

</details>

<details>
<summary id="core2-package-dbus-session-bus-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524">dbus-session-bus-common 1.14.10-1~deb12u1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-dbus-system-bus-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524">dbus-system-bus-common 1.14.10-1~deb12u1</a></code></summary>

- **Depends:** <code>adduser</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-dbus-tests"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524">dbus-tests 1.14.10-1~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-dbus"><code>dbus</code></a>; <a href="#core2-package-libapparmor1"><code>libapparmor1 (&gt;= 2.10)</code></a>; <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap-ng0"><code>libcap-ng0 (&gt;= 0.7.9)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.1~beta3)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.37.6)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>

</details>

<details>
<summary id="core2-package-dbus-user-session"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524">dbus-user-session 1.14.10-1~deb12u1</a></code></summary>

- **Depends:** one of: <a href="#core2-package-dbus-daemon"><code>dbus-daemon (= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a> | <code>dbus-broker</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-dbus-session-bus-common"><code>dbus-session-bus-common (&gt;= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libpam-systemd"><code>libpam-systemd</code></a>; <a href="#core2-package-systemd"><code>systemd</code></a>

</details>

<details>
<summary id="core2-package-dbus-x11"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524">dbus-x11 1.14.10-1~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-dbus-bin"><code>dbus-bin (= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-dbus-daemon"><code>dbus-daemon (= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-dbus-session-bus-common"><code>dbus-session-bus-common (&gt;= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (= 1.14.10-1~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>

</details>

<details>
<summary id="core2-package-dbview"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dbview-1.0.4-5-core2.1-20261012055207">dbview 1.0.4-5 — view dBase III files</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-dconf-cli"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dconf-0.40.0-4-core2.1-20261020155533">dconf-cli 0.40.0-4 — simple configuration storage system - utilities</a></code></summary>

- **Depends:** <a href="#core2-package-libdconf1"><code>libdconf1 (= 0.40.0-4+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.44.0)</code></a>

</details>

<details>
<summary id="core2-package-dconf-gsettings-backend"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dconf-0.40.0-4-core2.1-20261020155533">dconf-gsettings-backend 0.40.0-4</a></code></summary>

- **Depends:** <a href="#core2-package-dconf-service"><code>dconf-service (&lt;&lt; 0.40.0-4+core2.1~BUILD.1~), dconf-service (&gt;= 0.40.0-4+core2.1~BUILD), libdconf1 (= 0.40.0-4+core2.1~BUILD), libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>

</details>

<details>
<summary id="core2-package-dconf-service"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dconf-0.40.0-4-core2.1-20261020155533">dconf-service 0.40.0-4</a></code></summary>

- **Depends:** one of: <code>default-dbus-session-bus</code> <em>(Debian Bookworm)</em> | <code>dbus-session-bus</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdconf1"><code>libdconf1 (= 0.40.0-4+core2.1~BUILD)</code></a>; <code>procps</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>

</details>

<details>
<summary id="core2-package-dh-apparmor"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-apparmor-3.0.8-3-core2.1-20261020155241">dh-apparmor 3.0.8-3</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-diffutils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-diffutils-1-3.8-4-core2.1-20261009191615">diffutils 1:3.8-4 — File comparison utilities</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-djview"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223">djview 3.5.28-2.2~deb12u1</a></code></summary>

- **Depends:** one of: <code>djview4</code> <em>(Debian Bookworm)</em> | <a href="#core2-package-djview3"><code>djview3</code></a>

</details>

<details>
<summary id="core2-package-djview3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223">djview3 3.5.28-2.2~deb12u1 — Transition package, djview3 to djview4</a></code></summary>

- **Depends:** <code>djview4</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-djvulibre-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223">djvulibre-bin 3.5.28-2.2~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdjvulibre21"><code>libdjvulibre21 (= 3.5.28-2.2~deb12u1+core2.1~BUILD)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.0.3)</code></a>; <a href="#core2-package-curl"><code>curl</code></a>

</details>

<details>
<summary id="core2-package-djvulibre-desktop"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223">djvulibre-desktop 3.5.28-2.2~deb12u1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-djvuserve"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223">djvuserve 3.5.28-2.2~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdjvulibre21"><code>libdjvulibre21 (&gt;= 3.5.28)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-e2fsck-static"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320">e2fsck-static 1.47.0-2</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-e2fsprogs"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320">e2fsprogs 1.47.0-2 — ext2/ext3/ext4 file system utilities</a></code></summary>

- **Pre-Depends:** <code>libblkid1 (&gt;= 2.36)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libext2fs2"><code>libext2fs2 (= 1.47.0-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libss2"><code>libss2 (&gt;= 1.38)</code></a>; <code>libuuid1 (&gt;= 2.16)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-logsave"><code>logsave</code></a>

</details>

<details>
<summary id="core2-package-e2fsprogs-l10n"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320">e2fsprogs-l10n 1.47.0-2</a></code></summary>

- **Depends:** <a href="#core2-package-e2fsprogs"><code>e2fsprogs (&gt;= 1.47.0-2+core2.1~BUILD)</code></a>; <a href="#core2-package-e2fsprogs"><code>e2fsprogs (&lt;&lt; 1.47.0-2+core2.1~BUILD+c~)</code></a>

</details>

<details>
<summary id="core2-package-epub-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ebook-tools-0.2.2-6-core2.1-20261012055224">epub-utils 0.2.2-6 — tools to work with the EPUB file format</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libepub0"><code>libepub0 (= 0.2.2-6+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-evince"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-evince-43.1-2-deb12u1-core2.1-20261012055507">evince 43.1-2+deb12u1 — Document (PostScript, PDF) viewer</a></code></summary>

- **Depends:** <a href="#core2-package-evince-common"><code>evince-common (&gt;= 43.1-2+deb12u1+core2.1~BUILD)</code></a>; <code>gsettings-desktop-schemas</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libevdocument3-4"><code>libevdocument3-4 (= 43.1-2+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libevview3-3"><code>libevview3-3 (= 43.1-2+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-shared-mime-info"><code>shared-mime-info</code></a>; one of: <a href="#core2-package-dconf-gsettings-backend"><code>dconf-gsettings-backend</code></a> | <code>gsettings-backend</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 1.12.4)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo-gobject2"><code>libcairo-gobject2 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.40)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.61.2)</code></a>; <code>libgnome-desktop-3-20 (&gt;= 3.17.92)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.22.0)</code></a>; <code>libhandy-1-0 (&gt;= 1.5.90)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.37.5)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (&gt;= 1.14.0)</code></a>; <code>libsecret-1-0 (&gt;= 0.7)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-evince-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-evince-43.1-2-deb12u1-core2.1-20261012055507">evince-common 43.1-2+deb12u1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-exo-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-exo-4.18.0-1-core2.1-20261010053936">exo-utils 4.18.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libexo-2-0"><code>libexo-2-0 (= 4.18.0-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.65.1)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.21.4)</code></a>; <a href="#core2-package-libxfce4ui-2-0"><code>libxfce4ui-2-0 (&gt;= 4.15.1)</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.17.2)</code></a>

</details>

<details>
<summary id="core2-package-expat"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-expat-2.5.0-1-deb12u4-core2.1-20261016150748">expat 2.5.0-1+deb12u4 — XML parsing C library - example application</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.5.0-1+deb12u4+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-feh"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-feh-3.9.1-2-core2.1-20261020171043">feh 3.9.1-2 — imlib2 based image viewer</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcurl4"><code>libcurl4 (&gt;= 7.16.2)</code></a>; <code>libexif12 (&gt;= 0.6.21-1~)</code> <em>(Debian Bookworm)</em>; <code>libimlib2 (&gt;= 1.4.5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxinerama1"><code>libxinerama1 (&gt;= 2:1.1.4)</code></a>; <code>yudit-common</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-file"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-file-1-5.44-3-core2.1-20261012055237">file 1:5.44-3 — Recognize the type of data in a file using "magic" numbers</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libmagic1"><code>libmagic1 (= 1:5.44-3+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-findutils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-findutils-4.9.0-4-core2.1-20261009164357">findutils 4.9.0-4 — utilities for finding files--find, xargs</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>

</details>

<details>
<summary id="core2-package-fontconfig"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fontconfig-2.14.1-4-core2.1-20261016150850">fontconfig 2.14.1-4 — generic font configuration library - support binaries</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.13.0)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-fontconfig-config"><code>fontconfig-config</code></a>

</details>

<details>
<summary id="core2-package-fontconfig-config"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fontconfig-2.14.1-4-core2.1-20261016150850">fontconfig-config 2.14.1-4</a></code></summary>

- **Depends:** one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>; one of: <a href="#core2-package-fonts-dejavu-core"><code>fonts-dejavu-core</code></a> | <code>ttf-bitstream-vera</code> <em>(Debian Bookworm)</em> | <code>fonts-liberation</code> <em>(Debian Bookworm)</em> | <code>fonts-liberation2</code> <em>(Debian Bookworm)</em> | <code>fonts-croscore</code> <em>(Debian Bookworm)</em> | <code>fonts-freefont-otf</code> <em>(Debian Bookworm)</em> | <code>fonts-freefont-ttf</code> <em>(Debian Bookworm)</em> | <code>fonts-urw-base35</code> <em>(Debian Bookworm)</em> | <code>fonts-texgyre</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-fonts-dejavu"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fonts-dejavu-2.37-6-core2.1-20261016150744">fonts-dejavu 2.37-6 — metapackage to pull in fonts-dejavu-core and fonts-dejavu-extra</a></code></summary>

- **Depends:** <a href="#core2-package-fonts-dejavu-core"><code>fonts-dejavu-core</code></a>; <a href="#core2-package-fonts-dejavu-extra"><code>fonts-dejavu-extra</code></a>

</details>

<details>
<summary id="core2-package-fonts-dejavu-core"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fonts-dejavu-2.37-6-core2.1-20261016150744">fonts-dejavu-core 2.37-6</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-fonts-dejavu-extra"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fonts-dejavu-2.37-6-core2.1-20261016150744">fonts-dejavu-extra 2.37-6</a></code></summary>

- **Depends:** <a href="#core2-package-fonts-dejavu-core"><code>fonts-dejavu-core</code></a>

</details>

<details>
<summary id="core2-package-fonts-dejavu-web"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fonts-dejavu-2.37-6-core2.1-20261016150744">fonts-dejavu-web 2.37-6</a></code></summary>

- **Depends:** <a href="#core2-package-fonts-dejavu"><code>fonts-dejavu</code></a>

</details>

<details>
<summary id="core2-package-freetype2-demos"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-freetype-2.12.1-dfsg-5-deb12u4-core2.1-20261016150739">freetype2-demos 2.12.1+dfsg-5+deb12u4 — FreeType 2 demonstration programs</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.10.1)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>

</details>

<details>
<summary id="core2-package-fuse2fs"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320">fuse2fs 1.47.0-2</a></code></summary>

- **Depends:** <code>libblkid1 (&gt;= 2.16)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libext2fs2"><code>libext2fs2 (= 1.47.0-2+core2.1~BUILD)</code></a>; <code>libfuse2 (&gt;= 2.8)</code> <em>(Debian Bookworm)</em>; <code>libuuid1 (&gt;= 2.16)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-gawk"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-gawk-1-5.2.1-2-core2.1-20261009154053">gawk 1:5.2.1-2 — GNU awk, a pattern scanning and processing language</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgmp10"><code>libgmp10 (&gt;= 2:6.2.1+dfsg1)</code></a>; <a href="#core2-package-libmpfr6"><code>libmpfr6 (&gt;= 3.1.3)</code></a>; <a href="#core2-package-libreadline8"><code>libreadline8 (&gt;= 6.0)</code></a>; <code>libsigsegv2 (&gt;= 2.9)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-gdk-pixbuf-tests"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747">gdk-pixbuf-tests 2.42.10+dfsg-1+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (= 2.42.10+dfsg-1+deb12u4+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.56.0)</code></a>

</details>

<details>
<summary id="core2-package-genisoimage"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cdrkit-9-1.1.11-3.4-core2.1-20261012055245">genisoimage 9:1.1.11-3.4</a></code></summary>

- **Depends:** <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libmagic1"><code>libmagic1 (&gt;= 5.12)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-atk-1.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253">gir1.2-atk-1.0 2.46.0-5</a></code></summary>

- **Depends:** <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 2.35.1)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-atrildocument-1.5.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510">gir1.2-atrildocument-1.5.0 1.26.0-2+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-gir1.2-gdkpixbuf-2.0"><code>gir1.2-gdkpixbuf-2.0</code></a>; <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-gtk-3.0"><code>gir1.2-gtk-3.0</code></a>; <a href="#core2-package-libatrildocument3"><code>libatrildocument3 (&gt;= 1.24.0)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-atrilview-1.5.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510">gir1.2-atrilview-1.5.0 1.26.0-2+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-gir1.2-atrildocument-1.5.0"><code>gir1.2-atrildocument-1.5.0 (= 1.26.0-2+deb12u4+core2.1~BUILD)</code></a>; <a href="#core2-package-gir1.2-gdkpixbuf-2.0"><code>gir1.2-gdkpixbuf-2.0</code></a>; <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-gtk-3.0"><code>gir1.2-gtk-3.0</code></a>; <a href="#core2-package-libatrilview3"><code>libatrilview3 (&gt;= 1.20.1)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-atspi-2.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253">gir1.2-atspi-2.0 2.46.0-5</a></code></summary>

- **Depends:** <code>gir1.2-freedesktop</code> <em>(Debian Bookworm)</em>; <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libatspi2.0-0"><code>libatspi2.0-0 (&gt;= 2.46.0-5+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-avahi-0.6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255">gir1.2-avahi-0.6 0.8-10+deb12u1 — GObject introspection data for Avahi</a></code></summary>

- **Depends:** <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libavahi-core7"><code>libavahi-core7 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libavahi-gobject0"><code>libavahi-gobject0 (= 0.8-10+deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-colord-1.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-colord-1.4.6-2.2-core2.1-20261020155348">gir1.2-colord-1.0 1.4.6-2.2</a></code></summary>

- **Depends:** <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libcolord2"><code>libcolord2 (&gt;= 1.4.5)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-colorhug-1.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-colord-1.4.6-2.2-core2.1-20261020155348">gir1.2-colorhug-1.0 1.4.6-2.2</a></code></summary>

- **Depends:** <a href="#core2-package-gir1.2-colord-1.0"><code>gir1.2-colord-1.0 (= 1.4.6-2.2+core2.1~BUILD)</code></a>; <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <code>gir1.2-gusb-1.0 (&gt;= 0.2.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libcolorhug2"><code>libcolorhug2 (&gt;= 1.4.3)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-evince-3.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-evince-43.1-2-deb12u1-core2.1-20261012055507">gir1.2-evince-3.0 43.1-2+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-gir1.2-gdkpixbuf-2.0"><code>gir1.2-gdkpixbuf-2.0 (&gt;= 2.40)</code></a>; <code>gir1.2-glib-2.0 (&gt;= 1.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-gtk-3.0"><code>gir1.2-gtk-3.0 (&gt;= 3.22.0)</code></a>; <a href="#core2-package-libevdocument3-4"><code>libevdocument3-4 (&gt;= 43~alpha)</code></a>; <a href="#core2-package-libevview3-3"><code>libevview3-3 (&gt;= 43~alpha)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-garcon-1.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-garcon-4.18.0-1-core2.1-20261010054213">gir1.2-garcon-1.0 4.18.0-1</a></code></summary>

- **Depends:** <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-libxfce4util-1.0"><code>gir1.2-libxfce4util-1.0</code></a>; <a href="#core2-package-libgarcon-1-0"><code>libgarcon-1-0 (&gt;= 4.17.1)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-garcongtk-1.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-garcon-4.18.0-1-core2.1-20261010054213">gir1.2-garcongtk-1.0 4.18.0-1 — Typelib file for garcon GTK</a></code></summary>

- **Depends:** <a href="#core2-package-gir1.2-garcon-1.0"><code>gir1.2-garcon-1.0 (= 4.18.0-1+core2.1~BUILD)</code></a>; <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-gtk-3.0"><code>gir1.2-gtk-3.0</code></a>; <a href="#core2-package-gir1.2-libxfce4ui-2.0"><code>gir1.2-libxfce4ui-2.0</code></a>; <a href="#core2-package-gir1.2-libxfce4util-1.0"><code>gir1.2-libxfce4util-1.0</code></a>; <a href="#core2-package-libgarcon-gtk3-1-0"><code>libgarcon-gtk3-1-0 (&gt;= 0.7.1)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-gdkpixbuf-2.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747">gir1.2-gdkpixbuf-2.0 2.42.10+dfsg-1+deb12u4 — GDK Pixbuf library - GObject-Introspection</a></code></summary>

- **Depends:** <code>gir1.2-glib-2.0 (&gt;= 0.9.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.39.2)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-gtk-3.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945">gir1.2-gtk-3.0 3.24.38-2~deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-gir1.2-atk-1.0"><code>gir1.2-atk-1.0 (&gt;= 2.35.1)</code></a>; <code>gir1.2-freedesktop (&gt;= 1.39.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-gdkpixbuf-2.0"><code>gir1.2-gdkpixbuf-2.0 (&gt;= 2.40.0)</code></a>; <code>gir1.2-glib-2.0 (&gt;= 1.39.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-pango-1.0"><code>gir1.2-pango-1.0 (&gt;= 1.44.0)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.24.24)</code></a>; <a href="#core2-package-libgtk-3-common"><code>libgtk-3-common</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-harfbuzz-0.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021">gir1.2-harfbuzz-0.0 6.0.0+dfsg-3</a></code></summary>

- **Depends:** <code>gir1.2-freedesktop</code> <em>(Debian Bookworm)</em>; <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-gir1.2-libxfce4ui-2.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651">gir1.2-libxfce4ui-2.0 4.18.2-2</a></code></summary>

- **Depends:** <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-gtk-3.0"><code>gir1.2-gtk-3.0</code></a>; <a href="#core2-package-gir1.2-libxfce4util-1.0"><code>gir1.2-libxfce4util-1.0 (&gt;= 4.17.2)</code></a>; <a href="#core2-package-libxfce4ui-2-0"><code>libxfce4ui-2-0 (&gt;= 4.18.2)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-libxfce4util-1.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4util-4.18.1-2-core2.1-20261010053208">gir1.2-libxfce4util-1.0 4.18.1-2 — Typelib file for libxfce4util</a></code></summary>

- **Depends:** <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.17.2)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-pango-1.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751">gir1.2-pango-1.0 1.50.12+ds-1</a></code></summary>

- **Depends:** <code>gir1.2-freedesktop (&gt;= 0.9.5)</code> <em>(Debian Bookworm)</em>; <code>gir1.2-glib-2.0 (&gt;= 0.9.5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-harfbuzz-0.0"><code>gir1.2-harfbuzz-0.0 (&gt;= 2.6.0)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libpangoft2-1.0-0"><code>libpangoft2-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libpangoxft-1.0-0"><code>libpangoxft-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-poppler-0.18"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344">gir1.2-poppler-0.18 22.12.0-2+deb12u3 — GObject introspection data for poppler-glib</a></code></summary>

- **Depends:** <code>gir1.2-freedesktop (&gt;= 1.42.0-2~)</code> <em>(Debian Bookworm)</em>; <code>gir1.2-glib-2.0 (&gt;= 1.42.0-2~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpoppler-glib8"><code>libpoppler-glib8 (&gt;= 22.08.0)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-thunarx-3.0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-thunar-4.18.4-1-core2.1-20261010054751">gir1.2-thunarx-3.0 4.18.4-1</a></code></summary>

- **Depends:** <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-gtk-3.0"><code>gir1.2-gtk-3.0</code></a>; <a href="#core2-package-libthunarx-3-0"><code>libthunarx-3-0 (&gt;= 4.17.6)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-vte-2.91"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049">gir1.2-vte-2.91 0.70.6-2~deb12u1</a></code></summary>

- **Depends:** <code>gir1.2-freedesktop (&gt;= 0.9.12)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-gtk-3.0"><code>gir1.2-gtk-3.0 (&gt;= 3.24.22)</code></a>; <a href="#core2-package-gir1.2-pango-1.0"><code>gir1.2-pango-1.0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libvte-2.91-0"><code>libvte-2.91-0 (&gt;= 0.69.90)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-vte-3.91"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049">gir1.2-vte-3.91 0.70.6-2~deb12u1 — GObject introspection data for the VTE library</a></code></summary>

- **Depends:** <code>gir1.2-freedesktop (&gt;= 0.9.12)</code> <em>(Debian Bookworm)</em>; <code>gir1.2-graphene-1.0</code> <em>(Debian Bookworm)</em>; <code>gir1.2-gtk-4.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-gir1.2-pango-1.0"><code>gir1.2-pango-1.0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libvte-2.91-gtk4-0"><code>libvte-2.91-gtk4-0 (&gt;= 0.69.90)</code></a>

</details>

<details>
<summary id="core2-package-gir1.2-xfconf-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xfconf-4.18.0-2-core2.1-20261010053410">gir1.2-xfconf-0 4.18.0-2</a></code></summary>

- **Depends:** <code>gir1.2-glib-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxfconf-0-3"><code>libxfconf-0-3 (&gt;= 4.12.1)</code></a>

</details>

<details>
<summary id="core2-package-gnutls-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800">gnutls-bin 3.7.9-2+deb12u7</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgnutls-dane0"><code>libgnutls-dane0 (&gt;= 3.7.0)</code></a>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.7-0+private+1)</code></a>; <a href="#core2-package-libtasn1-6"><code>libtasn1-6 (&gt;= 4.14)</code></a>

</details>

<details>
<summary id="core2-package-gpgrt-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libgpg-error-1.46-1-core2.1-20261020161016">gpgrt-tools 1.46-1 — GnuPG development runtime library (executable tools)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgpg-error0"><code>libgpg-error0 (&gt;= 1.29)</code></a>

</details>

<details>
<summary id="core2-package-gpm"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gpm-1.20.7-10-core2.1-20261012055149">gpm 1.20.7-10 — General Purpose Mouse interface</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.54~)</code> <em>(Debian Bookworm)</em>
- **Depends:** <code>lsb-base (&gt;= 3.2-13)</code> <em>(Debian Bookworm)</em>; <code>ucf</code> <em>(Debian Bookworm)</em>; one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgpm2"><code>libgpm2 (&gt;= 1.20.7)</code></a>

</details>

<details>
<summary id="core2-package-gtk-3-examples"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945">gtk-3-examples 3.24.38-2~deb12u3</a></code></summary>

- **Depends:** one of: <a href="#core2-package-dconf-gsettings-backend"><code>dconf-gsettings-backend</code></a> | <code>gsettings-backend</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 2.35.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libepoxy0"><code>libepoxy0 (&gt;= 1.0)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.40.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.59.0)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (= 3.24.38-2~deb12u3+core2.1~BUILD)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 2.2.0)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.44.3)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (&gt;= 1.44.0)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>

</details>

<details>
<summary id="core2-package-gtk-update-icon-cache"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945">gtk-update-icon-cache 3.24.38-2~deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.40.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.57.2)</code></a>

</details>

<details>
<summary id="core2-package-guile-gnutls"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800">guile-gnutls 3.7.9-2+deb12u7</a></code></summary>

- **Depends:** <code>guile-3.0</code> <em>(Debian Bookworm)</em>; <code>guile-3.0-libs</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.5)</code></a>

</details>

<details>
<summary id="core2-package-gv"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gv-1-3.7.4-2-core2.1-20261012055256">gv 1:3.7.4-2 — PostScript and PDF viewer for X</a></code></summary>

- **Depends:** <code>ghostscript-x</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxinerama1"><code>libxinerama1 (&gt;= 2:1.1.4)</code></a>; <code>libxmu6 (&gt;= 2:1.1.3)</code> <em>(Debian Bookworm)</em>; <code>libxt6</code> <em>(Debian Bookworm)</em>; <code>xaw3dg (&gt;= 1.5+E-1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-hicolor-icon-theme"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-hicolor-icon-theme-0.17-2-core2.1-20261020160041">hicolor-icon-theme 0.17-2 — default fallback theme for FreeDesktop.org icon themes</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-htop"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-htop-3.2.2-2-core2.1-20261009120215">htop 3.2.2-2 — interactive processes viewer</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libncursesw6"><code>libncursesw6 (&gt;= 6)</code></a>; <code>libnl-3-200 (&gt;= 3.2.7)</code> <em>(Debian Bookworm)</em>; <code>libnl-genl-3-200 (&gt;= 3.2.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>

</details>

<details>
<summary id="core2-package-i965-va-driver"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-intel-vaapi-driver-2.4.1-dfsg1-1-core2.1-20261016135957">i965-va-driver 2.4.1+dfsg1-1 — VAAPI driver for Intel G45 &amp; HD Graphics family</a></code></summary>

- **Depends:** <code>libva-driver-abi-1.17</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdrm-intel1"><code>libdrm-intel1 (&gt;= 2.4.46)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.3.1)</code></a>

</details>

<details>
<summary id="core2-package-icedax"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cdrkit-9-1.1.11-3.4-core2.1-20261012055245">icedax 9:1.1.11-3.4 — Creates WAV files from audio CDs</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-icu-devtools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-icu-72.1-3-deb12u1-core2.1-20261020160050">icu-devtools 72.1-3+deb12u1 — Development utilities for International Components for Unicode</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libicu72"><code>libicu72 (&gt;= 72.1~rc-1~)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-idn2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libidn2-2.3.3-1-core2.1-20261012093052">idn2 2.3.3-1 — Internationalized domain names (IDNA2008/TR46) command line tool</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libidn2-0"><code>libidn2-0 (&gt;= 2.0.0)</code></a>; <a href="#core2-package-libunistring2"><code>libunistring2 (&gt;= 0.9.7)</code></a>

</details>

<details>
<summary id="core2-package-imagemagick"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">imagemagick 8:6.9.11.60+dfsg-1.6+deb12u13 — image manipulation programs -- binaries</a></code></summary>

- **Depends:** <a href="#core2-package-imagemagick-6.q16"><code>imagemagick-6.q16 (&gt;= 8:6.9.2.10+dfsg-2~)</code></a>

</details>

<details>
<summary id="core2-package-imagemagick-6-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">imagemagick-6-common 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-imagemagick-6.q16"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">imagemagick-6.q16 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libmagickcore-6.q16-6"><code>libmagickcore-6.q16-6 (&gt;= 8:6.9.10.2)</code></a>; <a href="#core2-package-libmagickwand-6.q16-6"><code>libmagickwand-6.q16-6 (&gt;= 8:6.9.10.2)</code></a>; <a href="#core2-package-hicolor-icon-theme"><code>hicolor-icon-theme</code></a>

</details>

<details>
<summary id="core2-package-imagemagick-6.q16hdri"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">imagemagick-6.q16hdri 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libmagickcore-6.q16hdri-6"><code>libmagickcore-6.q16hdri-6 (&gt;= 8:6.9.10.2)</code></a>; <a href="#core2-package-libmagickwand-6.q16hdri-6"><code>libmagickwand-6.q16hdri-6 (&gt;= 8:6.9.10.2)</code></a>; <a href="#core2-package-hicolor-icon-theme"><code>hicolor-icon-theme</code></a>

</details>

<details>
<summary id="core2-package-imagemagick-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">imagemagick-common 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.15.7.2)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-imagemagick-6-common"><code>imagemagick-6-common (= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-intel-media-va-driver"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-intel-media-driver-23.1.1-dfsg1-1-core2.1-20261016140210">intel-media-va-driver 23.1.1+dfsg1-1</a></code></summary>

- **Depends:** <code>libva-driver-abi-1.17</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libigdgmm12 (&gt;= 22.3.3+ds1)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-iproute2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-iproute2-6.1.0-3-core2.1-20261009193351">iproute2 6.1.0-3 — networking and traffic control tools</a></code></summary>

- **Depends:** one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>; <code>libbpf1 (&gt;= 1:0.6.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libbsd0"><code>libbsd0 (&gt;= 0.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-libdb5.3"><code>libdb5.3</code></a>; <code>libelf1 (&gt;= 0.131)</code> <em>(Debian Bookworm)</em>; <code>libmnl0 (&gt;= 1.0.3-4~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libtirpc3"><code>libtirpc3 (&gt;= 1.0.2)</code></a>; <a href="#core2-package-libxtables12"><code>libxtables12 (&gt;= 1.6.0+snapshot20161117)</code></a>; <a href="#core2-package-libcap2-bin"><code>libcap2-bin</code></a>

</details>

<details>
<summary id="core2-package-iptables"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-iptables-1.8.9-2-core2.1-20261020160244">iptables 1.8.9-2 — administration tools for packet filtering and NAT</a></code></summary>

- **Depends:** <a href="#core2-package-libip4tc2"><code>libip4tc2 (= 1.8.9-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libip6tc2"><code>libip6tc2 (= 1.8.9-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libxtables12"><code>libxtables12 (= 1.8.9-2+core2.1~BUILD)</code></a>; <code>netbase (&gt;= 6.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libmnl0 (&gt;= 1.0.3-4~)</code> <em>(Debian Bookworm)</em>; <code>libnetfilter-conntrack3 (&gt;= 1.0.6)</code> <em>(Debian Bookworm)</em>; <code>libnfnetlink0 (&gt;= 1.0.2)</code> <em>(Debian Bookworm)</em>; <code>libnftnl11 (&gt;= 1.1.5)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-jbigkit-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-jbigkit-2.1-6.1-core2.1-20261020160309">jbigkit-bin 2.1-6.1 — JBIGkit binaries</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libjbig0"><code>libjbig0 (&gt;= 2.0)</code></a>

</details>

<details>
<summary id="core2-package-jbigkit-testdata"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-jbigkit-2.1-6.1-core2.1-20261020160309">jbigkit-testdata 2.1-6.1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-krb5-admin-server"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">krb5-admin-server 1.20.1-2+deb12u5</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.54~)</code> <em>(Debian Bookworm)</em>
- **Depends:** one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>; <a href="#core2-package-libgssrpc4"><code>libgssrpc4 (&gt;= 1.12~beta2+dfsg)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.18.2)</code></a>; <a href="#core2-package-libkadm5srv-mit12"><code>libkadm5srv-mit12 (&gt;= 1.18.2)</code></a>; <a href="#core2-package-libkdb5-10"><code>libkdb5-10 (&gt;= 1.20.1)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.13~alpha1+dfsg)</code></a>; <a href="#core2-package-libss2"><code>libss2 (&gt;= 1.01)</code></a>; <code>libverto1 (&gt;= 0.2.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-krb5-kdc"><code>krb5-kdc (&gt;= 1.10+dfsg~)</code></a>; <code>lsb-base (&gt;= 3.0-6)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-krb5-gss-samples"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">krb5-gss-samples 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>

</details>

<details>
<summary id="core2-package-krb5-k5tls"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">krb5-k5tls 1.20.1-2+deb12u5 — TLS plugin for MIT Kerberos</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.17)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (&gt;= 1.13~alpha1+dfsg~)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.15~beta1)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>

</details>

<details>
<summary id="core2-package-krb5-kdc"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">krb5-kdc 1.20.1-2+deb12u5</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.54~)</code> <em>(Debian Bookworm)</em>
- **Depends:** one of: <code>debconf (&gt;= 0.5)</code> <em>(Debian Bookworm)</em> | <code>debconf-2.0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libgssrpc4"><code>libgssrpc4 (&gt;= 1.6.dfsg.2)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.20)</code></a>; <a href="#core2-package-libkadm5srv-mit12"><code>libkadm5srv-mit12 (&gt;= 1.18.2)</code></a>; <a href="#core2-package-libkdb5-10"><code>libkdb5-10 (&gt;= 1.20.1)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.20)</code></a>; <code>libverto1 (&gt;= 0.2.4)</code> <em>(Debian Bookworm)</em>; <code>krb5-config</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-krb5-user"><code>krb5-user</code></a>; <code>lsb-base (&gt;= 3.0-6)</code> <em>(Debian Bookworm)</em>; one of: <code>libverto-libev1</code> <em>(Debian Bookworm)</em> | <code>libverto-libevent1</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-krb5-kdc-ldap"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">krb5-kdc-ldap 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libgssrpc4"><code>libgssrpc4 (&gt;= 1.6.dfsg.2)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.20)</code></a>; <a href="#core2-package-libkadm5srv-mit12"><code>libkadm5srv-mit12 (&gt;= 1.18.2)</code></a>; <a href="#core2-package-libkdb5-10"><code>libkdb5-10 (&gt;= 1.20.1)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (&gt;= 1.14+dfsg)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.17)</code></a>; <code>libldap-2.5-0 (&gt;= 2.5.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-krb5-kdc"><code>krb5-kdc (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-krb5-kpropd"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">krb5-kpropd 1.20.1-2+deb12u5</a></code></summary>

- **Pre-Depends:** <code>init-system-helpers (&gt;= 1.54~)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libgssrpc4"><code>libgssrpc4 (&gt;= 1.6.dfsg.2)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.9+dfsg~beta1)</code></a>; <a href="#core2-package-libkadm5clnt-mit12"><code>libkadm5clnt-mit12 (&gt;= 1.18.2)</code></a>; <a href="#core2-package-libkdb5-10"><code>libkdb5-10 (&gt;= 1.20.1)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (&gt;= 1.16)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.7dfsg~beta2)</code></a>; <a href="#core2-package-krb5-kdc"><code>krb5-kdc (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <code>lsb-base</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-krb5-locales"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">krb5-locales 1.20.1-2+deb12u5</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-krb5-multidev"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">krb5-multidev 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libgssrpc4"><code>libgssrpc4 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libkadm5srv-mit12"><code>libkadm5srv-mit12 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libkadm5clnt-mit12"><code>libkadm5clnt-mit12 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <code>comerr-dev</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-krb5-otp"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">krb5-otp 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.20)</code></a>; <a href="#core2-package-libkrad0"><code>libkrad0 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (&gt;= 1.12~alpha1+dfsg-1~)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.11+dfsg)</code></a>

</details>

<details>
<summary id="core2-package-krb5-pkinit"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">krb5-pkinit 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.25)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.8+dfsg)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.17)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>

</details>

<details>
<summary id="core2-package-krb5-user"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">krb5-user 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.20)</code></a>; <a href="#core2-package-libkadm5clnt-mit12"><code>libkadm5clnt-mit12 (&gt;= 1.18.2)</code></a>; <a href="#core2-package-libkadm5srv-mit12"><code>libkadm5srv-mit12 (&gt;= 1.18.2)</code></a>; <a href="#core2-package-libkdb5-10"><code>libkdb5-10 (&gt;= 1.20.1)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.17)</code></a>; <a href="#core2-package-libss2"><code>libss2 (&gt;= 1.01)</code></a>

</details>

<details>
<summary id="core2-package-less"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-less-590-2.1-deb12u2-core2.1-20261012093417">less 590-2.1~deb12u2 — pager program similar to more</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>

</details>

<details>
<summary id="core2-package-lib32ncurses6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">lib32ncurses6 6.4-4</a></code></summary>

- **Depends:** <a href="#core2-package-lib32tinfo6"><code>lib32tinfo6 (= 6.4-4+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6-i386"><code>libc6-i386 (&gt;= 2.7)</code></a>

</details>

<details>
<summary id="core2-package-lib32ncursesw6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">lib32ncursesw6 6.4-4</a></code></summary>

- **Depends:** <a href="#core2-package-lib32tinfo6"><code>lib32tinfo6 (= 6.4-4+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6-i386"><code>libc6-i386 (&gt;= 2.7)</code></a>

</details>

<details>
<summary id="core2-package-lib32readline8"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-readline-8.2-1.3-core2.1-20261009161033">lib32readline8 8.2-1.3</a></code></summary>

- **Depends:** <a href="#core2-package-readline-common"><code>readline-common</code></a>; <a href="#core2-package-lib32tinfo6"><code>lib32tinfo6 (&gt;= 6)</code></a>; <a href="#core2-package-libc6-i386"><code>libc6-i386 (&gt;= 2.33)</code></a>

</details>

<details>
<summary id="core2-package-lib32tinfo6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">lib32tinfo6 6.4-4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6-i386"><code>libc6-i386 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-lib32z1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-zlib-1-1.2.13.dfsg-1-core2.1-20261016151112">lib32z1 1:1.2.13.dfsg-1 — compression library - 32 bit runtime</a></code></summary>

- **Depends:** <a href="#core2-package-libc6-i386"><code>libc6-i386 (&gt;= 2.4)</code></a>

</details>

<details>
<summary id="core2-package-libacl1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-acl-2.3.1-3-core2.1-20261009190907">libacl1 2.3.1-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>

</details>

<details>
<summary id="core2-package-libaom3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-aom-3.6.0-1-deb12u3-core2.1-20261016144330">libaom3 3.6.0-1+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libapache2-mod-apparmor"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-apparmor-3.0.8-3-core2.1-20261020155241">libapache2-mod-apparmor 3.0.8-3</a></code></summary>

- **Depends:** <code>apache2-api-20120211</code> <em>(Debian Bookworm)</em>; <code>apache2-bin (&gt;= 2.4.16)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libapparmor1"><code>libapparmor1 (&gt;= 2.7.0~beta1+bzr1772)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>

</details>

<details>
<summary id="core2-package-libapparmor1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-apparmor-3.0.8-3-core2.1-20261020155241">libapparmor1 3.0.8-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libargon2-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-argon2-0-20171227-0.3-deb12u1-core2.1-20261020155240">libargon2-0 0~20171227-0.3+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libargon2-1"><code>libargon2-1 (= 0~20171227-0.3+deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libargon2-1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-argon2-0-20171227-0.3-deb12u1-core2.1-20261020155240">libargon2-1 0~20171227-0.3+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libaspell15"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-aspell-0.60.8-4-core2.1-20261012055250">libaspell15 0.60.8-4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libass9"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libass-1-0.17.1-1-deb12u1-core2.1-20261016142820">libass9 1:0.17.1-1+deb12u1 — library for SSA/ASS subtitles rendering</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.13.0)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.3.5)</code></a>; <a href="#core2-package-libfribidi0"><code>libfribidi0 (&gt;= 1.0.0)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 1.2.6)</code></a>

</details>

<details>
<summary id="core2-package-libatk-bridge2.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253">libatk-bridge2.0-0 2.46.0-5</a></code></summary>

- **Depends:** <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 2.33.1)</code></a>; <a href="#core2-package-libatspi2.0-0"><code>libatspi2.0-0 (&gt;= 2.9.90)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.7)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62)</code></a>

</details>

<details>
<summary id="core2-package-libatk1.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253">libatk1.0-0 2.46.0-5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62)</code></a>; <a href="#core2-package-at-spi2-common"><code>at-spi2-common</code></a>

</details>

<details>
<summary id="core2-package-libatrildocument3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510">libatrildocument3 1.26.0-2+deb12u4</a></code></summary>

- **Depends:** <code>libjs-mathjax</code> <em>(Debian Bookworm)</em>; <code>libarchive13 (&gt;= 3.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-libdjvulibre21"><code>libdjvulibre21 (&gt;= 3.5.28)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.37.3)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.21.4)</code></a>; <code>libgxps2 (&gt;= 0.2.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libkpathsea6"><code>libkpathsea6 (&gt;= 2022.20220321.62855)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libpoppler-glib8"><code>libpoppler-glib8 (&gt;= 0.22.1)</code></a>; <code>libspectre1 (&gt;= 0.2.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsynctex2"><code>libsynctex2 (&gt;= 2022.20220321.62855)</code></a>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.0.3)</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libatrilview3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510">libatrilview3 1.26.0-2+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libatrildocument3"><code>libatrildocument3 (= 1.26.0-2+deb12u4+core2.1~BUILD)</code></a>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 1.12.4)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.37.3)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.21.4)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.14.0)</code></a>; <code>libwebkit2gtk-4.1-0 (&gt;= 2.5.3)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libatspi2.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253">libatspi2.0-0 2.46.0-5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.7)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.2.99.901)</code></a>; <a href="#core2-package-libxi6"><code>libxi6 (&gt;= 2:1.2.99.4)</code></a>

</details>

<details>
<summary id="core2-package-libattr1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-attr-1-2.5.1-4-core2.1-20261009191027">libattr1 1:2.5.1-4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>

</details>

<details>
<summary id="core2-package-libaudit-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-audit-1-3.0.9-1-core2.1-20261020155244">libaudit-common 1:3.0.9-1 — Dynamic library for security auditing - common files</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libaudit1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-audit-1-3.0.9-1-core2.1-20261020155244">libaudit1 1:3.0.9-1</a></code></summary>

- **Depends:** <a href="#core2-package-libaudit-common"><code>libaudit-common (&gt;= 1:3.0.9-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libcap-ng0"><code>libcap-ng0 (&gt;= 0.7.9)</code></a>

</details>

<details>
<summary id="core2-package-libauparse0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-audit-1-3.0.9-1-core2.1-20261020155244">libauparse0 1:3.0.9-1</a></code></summary>

- **Depends:** <a href="#core2-package-libaudit1"><code>libaudit1 (= 1:3.0.9-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.17)</code></a>

</details>

<details>
<summary id="core2-package-libbrotli1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-brotli-1.0.9-2-core2.1-20261016150736">libbrotli1 1.0.9-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>

</details>

<details>
<summary id="core2-package-libbsd0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libbsd-0.11.7-2-core2.1-20261016150833">libbsd0 0.11.7-2 — utility functions from BSD systems - shared library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libmd0"><code>libmd0 (&gt;= 1.0.3-2)</code></a>

</details>

<details>
<summary id="core2-package-libcap-ng-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libcap-ng-0.8.3-1-core2.1-20261020160633">libcap-ng-utils 0.8.3-1</a></code></summary>

- **Depends:** <a href="#core2-package-libcap-ng0"><code>libcap-ng0 (= 0.8.3-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libcap-ng0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libcap-ng-0.8.3-1-core2.1-20261020160633">libcap-ng0 0.8.3-1 — alternate POSIX capabilities library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>

</details>

<details>
<summary id="core2-package-libcap2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327">libcap2 1:2.66-4+deb12u3 — POSIX 1003.1e capabilities (library)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libcap2-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327">libcap2-bin 1:2.66-4+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.63)</code></a>

</details>

<details>
<summary id="core2-package-libcolord2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-colord-1.4.6-2.2-core2.1-20261020155348">libcolord2 1.4.6-2.2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.58)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.6)</code></a>; <a href="#core2-package-libudev1"><code>libudev1 (&gt;= 196)</code></a>

</details>

<details>
<summary id="core2-package-libcolorhug2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-colord-1.4.6-2.2-core2.1-20261020155348">libcolorhug2 1.4.6-2.2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libcolord2"><code>libcolord2 (&gt;= 1.4.3)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.58)</code></a>; <code>libgusb2 (&gt;= 0.2.7)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libcom-err2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320">libcom-err2 1.47.0-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.17)</code></a>

</details>

<details>
<summary id="core2-package-libconfuse-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libconfuse-3.3-3-core2.1-20261020160734">libconfuse-common 3.3-3 — Common files for libConfuse</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libconfuse2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libconfuse-3.3-3-core2.1-20261020160734">libconfuse2 3.3-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libconfuse-common"><code>libconfuse-common (&gt;= 3.3-3+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libcrypt1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libxcrypt-1-4.4.33-2-core2.1-20261009185630">libcrypt1 1:4.4.33-2 — libcrypt shared library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>

</details>

<details>
<summary id="core2-package-libcups2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438">libcups2 2.4.2-3+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-libavahi-client3"><code>libavahi-client3 (&gt;= 0.6.16)</code></a>; <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (&gt;= 0.6.16)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.5)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-libcupsimage2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438">libcupsimage2 2.4.2-3+deb12u9</a></code></summary>

- **Depends:** <a href="#core2-package-libcups2"><code>libcups2 (= 2.4.2-3+deb12u9+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libcurl3-gnutls"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528">libcurl3-gnutls 7.88.1-10+deb12u15</a></code></summary>

- **Depends:** <a href="#core2-package-libbrotli1"><code>libbrotli1 (&gt;= 0.6.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.5)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>; <a href="#core2-package-libidn2-0"><code>libidn2-0 (&gt;= 0.6)</code></a>; <code>libldap-2.5-0 (&gt;= 2.5.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libnettle8"><code>libnettle8</code></a>; <code>libnghttp2-14 (&gt;= 1.50.0)</code> <em>(Debian Bookworm)</em>; <code>libpsl5 (&gt;= 0.16.0)</code> <em>(Debian Bookworm)</em>; <code>librtmp1 (&gt;= 2.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libssh2-1"><code>libssh2-1 (&gt;= 1.7.0)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libcurl3-nss"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528">libcurl3-nss 7.88.1-10+deb12u15</a></code></summary>

- **Depends:** <a href="#core2-package-libbrotli1"><code>libbrotli1 (&gt;= 0.6.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>; <a href="#core2-package-libidn2-0"><code>libidn2-0 (&gt;= 0.6)</code></a>; <code>libldap-2.5-0 (&gt;= 2.5.4)</code> <em>(Debian Bookworm)</em>; <code>libnghttp2-14 (&gt;= 1.50.0)</code> <em>(Debian Bookworm)</em>; <code>libnspr4 (&gt;= 2:4.9-2~)</code> <em>(Debian Bookworm)</em>; <code>libnss3 (&gt;= 2:3.66)</code> <em>(Debian Bookworm)</em>; <code>libpsl5 (&gt;= 0.16.0)</code> <em>(Debian Bookworm)</em>; <code>librtmp1 (&gt;= 2.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libssh2-1"><code>libssh2-1 (&gt;= 1.7.0)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <code>nss-plugin-pem</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libcurl4"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528">libcurl4 7.88.1-10+deb12u15</a></code></summary>

- **Depends:** <a href="#core2-package-libbrotli1"><code>libbrotli1 (&gt;= 0.6.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>; <a href="#core2-package-libidn2-0"><code>libidn2-0 (&gt;= 0.6)</code></a>; <code>libldap-2.5-0 (&gt;= 2.5.4)</code> <em>(Debian Bookworm)</em>; <code>libnghttp2-14 (&gt;= 1.50.0)</code> <em>(Debian Bookworm)</em>; <code>libpsl5 (&gt;= 0.16.0)</code> <em>(Debian Bookworm)</em>; <code>librtmp1 (&gt;= 2.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libssh2-1"><code>libssh2-1 (&gt;= 1.7.0)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libdatrie1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libdatrie-0.2.13-2-core2.1-20261020160819">libdatrie1 0.2.13-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libdatrie1-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libdatrie-0.2.13-2-core2.1-20261020160819">libdatrie1-bin 0.2.13-2 — Programs for double-array trie library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdatrie1"><code>libdatrie1 (&gt;= 0.2.0)</code></a>

</details>

<details>
<summary id="core2-package-libdav1d6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dav1d-1.0.0-2-deb12u1-core2.1-20261016144008">libdav1d6 1.0.0-2+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libdb5.3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531">libdb5.3 5.3.28+dfsg2-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libdb5.3++"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531">libdb5.3++ 5.3.28+dfsg2-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdb5.3"><code>libdb5.3 (= 5.3.28+dfsg2-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libdb5.3-java"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531">libdb5.3-java 5.3.28+dfsg2-1</a></code></summary>

- **Depends:** <a href="#core2-package-libdb5.3-java-jni"><code>libdb5.3-java-jni (&gt;= 5.3.28+dfsg2-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libdb5.3-java-jni"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531">libdb5.3-java-jni 5.3.28+dfsg2-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdb5.3"><code>libdb5.3 (= 5.3.28+dfsg2-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libdb5.3-sql"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531">libdb5.3-sql 5.3.28+dfsg2-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdb5.3"><code>libdb5.3 (= 5.3.28+dfsg2-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libdb5.3-stl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531">libdb5.3-stl 5.3.28+dfsg2-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdb5.3"><code>libdb5.3 (= 5.3.28+dfsg2-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libdb5.3-tcl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531">libdb5.3-tcl 5.3.28+dfsg2-1</a></code></summary>

- **Depends:** <code>tcl (&gt;= 8.6.0-2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdb5.3"><code>libdb5.3 (= 5.3.28+dfsg2-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libdbus-1-3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524">libdbus-1-3 1.14.10-1~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>

</details>

<details>
<summary id="core2-package-libdconf1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-dconf-0.40.0-4-core2.1-20261020155533">libdconf1 0.40.0-4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>

</details>

<details>
<summary id="core2-package-libdeflate-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libdeflate-1.14-1-core2.1-20261020160817">libdeflate-tools 1.14-1 — tools for whole-buffer compression and decompression library</a></code></summary>

- **Depends:** <a href="#core2-package-libdeflate0"><code>libdeflate0 (= 1.14-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libdeflate0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libdeflate-1.14-1-core2.1-20261020160817">libdeflate0 1.14-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libdjvulibre-text"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223">libdjvulibre-text 3.5.28-2.2~deb12u1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libdjvulibre21"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223">libdjvulibre21 3.5.28-2.2~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdjvulibre-text"><code>libdjvulibre-text (&gt;= 3.5.28-2.2~deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libebur128-1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libebur128-1-1.2.6-1-core2.1-20261023221125">libebur128-1 1.2.6-1 — implementation of the EBU R128 loudness standard</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>

</details>

<details>
<summary id="core2-package-libepoxy0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libepoxy-1.5.10-1-core2.1-20261016134055">libepoxy0 1.5.10-1 — OpenGL function pointer management library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libepub0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ebook-tools-0.2.2-6-core2.1-20261012055224">libepub0 0.2.2-6</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>; <code>libzip4 (&gt;= 0.10)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libevdocument3-4"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-evince-43.1-2-deb12u1-core2.1-20261012055507">libevdocument3-4 43.1-2+deb12u1</a></code></summary>

- **Depends:** <code>libarchive13 (&gt;= 3.6.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libdjvulibre21"><code>libdjvulibre21 (&gt;= 3.5.28)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.40)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.1)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.22.0)</code></a>; <code>libgxps2 (&gt;= 0.2.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libkpathsea6"><code>libkpathsea6 (&gt;= 2022.20220321.62855)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.18.0)</code></a>; <a href="#core2-package-libpoppler-glib8"><code>libpoppler-glib8 (&gt;= 22.02.0)</code></a>; <code>libspectre1 (&gt;= 0.2.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsynctex2"><code>libsynctex2 (&gt;= 2022.20220321.62855)</code></a>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.0.3)</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>

</details>

<details>
<summary id="core2-package-libevview3-3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-evince-43.1-2-deb12u1-core2.1-20261012055507">libevview3-3 43.1-2+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-gstreamer1.0-plugins-base"><code>gstreamer1.0-plugins-base</code></a>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 1.12.4)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libevdocument3-4"><code>libevdocument3-4 (&gt;= 43~alpha)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.38)</code></a>; <code>libgspell-1-2 (&gt;= 1.8.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.0.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.0.0)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.22.0)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.14.0)</code></a>

</details>

<details>
<summary id="core2-package-libexo-2-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-exo-4.18.0-1-core2.1-20261010053936">libexo-2-0 4.18.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libexo-common"><code>libexo-common</code></a>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 1.12.4)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.21.4)</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.17.0~)</code></a>

</details>

<details>
<summary id="core2-package-libexo-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-exo-4.18.0-1-core2.1-20261010053936">libexo-common 4.18.0-1 — libexo common files</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libexpat1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-expat-2.5.0-1-deb12u4-core2.1-20261016150748">libexpat1 2.5.0-1+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>

</details>

<details>
<summary id="core2-package-libext2fs2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320">libext2fs2 1.47.0-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libffi8"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libffi-3.4.4-1-core2.1-20261009194707">libffi8 3.4.4-1 — Foreign Function Interface library runtime</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libfftw3-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fftw3-3.3.10-1-core2.1-20261009181939">libfftw3-bin 3.3.10-1 — Library for computing Fast Fourier Transforms - Tools</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libfftw3-double3"><code>libfftw3-double3 (&gt;= 3.3.10)</code></a>; <a href="#core2-package-libfftw3-long3"><code>libfftw3-long3 (&gt;= 3.3.10)</code></a>; <a href="#core2-package-libfftw3-quad3"><code>libfftw3-quad3 (&gt;= 3.3.10)</code></a>; <a href="#core2-package-libfftw3-single3"><code>libfftw3-single3 (&gt;= 3.3.10)</code></a>

</details>

<details>
<summary id="core2-package-libfftw3-double3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fftw3-3.3.10-1-core2.1-20261009181939">libfftw3-double3 3.3.10-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgomp1 (&gt;= 4.9)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libfftw3-long3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fftw3-3.3.10-1-core2.1-20261009181939">libfftw3-long3 3.3.10-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgomp1 (&gt;= 4.9)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libfftw3-mpi3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fftw3-3.3.10-1-core2.1-20261009181939">libfftw3-mpi3 3.3.10-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libfftw3-double3"><code>libfftw3-double3 (&gt;= 3.3.10)</code></a>; <a href="#core2-package-libfftw3-long3"><code>libfftw3-long3 (&gt;= 3.3.10)</code></a>; <a href="#core2-package-libfftw3-single3"><code>libfftw3-single3 (&gt;= 3.3.10)</code></a>; <code>libopenmpi3 (&gt;= 4.1.4)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libfftw3-quad3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fftw3-3.3.10-1-core2.1-20261009181939">libfftw3-quad3 3.3.10-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgomp1 (&gt;= 4.9)</code> <em>(Debian Bookworm)</em>; <code>libquadmath0 (&gt;= 4.6)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libfftw3-single3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fftw3-3.3.10-1-core2.1-20261009181939">libfftw3-single3 3.3.10-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgomp1 (&gt;= 4.9)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libfontconfig1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fontconfig-2.14.1-4-core2.1-20261016150850">libfontconfig1 2.14.1-4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libexpat1"><code>libexpat1 (&gt;= 2.0.1)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.9.1)</code></a>; <a href="#core2-package-fontconfig-config"><code>fontconfig-config (&gt;= 2.14.1-4+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libfreetype6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-freetype-2.12.1-dfsg-5-deb12u4-core2.1-20261016150739">libfreetype6 2.12.1+dfsg-5+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libbrotli1"><code>libbrotli1 (&gt;= 0.6.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libfribidi-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fribidi-1.0.8-2.1-core2.1-20261020155618">libfribidi-bin 1.0.8-2.1 — Free Implementation of the Unicode BiDi algorithm (utility)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libfribidi0"><code>libfribidi0 (&gt;= 0.19.2)</code></a>

</details>

<details>
<summary id="core2-package-libfribidi0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-fribidi-1.0.8-2.1-core2.1-20261020155618">libfribidi0 1.0.8-2.1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.3.4)</code></a>

</details>

<details>
<summary id="core2-package-libgail-3-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945">libgail-3-0 3.24.38-2~deb12u3 — GNOME Accessibility Implementation Library -- shared libraries</a></code></summary>

- **Depends:** <a href="#core2-package-at-spi2-core"><code>at-spi2-core</code></a>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 2.35.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.57.2)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (= 3.24.38-2~deb12u3+core2.1~BUILD)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.44.0)</code></a>

</details>

<details>
<summary id="core2-package-libgarcon-1-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-garcon-4.18.0-1-core2.1-20261010054213">libgarcon-1-0 4.18.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libgarcon-common"><code>libgarcon-common</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.3+git20210214)</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.9.0)</code></a>

</details>

<details>
<summary id="core2-package-libgarcon-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-garcon-4.18.0-1-core2.1-20261010054213">libgarcon-common 4.18.0-1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libgarcon-gtk3-1-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-garcon-4.18.0-1-core2.1-20261010054213">libgarcon-gtk3-1-0 4.18.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libgarcon-1-0"><code>libgarcon-1-0 (&gt;= 0.6.0)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.9.10)</code></a>; <a href="#core2-package-libxfce4ui-2-0"><code>libxfce4ui-2-0 (&gt;= 4.15.6)</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.15.3)</code></a>

</details>

<details>
<summary id="core2-package-libgcrypt20"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libgcrypt20-1.10.1-3-deb12u1-core2.1-20261020161004">libgcrypt20 1.10.1-3+deb12u1 — LGPL Crypto library - runtime library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgpg-error0"><code>libgpg-error0 (&gt;= 1.27)</code></a>

</details>

<details>
<summary id="core2-package-libgdk-pixbuf-2.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747">libgdk-pixbuf-2.0-0 2.42.10+dfsg-1+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libgdk-pixbuf2.0-common"><code>libgdk-pixbuf2.0-common (&gt;= 2.42.10+dfsg-1+deb12u4+core2.1~BUILD)</code></a>; <a href="#core2-package-shared-mime-info"><code>shared-mime-info</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.59.0)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.0.3)</code></a>

</details>

<details>
<summary id="core2-package-libgdk-pixbuf2.0-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747">libgdk-pixbuf2.0-bin 2.42.10+dfsg-1+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.35.4)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.56.0)</code></a>

</details>

<details>
<summary id="core2-package-libgdk-pixbuf2.0-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747">libgdk-pixbuf2.0-common 2.42.10+dfsg-1+deb12u4</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libgmp10"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412">libgmp10 2:6.2.1+dfsg1-1.1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libgmpxx4ldbl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412">libgmpxx4ldbl 2:6.2.1+dfsg1-1.1 — Multiprecision arithmetic library (C++ bindings)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgmp10"><code>libgmp10 (&gt;= 2:6.2.1+dfsg1)</code></a>; <code>libstdc++6 (&gt;= 5.2)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libgnutls-dane0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800">libgnutls-dane0 3.7.9-2+deb12u7</a></code></summary>

- **Depends:** <a href="#core2-package-libgnutls30"><code>libgnutls30 (= 3.7.9-2+deb12u7+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libunbound8 (&gt;= 1.8.0)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libgnutls30"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800">libgnutls30 3.7.9-2+deb12u7</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgmp10"><code>libgmp10 (&gt;= 2:6.2.1+dfsg1)</code></a>; <a href="#core2-package-libhogweed6"><code>libhogweed6 (&gt;= 3.6)</code></a>; <a href="#core2-package-libidn2-0"><code>libidn2-0 (&gt;= 2.0.0)</code></a>; <a href="#core2-package-libnettle8"><code>libnettle8 (&gt;= 3.7~)</code></a>; <a href="#core2-package-libp11-kit0"><code>libp11-kit0 (&gt;= 0.23.18.1)</code></a>; <a href="#core2-package-libtasn1-6"><code>libtasn1-6 (&gt;= 4.14)</code></a>; <a href="#core2-package-libunistring2"><code>libunistring2 (&gt;= 0.9.7)</code></a>

</details>

<details>
<summary id="core2-package-libgnutlsxx30"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800">libgnutlsxx30 3.7.9-2+deb12u7 — GNU TLS library - C++ runtime library</a></code></summary>

- **Depends:** <a href="#core2-package-libgnutls30"><code>libgnutls30 (= 3.7.9-2+deb12u7+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libgpg-error-l10n"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libgpg-error-1.46-1-core2.1-20261020161016">libgpg-error-l10n 1.46-1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libgpg-error0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libgpg-error-1.46-1-core2.1-20261020161016">libgpg-error0 1.46-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libgpm2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gpm-1.20.7-10-core2.1-20261012055149">libgpm2 1.20.7-10</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>

</details>

<details>
<summary id="core2-package-libgraphite2-3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-graphite2-1.3.14-1-deb12u1-core2.1-20261020160000">libgraphite2-3 1.3.14-1+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libgraphite2-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-graphite2-1.3.14-1-deb12u1-core2.1-20261020160000">libgraphite2-utils 1.3.14-1+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgraphite2-3"><code>libgraphite2-3 (&gt;= 1.2.2)</code></a>; <code>libstdc++6 (&gt;= 4.1.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libgssapi-krb5-2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">libgssapi-krb5-2 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.20)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.15~beta1)</code></a>

</details>

<details>
<summary id="core2-package-libgssrpc4"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">libgssrpc4 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>

</details>

<details>
<summary id="core2-package-libgtk-3-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945">libgtk-3-0 3.24.38-2~deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-adwaita-icon-theme"><code>adwaita-icon-theme</code></a>; <a href="#core2-package-hicolor-icon-theme"><code>hicolor-icon-theme</code></a>; <a href="#core2-package-shared-mime-info"><code>shared-mime-info</code></a>; <a href="#core2-package-libatk-bridge2.0-0"><code>libatk-bridge2.0-0 (&gt;= 2.15.1)</code></a>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 2.35.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo-gobject2"><code>libcairo-gobject2 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libcolord2"><code>libcolord2 (&gt;= 0.1.10)</code></a>; <a href="#core2-package-libcups2"><code>libcups2 (&gt;= 1.7.0)</code></a>; <a href="#core2-package-libepoxy0"><code>libepoxy0 (&gt;= 1.4.3)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libfribidi0"><code>libfribidi0 (&gt;= 0.19.7)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.40.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.59.0)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 2.2.0)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.45.5)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (&gt;= 1.44.0)</code></a>; <a href="#core2-package-libpangoft2-1.0-0"><code>libpangoft2-1.0-0 (&gt;= 1.44.0)</code></a>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libwayland-cursor0"><code>libwayland-cursor0 (&gt;= 1.14.91)</code></a>; <a href="#core2-package-libwayland-egl1"><code>libwayland-egl1 (&gt;= 1.15.0)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.4.99.1)</code></a>; <a href="#core2-package-libxcomposite1"><code>libxcomposite1 (&gt;= 1:0.4.5)</code></a>; <a href="#core2-package-libxcursor1"><code>libxcursor1 (&gt;&gt; 1.1.2)</code></a>; <a href="#core2-package-libxdamage1"><code>libxdamage1 (&gt;= 1:1.1)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxfixes3"><code>libxfixes3</code></a>; <a href="#core2-package-libxi6"><code>libxi6 (&gt;= 2:1.2.99.4)</code></a>; <a href="#core2-package-libxinerama1"><code>libxinerama1 (&gt;= 2:1.1.4)</code></a>; <a href="#core2-package-libxkbcommon0"><code>libxkbcommon0 (&gt;= 0.5.0)</code></a>; <a href="#core2-package-libxrandr2"><code>libxrandr2 (&gt;= 2:1.5.0)</code></a>; <a href="#core2-package-libgtk-3-common"><code>libgtk-3-common (&gt;= 3.24.38-2~deb12u3+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libgtk-3-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945">libgtk-3-bin 3.24.38-2~deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-gtk-update-icon-cache"><code>gtk-update-icon-cache</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.40.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.57.2)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.24.38-2~deb12u3+core2.1~BUILD)</code></a>; <a href="#core2-package-libgtk-3-common"><code>libgtk-3-common (&gt;= 3.24.38-2~deb12u3+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libgtk-3-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945">libgtk-3-common 3.24.38-2~deb12u3</a></code></summary>

- **Depends:** one of: <a href="#core2-package-dconf-gsettings-backend"><code>dconf-gsettings-backend</code></a> | <code>gsettings-backend</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libharfbuzz-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021">libharfbuzz-bin 6.0.0+dfsg-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.7.2)</code></a>; <code>libchafa0 (&gt;= 1.6.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.3)</code></a>; <a href="#core2-package-libharfbuzz-subset0"><code>libharfbuzz-subset0 (&gt;= 6.0.0)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 5.1.0)</code></a>

</details>

<details>
<summary id="core2-package-libharfbuzz-gobject0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021">libharfbuzz-gobject0 6.0.0+dfsg-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.2.5)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.14.0)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 5.1.0)</code></a>

</details>

<details>
<summary id="core2-package-libharfbuzz-icu0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021">libharfbuzz-icu0 6.0.0+dfsg-3 — OpenType text shaping engine ICU backend</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 0.9.4)</code></a>; <a href="#core2-package-libicu72"><code>libicu72 (&gt;= 72.1~rc-1~)</code></a>

</details>

<details>
<summary id="core2-package-libharfbuzz-subset0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021">libharfbuzz-subset0 6.0.0+dfsg-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 5.1.0)</code></a>

</details>

<details>
<summary id="core2-package-libharfbuzz0b"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021">libharfbuzz0b 6.0.0+dfsg-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.11.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.31.8)</code></a>; <a href="#core2-package-libgraphite2-3"><code>libgraphite2-3 (&gt;= 1.2.2)</code></a>

</details>

<details>
<summary id="core2-package-libhogweed6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-nettle-3.8.1-2-core2.1-20261020161715">libhogweed6 3.8.1-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libgmp10"><code>libgmp10 (&gt;= 2:6.2.1+dfsg1)</code></a>; <a href="#core2-package-libnettle8"><code>libnettle8</code></a>

</details>

<details>
<summary id="core2-package-libicu72"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-icu-72.1-3-deb12u1-core2.1-20261020160050">libicu72 72.1-3+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 12)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libidn2-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libidn2-2.3.3-1-core2.1-20261012093052">libidn2-0 2.3.3-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libunistring2"><code>libunistring2 (&gt;= 0.9.7)</code></a>

</details>

<details>
<summary id="core2-package-libigfxcmrt7"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-intel-media-driver-23.1.1-dfsg1-1-core2.1-20261016140210">libigfxcmrt7 23.1.1+dfsg1-1 — Intel C for Media Runtime -- shared library</a></code></summary>

- **Depends:** one of: <a href="#core2-package-intel-media-va-driver"><code>intel-media-va-driver (= 23.1.1+dfsg1-1+core2.1~BUILD)</code></a> | <code>intel-media-va-driver-non-free (&gt;= 23.1.1+dfsg1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.12)</code></a>

</details>

<details>
<summary id="core2-package-libip4tc2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-iptables-1.8.9-2-core2.1-20261020160244">libip4tc2 1.8.9-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.28)</code></a>

</details>

<details>
<summary id="core2-package-libip6tc2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-iptables-1.8.9-2-core2.1-20261020160244">libip6tc2 1.8.9-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.28)</code></a>

</details>

<details>
<summary id="core2-package-libiptc0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-iptables-1.8.9-2-core2.1-20261020160244">libiptc0 1.8.9-2</a></code></summary>

- **Depends:** <a href="#core2-package-libip4tc2"><code>libip4tc2 (= 1.8.9-2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libjbig0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-jbigkit-2.1-6.1-core2.1-20261020160309">libjbig0 2.1-6.1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>

</details>

<details>
<summary id="core2-package-libjpeg-turbo-progs"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748">libjpeg-turbo-progs 1:2.1.5-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1:2.0.2)</code></a>; <a href="#core2-package-libturbojpeg0"><code>libturbojpeg0 (&gt;= 1:2.0.2)</code></a>

</details>

<details>
<summary id="core2-package-libjpeg62-turbo"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748">libjpeg62-turbo 1:2.1.5-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libjson-c5"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-json-c-0.16-2-core2.1-20261020160448">libjson-c5 0.16-2 — JSON manipulation library - shared library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.36)</code></a>

</details>

<details>
<summary id="core2-package-libk5crypto3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">libk5crypto3 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.20)</code></a>

</details>

<details>
<summary id="core2-package-libkadm5clnt-mit12"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">libkadm5clnt-mit12 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.25)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>; <a href="#core2-package-libgssrpc4"><code>libgssrpc4 (&gt;= 1.6.dfsg.2)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.6.dfsg.2)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (&gt;= 1.15~beta1)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.17)</code></a>

</details>

<details>
<summary id="core2-package-libkadm5srv-mit12"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">libkadm5srv-mit12 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.6.dfsg.2)</code></a>; <a href="#core2-package-libgssrpc4"><code>libgssrpc4 (&gt;= 1.6.dfsg.2)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.6.dfsg.2)</code></a>; <a href="#core2-package-libkdb5-10"><code>libkdb5-10 (&gt;= 1.20.1)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (&gt;= 1.15~beta1)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.17)</code></a>

</details>

<details>
<summary id="core2-package-libkdb5-10"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">libkdb5-10 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libgssrpc4"><code>libgssrpc4 (&gt;= 1.7dfsg~alpha1)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.20)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (&gt;= 1.14+dfsg)</code></a>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (&gt;= 1.15~beta1)</code></a>

</details>

<details>
<summary id="core2-package-libkpathsea6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216">libkpathsea6 2022.20220321.62855-5.1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>

</details>

<details>
<summary id="core2-package-libkrad0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">libkrad0 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.25)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.20)</code></a>; <a href="#core2-package-libkrb5-3"><code>libkrb5-3 (&gt;= 1.6.dfsg.2)</code></a>; <code>libverto1 (&gt;= 0.2.4)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libkrb5-3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">libkrb5-3 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcom-err2"><code>libcom-err2 (&gt;= 1.43.9)</code></a>; <a href="#core2-package-libk5crypto3"><code>libk5crypto3 (&gt;= 1.20)</code></a>; <code>libkeyutils1 (&gt;= 1.5.9)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libkrb5support0"><code>libkrb5support0 (= 1.20.1-2+deb12u5+core2.1~BUILD)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>

</details>

<details>
<summary id="core2-package-libkrb5support0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614">libkrb5support0 1.20.1-2+deb12u5</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-liblcms2-2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-lcms2-2.14-2-deb12u1-core2.1-20261020160533">liblcms2-2 2.14-2+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>

</details>

<details>
<summary id="core2-package-liblcms2-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-lcms2-2.14-2-deb12u1-core2.1-20261020160533">liblcms2-utils 2.14-2+deb12u1 — Little CMS 2 color management library (utilities)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.14)</code></a>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.0.3)</code></a>

</details>

<details>
<summary id="core2-package-liblerc4"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-lerc-4.0.0-ds-2-core2.1-20261020160636">liblerc4 4.0.0+ds-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-liblz4-1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-lz4-1.9.4-1-core2.1-20261020161626">liblz4-1 1.9.4-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-liblz4-tool"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-lz4-1.9.4-1-core2.1-20261020161626">liblz4-tool 1.9.4-1</a></code></summary>

- **Depends:** <a href="#core2-package-lz4"><code>lz4</code></a>

</details>

<details>
<summary id="core2-package-libmagic-mgc"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-file-1-5.44-3-core2.1-20261012055237">libmagic-mgc 1:5.44-3</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libmagic1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-file-1-5.44-3-core2.1-20261012055237">libmagic1 1:5.44-3</a></code></summary>

- **Depends:** <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <a href="#core2-package-libmagic-mgc"><code>libmagic-mgc (= 1:5.44-3+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libmagick++-6-headers"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagick++-6-headers 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.15.7.2)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-libmagickwand-6-headers"><code>libmagickwand-6-headers (= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-libmagickcore-6-headers"><code>libmagickcore-6-headers (= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-imagemagick-6-common"><code>imagemagick-6-common (= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libmagick++-6.q16-8"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagick++-6.q16-8 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libmagickcore-6.q16-6"><code>libmagickcore-6.q16-6 (&gt;= 8:6.9.10.2)</code></a>; <a href="#core2-package-libmagickwand-6.q16-6"><code>libmagickwand-6.q16-6 (&gt;= 8:6.9.10.2)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libmagick++-6.q16hdri-8"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagick++-6.q16hdri-8 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libmagickcore-6.q16hdri-6"><code>libmagickcore-6.q16hdri-6 (&gt;= 8:6.9.10.2)</code></a>; <a href="#core2-package-libmagickwand-6.q16hdri-6"><code>libmagickwand-6.q16hdri-6 (&gt;= 8:6.9.10.2)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libmagickcore-6-arch-config"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagickcore-6-arch-config 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.15.7.2)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-libmagickcore-6-headers"><code>libmagickcore-6-headers (= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-imagemagick-6-common"><code>imagemagick-6-common (&gt;= 8:6.9.6.2+dfsg-3)</code></a>

</details>

<details>
<summary id="core2-package-libmagickcore-6-headers"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagickcore-6-headers 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.15.7.2)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-imagemagick-6-common"><code>imagemagick-6-common (= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libmagickcore-6.q16-6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagickcore-6.q16-6 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.17.6)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libfftw3-double3"><code>libfftw3-double3 (&gt;= 3.3.10)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.10.1)</code></a>; <code>libgcc-s1 (&gt;= 3.3.1)</code> <em>(Debian Bookworm)</em>; <code>libgomp1 (&gt;= 6)</code> <em>(Debian Bookworm)</em>; <code>libheif1 (&gt;= 1.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libjbig0"><code>libjbig0 (&gt;= 2.0)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.6)</code></a>; <code>liblqr-1-0 (&gt;= 0.4.0)</code> <em>(Debian Bookworm)</em>; <code>libltdl7 (&gt;= 2.4.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-libopenjp2-7"><code>libopenjp2-7 (&gt;= 2.0.0)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.5.0~rc1)</code></a>; <a href="#core2-package-libwebp7"><code>libwebp7 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libwebpdemux2"><code>libwebpdemux2 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libwebpmux3"><code>libwebpmux3 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <a href="#core2-package-imagemagick-6-common"><code>imagemagick-6-common (&gt;= 8:6.9.6.2+dfsg-3)</code></a>

</details>

<details>
<summary id="core2-package-libmagickcore-6.q16-6-extra"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagickcore-6.q16-6-extra 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.6.0)</code></a>; <a href="#core2-package-libdjvulibre21"><code>libdjvulibre21 (&gt;= 3.5.28)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.12.0)</code></a>; <a href="#core2-package-libmagickcore-6.q16-6"><code>libmagickcore-6.q16-6 (&gt;= 8:6.9.11.24)</code></a>; <a href="#core2-package-libmagickwand-6.q16-6"><code>libmagickwand-6.q16-6 (&gt;= 8:6.9.10.2)</code></a>; <code>libopenexr-3-1-30 (&gt;= 3.1.5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (&gt;= 1.14.0)</code></a>; <code>libwmflite-0.2-7 (&gt;= 0.2.12)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>

</details>

<details>
<summary id="core2-package-libmagickcore-6.q16hdri-6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagickcore-6.q16hdri-6 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.17.6)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libfftw3-double3"><code>libfftw3-double3 (&gt;= 3.3.10)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.10.1)</code></a>; <code>libgcc-s1 (&gt;= 3.3.1)</code> <em>(Debian Bookworm)</em>; <code>libgomp1 (&gt;= 6)</code> <em>(Debian Bookworm)</em>; <code>libheif1 (&gt;= 1.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libjbig0"><code>libjbig0 (&gt;= 2.0)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.6)</code></a>; <code>liblqr-1-0 (&gt;= 0.4.0)</code> <em>(Debian Bookworm)</em>; <code>libltdl7 (&gt;= 2.4.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-libopenjp2-7"><code>libopenjp2-7 (&gt;= 2.0.0)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.5.0~rc1)</code></a>; <a href="#core2-package-libwebp7"><code>libwebp7 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libwebpdemux2"><code>libwebpdemux2 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libwebpmux3"><code>libwebpmux3 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <a href="#core2-package-imagemagick-6-common"><code>imagemagick-6-common (&gt;= 8:6.9.6.2+dfsg-3)</code></a>

</details>

<details>
<summary id="core2-package-libmagickcore-6.q16hdri-6-extra"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagickcore-6.q16hdri-6-extra 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.6.0)</code></a>; <a href="#core2-package-libdjvulibre21"><code>libdjvulibre21 (&gt;= 3.5.28)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.12.0)</code></a>; <a href="#core2-package-libmagickcore-6.q16hdri-6"><code>libmagickcore-6.q16hdri-6 (&gt;= 8:6.9.11.24)</code></a>; <a href="#core2-package-libmagickwand-6.q16hdri-6"><code>libmagickwand-6.q16hdri-6 (&gt;= 8:6.9.10.2)</code></a>; <code>libopenexr-3-1-30 (&gt;= 3.1.5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (&gt;= 1.14.0)</code></a>; <code>libwmflite-0.2-7 (&gt;= 0.2.12)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>

</details>

<details>
<summary id="core2-package-libmagickwand-6-headers"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagickwand-6-headers 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.15.7.2)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-libmagickcore-6-headers"><code>libmagickcore-6-headers (= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-imagemagick-6-common"><code>imagemagick-6-common (= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libmagickwand-6.q16-6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagickwand-6.q16-6 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.17.6)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <code>libgcc-s1 (&gt;= 3.3.1)</code> <em>(Debian Bookworm)</em>; <code>libgomp1 (&gt;= 4.9)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libmagickcore-6.q16-6"><code>libmagickcore-6.q16-6 (&gt;= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-imagemagick-6-common"><code>imagemagick-6-common (&gt;= 8:6.9.6.2+dfsg-3)</code></a>

</details>

<details>
<summary id="core2-package-libmagickwand-6.q16hdri-6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530">libmagickwand-6.q16hdri-6 8:6.9.11.60+dfsg-1.6+deb12u13</a></code></summary>

- **Pre-Depends:** <code>dpkg (&gt;= 1.17.6)</code> <em>(Debian Bookworm)</em>
- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <code>libgcc-s1 (&gt;= 3.3.1)</code> <em>(Debian Bookworm)</em>; <code>libgomp1 (&gt;= 4.9)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libmagickcore-6.q16hdri-6"><code>libmagickcore-6.q16hdri-6 (&gt;= 8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~BUILD)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-imagemagick-6-common"><code>imagemagick-6-common (&gt;= 8:6.9.6.2+dfsg-3)</code></a>

</details>

<details>
<summary id="core2-package-libmd0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libmd-1.0.4-2-core2.1-20261016150931">libmd0 1.0.4-2 — message digest functions from BSD systems - shared library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>

</details>

<details>
<summary id="core2-package-libmpeg2-4"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mpeg2dec-0.5.1-9-core2.1-20261016145852">libmpeg2-4 0.5.1-9</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>

</details>

<details>
<summary id="core2-package-libmpfr6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-mpfr4-4.2.0-1-core2.1-20261009194039">libmpfr6 4.2.0-1 — multiple precision floating-point computation</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libgmp10"><code>libgmp10 (&gt;= 2:6.2.1+dfsg1)</code></a>

</details>

<details>
<summary id="core2-package-libncurses5"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">libncurses5 6.4-4 — shared libraries for terminal handling (legacy version)</a></code></summary>

- **Depends:** <a href="#core2-package-libtinfo5"><code>libtinfo5 (= 6.4-4+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libncurses6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">libncurses6 6.4-4</a></code></summary>

- **Depends:** <a href="#core2-package-libtinfo6"><code>libtinfo6 (= 6.4-4+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libncursesw5"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">libncursesw5 6.4-4</a></code></summary>

- **Depends:** <a href="#core2-package-libtinfo5"><code>libtinfo5 (= 6.4-4+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libncursesw6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">libncursesw6 6.4-4</a></code></summary>

- **Depends:** <a href="#core2-package-libtinfo6"><code>libtinfo6 (= 6.4-4+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libnettle8"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-nettle-3.8.1-2-core2.1-20261020161715">libnettle8 3.8.1-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.17)</code></a>

</details>

<details>
<summary id="core2-package-libogg0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libogg-1.3.5-3-core2.1-20261023192506">libogg0 1.3.5-3 — Ogg bitstream library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libokular5core10"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453">libokular5core10 4:22.12.3-1+deb12u1</a></code></summary>

- **Depends:** <code>kio</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <code>libkf5archive5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5bookmarks5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5configcore5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5configgui5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5configwidgets5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5coreaddons5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5i18n5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5jsapi5 (&gt;= 5.69.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5kiocore5 (&gt;= 5.69.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5kiowidgets5 (&gt;= 5.69.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5service-bin</code> <em>(Debian Bookworm)</em>; <code>libkf5service5 (&gt;= 5.69.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5threadweaver5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5wallet-bin</code> <em>(Debian Bookworm)</em>; <code>libkf5wallet5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5widgetsaddons5 (&gt;= 4.96.0)</code> <em>(Debian Bookworm)</em>; <code>libphonon4qt5-4 (&gt;= 4:4.8.0)</code> <em>(Debian Bookworm)</em>; <code>libqt5core5a (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5network5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5printsupport5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5svg5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5widgets5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5xml5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <code>phonon4qt5</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libopenjp2-7"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019">libopenjp2-7 2.5.0-2+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libopenjp2-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019">libopenjp2-tools 2.5.0-2+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.2+git20110628)</code></a>; <a href="#core2-package-libopenjp2-7"><code>libopenjp2-7 (&gt;= 2.5.0)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.0.3)</code></a>

</details>

<details>
<summary id="core2-package-libopenjpip-dec-server"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019">libopenjpip-dec-server 2.5.0-2+deb12u3 — tool to allow caching of JPEG 2000 files using JPIP protocol</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libopenjpip7"><code>libopenjpip7 (&gt;= 2.1.0)</code></a>

</details>

<details>
<summary id="core2-package-libopenjpip-server"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019">libopenjpip-server 2.5.0-2+deb12u3</a></code></summary>

- **Depends:** <code>libwww-perl</code> <em>(Debian Bookworm)</em>; <code>spawn-fcgi (&gt;= 1.6.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcurl3-gnutls"><code>libcurl3-gnutls (&gt;= 7.16.2)</code></a>; <code>libfcgi0ldbl (&gt;= 2.4.2)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libopenjpip-viewer"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019">libopenjpip-viewer 2.5.0-2+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libopenjpip-dec-server"><code>libopenjpip-dec-server</code></a>; one of: <code>default-jre</code> <em>(Debian Bookworm)</em> | <code>java8-runtime</code> <em>(Debian Bookworm)</em> | <code>java9-runtime</code> <em>(Debian Bookworm)</em> | <code>java10-runtime</code> <em>(Debian Bookworm)</em> | <code>java11-runtime</code> <em>(Debian Bookworm)</em>; <code>jarwrapper (&gt;= 0.5)</code> <em>(Debian Bookworm)</em>; <code>libxerces2-java</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libopenjpip7"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019">libopenjpip7 2.5.0-2+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libopenjp2-7"><code>libopenjp2-7 (&gt;= 2.0.0)</code></a>

</details>

<details>
<summary id="core2-package-libopenmpt0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libopenmpt-0.6.9-1-core2.1-20261016143234">libopenmpt0 0.6.9-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.32)</code></a>; <code>libgcc-s1 (&gt;= 4.0)</code> <em>(Debian Bookworm)</em>; <code>libmpg123-0 (&gt;= 1.28.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <code>libvorbis0a (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <code>libvorbisfile3 (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-liborc-0.4-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-orc-1-0.4.33-2-core2.1-20261016143016">liborc-0.4-0 1:0.4.33-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libp11-kit0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-p11-kit-0.24.1-2-core2.1-20261020161738">libp11-kit0 0.24.1-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libffi8"><code>libffi8 (&gt;= 3.4)</code></a>

</details>

<details>
<summary id="core2-package-libpango-1.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751">libpango-1.0-0 1.50.12+ds-1</a></code></summary>

- **Depends:** <a href="#core2-package-fontconfig"><code>fontconfig (&gt;= 2.13.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libfribidi0"><code>libfribidi0 (&gt;= 1.0.6)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.3)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 5.1.0)</code></a>; <a href="#core2-package-libthai0"><code>libthai0 (&gt;= 0.1.25)</code></a>

</details>

<details>
<summary id="core2-package-libpango1.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751">libpango1.0-0 1.50.12+ds-1 — Layout and rendering of internationalized text (transitional package)</a></code></summary>

- **Depends:** <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.42)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (&gt;= 1.42)</code></a>; <a href="#core2-package-libpangoft2-1.0-0"><code>libpangoft2-1.0-0 (&gt;= 1.42)</code></a>; <a href="#core2-package-libpangoxft-1.0-0"><code>libpangoxft-1.0-0 (&gt;= 1.42)</code></a>

</details>

<details>
<summary id="core2-package-libpangoft2-1.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751">libpangoft2-1.0-0 1.50.12+ds-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.13.0)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.3)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 5.1.0)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libpangoxft-1.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751">libpangoxft-1.0-0 1.50.12+ds-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.13.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62.0)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libpangoft2-1.0-0"><code>libpangoft2-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <code>libxft2 (&gt;&gt; 2.1.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxrender1"><code>libxrender1</code></a>

</details>

<details>
<summary id="core2-package-libpciaccess0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libpciaccess-0.17-2-core2.1-20261016115401">libpciaccess0 0.17-2 — Generic PCI access library for X</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libpcre2-16-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649">libpcre2-16-0 10.42-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libpcre2-32-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649">libpcre2-32-0 10.42-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libpcre2-8-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649">libpcre2-8-0 10.42-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libpcre2-posix3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649">libpcre2-posix3 10.42-1+deb12u2 — New Perl Compatible Regular Expression Library - posix-compatible runtime files</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.22)</code></a>

</details>

<details>
<summary id="core2-package-libplacebo208"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libplacebo-4.208.0-3-core2.1-20261016142619">libplacebo208 4.208.0-3 — GPU-accelerated video/image rendering primitives (shared library)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libepoxy0"><code>libepoxy0 (&gt;= 1.4.3)</code></a>; <code>libgcc-s1 (&gt;= 3.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.6)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <code>libvulkan1 (&gt;= 1.2.131.2)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libpng-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libpng1.6-1.6.39-2-deb12u6-core2.1-20261016150951">libpng-tools 1.6.39-2+deb12u6 — PNG library - tools (version 1.6)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (= 1.6.39-2+deb12u6+core2.1~BUILD)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.3.4)</code></a>

</details>

<details>
<summary id="core2-package-libpng16-16"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libpng1.6-1.6.39-2-deb12u6-core2.1-20261016150951">libpng16-16 1.6.39-2+deb12u6</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.11.dfsg)</code></a>

</details>

<details>
<summary id="core2-package-libpoppler-cpp0v5"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344">libpoppler-cpp0v5 22.12.0-2+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libpoppler126"><code>libpoppler126 (= 22.12.0-2+deb12u3+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libpoppler-glib8"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344">libpoppler-glib8 22.12.0-2+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libpoppler126"><code>libpoppler126 (= 22.12.0-2+deb12u3+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.12.0)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.1)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libpoppler-qt5-1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344">libpoppler-qt5-1 22.12.0-2+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libpoppler126"><code>libpoppler126 (= 22.12.0-2+deb12u3+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.32)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.2+git20110628)</code></a>; <code>libqt5core5a (&gt;= 5.15.1)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.14.1)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.14.1)</code> <em>(Debian Bookworm)</em>; <code>libqt5xml5 (&gt;= 5.0.2)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libpoppler-qt6-3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344">libpoppler-qt6-3 22.12.0-2+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libpoppler126"><code>libpoppler126 (= 22.12.0-2+deb12u3+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.32)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.2+git20110628)</code></a>; <code>libqt6core6 (&gt;= 6.4.0)</code> <em>(Debian Bookworm)</em>; <code>libqt6gui6 (&gt;= 6.1.2)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libpoppler126"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344">libpoppler126 22.12.0-2+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.7)</code></a>; <code>libnspr4 (&gt;= 2:4.9-2~)</code> <em>(Debian Bookworm)</em>; <code>libnss3 (&gt;= 2:3.16)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libopenjp2-7"><code>libopenjp2-7 (&gt;= 2.0.0)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.0.3)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libptexenc1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216">libptexenc1 2022.20220321.62855-5.1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libkpathsea6"><code>libkpathsea6 (&gt;= 2022.20220321.62855)</code></a>

</details>

<details>
<summary id="core2-package-libreadline8"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-readline-8.2-1.3-core2.1-20261009161033">libreadline8 8.2-1.3</a></code></summary>

- **Depends:** <a href="#core2-package-readline-common"><code>readline-common</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>

</details>

<details>
<summary id="core2-package-libsdl2-2.0-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libsdl2-2.26.5-dfsg-1-core2.1-20261016134254">libsdl2-2.0-0 2.26.5+dfsg-1 — Simple DirectMedia Layer</a></code></summary>

- **Depends:** <code>libasound2 (&gt;= 1.0.27)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libdecor-0-0 (&gt;= 0.1.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.47)</code></a>; <a href="#core2-package-libgbm1"><code>libgbm1 (&gt;= 8.1~0)</code></a>; <code>libpulse0 (&gt;= 0.99.1)</code> <em>(Debian Bookworm)</em>; <code>libsamplerate0 (&gt;= 0.1.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libwayland-cursor0"><code>libwayland-cursor0 (&gt;= 1.18)</code></a>; <a href="#core2-package-libwayland-egl1"><code>libwayland-egl1 (&gt;= 1.18)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.2.99.901)</code></a>; <a href="#core2-package-libxcursor1"><code>libxcursor1 (&gt;&gt; 1.1.2)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxfixes3"><code>libxfixes3 (&gt;= 1:5.0)</code></a>; <a href="#core2-package-libxi6"><code>libxi6 (&gt;= 2:1.6.99.1)</code></a>; <a href="#core2-package-libxkbcommon0"><code>libxkbcommon0 (&gt;= 0.5.0)</code></a>; <a href="#core2-package-libxrandr2"><code>libxrandr2 (&gt;= 2:1.2.99.3)</code></a>; <code>libxss1</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libsdl2-tests"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libsdl2-2.26.5-dfsg-1-core2.1-20261016134254">libsdl2-tests 2.26.5+dfsg-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsdl2-2.0-0"><code>libsdl2-2.0-0 (&gt;= 2.26.0)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>

</details>

<details>
<summary id="core2-package-libseccomp2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libseccomp-2.5.4-1-deb12u1-core2.1-20261017010131">libseccomp2 2.5.4-1+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libselinux1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libselinux-3.4-1-core2.1-20261009190433">libselinux1 3.4-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.22)</code></a>

</details>

<details>
<summary id="core2-package-libsemanage-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libsemanage-3.4-1-core2.1-20261020161025">libsemanage-common 3.4-1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libsemanage2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libsemanage-3.4-1-core2.1-20261020161025">libsemanage2 3.4-1</a></code></summary>

- **Depends:** <a href="#core2-package-libsemanage-common"><code>libsemanage-common (&gt;= 3.4-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.4)</code></a>; <a href="#core2-package-libsepol2"><code>libsepol2 (&gt;= 3.4)</code></a>

</details>

<details>
<summary id="core2-package-libsepol2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libsepol-3.4-2.1-core2.1-20261020161145">libsepol2 3.4-2.1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>

</details>

<details>
<summary id="core2-package-libslang2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-slang2-2.3.3-3-core2.1-20261012055155">libslang2 2.3.3-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>

</details>

<details>
<summary id="core2-package-libslang2-modules"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-slang2-2.3.3-3-core2.1-20261012055155">libslang2-modules 2.3.3-3 — Shared modules for S-Lang language</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libonig5 (&gt;= 6.8.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libslang2-pic"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-slang2-2.3.3-3-core2.1-20261012055155">libslang2-pic 2.3.3-3</a></code></summary>

- **Depends:** <a href="https://github.com/AmrUser-48/linux/releases/tag/core2-slang2-2.3.3-3-core2.1-20261012055155"><code>libslang2-dev (= 2.3.3-3+core2.1~BUILD)</code></a> <em>(non-runtime Core 2 package)</em>

</details>

<details>
<summary id="core2-package-libss2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320">libss2 1.47.0-2</a></code></summary>

- **Depends:** <a href="#core2-package-libcom-err2"><code>libcom-err2</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libssh2-1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libssh2-1.10.0-3-deb12u1-core2.1-20261012055158">libssh2-1 1.10.0-3+deb12u1 — SSH2 client-side library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libsvtav1dec0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-svt-av1-1.4.1-dfsg-1-core2.1-20261016144712">libsvtav1dec0 1.4.1+dfsg-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libsvtav1enc1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-svt-av1-1.4.1-dfsg-1-core2.1-20261016144712">libsvtav1enc1 1.4.1+dfsg-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libsynctex2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216">libsynctex2 2022.20220321.62855-5.1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libtasn1-6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libtasn1-6-4.19.0-2-deb12u1-core2.1-20261020161215">libtasn1-6 4.19.0-2+deb12u1 — Manage ASN.1 structures (runtime)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libtasn1-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libtasn1-6-4.19.0-2-deb12u1-core2.1-20261020161215">libtasn1-bin 4.19.0-2+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libtasn1-6"><code>libtasn1-6 (&gt;= 4.14)</code></a>

</details>

<details>
<summary id="core2-package-libtexlua53"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216">libtexlua53 2022.20220321.62855-5.1+deb12u2 — transitional package (lib)</a></code></summary>

- **Depends:** <a href="#core2-package-libtexlua53-5"><code>libtexlua53-5</code></a>

</details>

<details>
<summary id="core2-package-libtexlua53-5"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216">libtexlua53-5 2022.20220321.62855-5.1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libtexluajit2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216">libtexluajit2 2022.20220321.62855-5.1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.3)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libthai-data"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libthai-0.1.29-1-core2.1-20261020161219">libthai-data 0.1.29-1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libthai0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libthai-0.1.29-1-core2.1-20261020161219">libthai0 0.1.29-1 — Thai language support library</a></code></summary>

- **Depends:** <a href="#core2-package-libthai-data"><code>libthai-data (&gt;= 0.1.10)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libdatrie1"><code>libdatrie1 (&gt;= 0.2.0)</code></a>

</details>

<details>
<summary id="core2-package-libtheora-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libtheora-1.1.1-dfsg.1-16.1-deb12u1-core2.1-20261016150347">libtheora-bin 1.1.1+dfsg.1-16.1+deb12u1 — Theora Video Compression Codec (example encoder, decoder)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libogg0"><code>libogg0 (&gt;= 1.0rc3)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <code>libsdl1.2debian (&gt;= 1.2.15)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtheora0"><code>libtheora0 (&gt;= 1.0)</code></a>; <code>libvorbis0a (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <code>libvorbisenc2 (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libtheora0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libtheora-1.1.1-dfsg.1-16.1-deb12u1-core2.1-20261016150347">libtheora0 1.1.1+dfsg.1-16.1+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libogg0"><code>libogg0 (&gt;= 1.1.0)</code></a>

</details>

<details>
<summary id="core2-package-libthunarx-3-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-thunar-4.18.4-1-core2.1-20261010054751">libthunarx-3-0 4.18.4-1</a></code></summary>

- **Depends:** <a href="#core2-package-thunar-data"><code>thunar-data</code></a>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 1.12.4)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <code>libexif12 (&gt;= 0.6.21-1~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libexo-2-0"><code>libexo-2-0 (&gt;= 4.17.0)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.21.4)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.22)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxfce4ui-2-0"><code>libxfce4ui-2-0 (&gt;= 4.17.6)</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.17.2)</code></a>; <a href="#core2-package-libxfconf-0-3"><code>libxfconf-0-3 (&gt;= 4.6.0)</code></a>

</details>

<details>
<summary id="core2-package-libtiff-opengl"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933">libtiff-opengl 4.5.0-6+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <code>libglut3.12 (&gt;= 3.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.5.0~rc1)</code></a>

</details>

<details>
<summary id="core2-package-libtiff-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933">libtiff-tools 4.5.0-6+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.5.0~rc1)</code></a>

</details>

<details>
<summary id="core2-package-libtiff6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933">libtiff6 4.5.0-6+deb12u4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libdeflate0"><code>libdeflate0 (&gt;= 1.0)</code></a>; <a href="#core2-package-libjbig0"><code>libjbig0 (&gt;= 2.0)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-liblerc4"><code>liblerc4 (&gt;= 3.0)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-libwebp7"><code>libwebp7 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-libtiffxx6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933">libtiffxx6 4.5.0-6+deb12u4 — Tag Image File Format (TIFF) library -- C++ interface</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.0.3)</code></a>

</details>

<details>
<summary id="core2-package-libtinfo5"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">libtinfo5 6.4-4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libtinfo6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">libtinfo6 6.4-4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libtirpc-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libtirpc-1.3.3-ds-1-core2.1-20261009195337">libtirpc-common 1.3.3+ds-1 — transport-independent RPC library - common files</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libtirpc3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libtirpc-1.3.3-ds-1-core2.1-20261009195337">libtirpc3 1.3.3+ds-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgssapi-krb5-2"><code>libgssapi-krb5-2 (&gt;= 1.17)</code></a>; <a href="#core2-package-libtirpc-common"><code>libtirpc-common (&gt;= 1.3.3+ds-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libtumbler-1-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tumbler-4.18.0-1-core2.1-20261010054511">libtumbler-1-0 4.18.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.17.1~)</code></a>

</details>

<details>
<summary id="core2-package-libturbojpeg-java"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748">libturbojpeg-java 1:2.1.5-2 — Java bindings for the TurboJPEG library</a></code></summary>

- **Depends:** <a href="#core2-package-libturbojpeg0"><code>libturbojpeg0 (&gt;= 1:2.1.5-2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-libturbojpeg0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748">libturbojpeg0 1:2.1.5-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-libunistring2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libunistring-1.0-2-core2.1-20261012093008">libunistring2 1.0-2 — Unicode string library for C</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libva-glx2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libva-2.17.0-1-core2.1-20261016135745">libva-glx2 2.17.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libva-x11-2"><code>libva-x11-2 (&gt;= 1.0.3)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.17.0)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&lt;&lt; 2.17.0.1), libx11-6</code></a>

</details>

<details>
<summary id="core2-package-libva-x11-2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libva-2.17.0-1-core2.1-20261016135745">libva-x11-2 2.17.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libdrm2"><code>libdrm2 (&gt;= 2.4.60)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.17.0)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&lt;&lt; 2.17.0.1), libx11-6 (&gt;= 2:1.4.99.1), libx11-xcb1 (&gt;= 2:1.8.4)</code></a>; <a href="#core2-package-libxcb-dri3-0"><code>libxcb-dri3-0</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxfixes3"><code>libxfixes3</code></a>

</details>

<details>
<summary id="core2-package-libva2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libva-2.17.0-1-core2.1-20261016135745">libva2 2.17.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libvdpau1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libvdpau-1.5-2-core2.1-20261016142429">libvdpau1 1.5-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.4.99.1)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>

</details>

<details>
<summary id="core2-package-libvlc-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">libvlc-bin 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libvlc5"><code>libvlc5 (&gt;= 3.0.23)</code></a>

</details>

<details>
<summary id="core2-package-libvlc5"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">libvlc5 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>

</details>

<details>
<summary id="core2-package-libvlccore9"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">libvlccore9 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <code>libidn12 (&gt;= 1.13)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-libvte-2.91-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049">libvte-2.91-0 0.70.6-2~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libvte-2.91-common"><code>libvte-2.91-common (= 0.70.6-2~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 1.12.4)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-libfribidi0"><code>libfribidi0 (&gt;= 1.0.0)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.52.0)</code></a>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.2)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.24.22)</code></a>; <a href="#core2-package-libicu72"><code>libicu72 (&gt;= 72.1~rc-1~)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.44.3)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.22)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsystemd0"><code>libsystemd0 (&gt;= 220)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-libvte-2.91-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049">libvte-2.91-common 0.70.6-2~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libvte-2.91-gtk4-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049">libvte-2.91-gtk4-0 0.70.6-2~deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libvte-2.91-common"><code>libvte-2.91-common (= 0.70.6-2~deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-libfribidi0"><code>libfribidi0 (&gt;= 1.0.0)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.59.0)</code></a>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.2)</code></a>; <code>libgtk-4-1 (&gt;= 4.0.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libicu72"><code>libicu72 (&gt;= 72.1~rc-1~)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.44.3)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (&gt;= 1.22.0)</code></a>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.22)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsystemd0"><code>libsystemd0 (&gt;= 220)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-libwebp7"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libwebp-1.2.4-0.2-deb12u1-core2.1-20261011064208">libwebp7 1.2.4-0.2+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libwebpdemux2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libwebp-1.2.4-0.2-deb12u1-core2.1-20261011064208">libwebpdemux2 1.2.4-0.2+deb12u1 — Lossy compression of digital photographic images.</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libwebp7"><code>libwebp7 (&gt;= 1.2.4)</code></a>

</details>

<details>
<summary id="core2-package-libwebpmux3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libwebp-1.2.4-0.2-deb12u1-core2.1-20261011064208">libwebpmux3 1.2.4-0.2+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <a href="#core2-package-libwebp7"><code>libwebp7 (&gt;= 1.2.4)</code></a>

</details>

<details>
<summary id="core2-package-libwim15"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-wimlib-1.13.6-1-core2.1-20261012055555">libwim15 1.13.6-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libfuse2 (&gt;= 2.8)</code> <em>(Debian Bookworm)</em>; <code>libntfs-3g89</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>

</details>

<details>
<summary id="core2-package-libx264-164"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-x264-2-0.164.3095-gitbaee400-3-core2.1-20261016145121">libx264-164 2:0.164.3095+gitbaee400-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libxau6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxau-1-1.0.9-1-core2.1-20261016151004">libxau6 1:1.0.9-1 — X11 authorisation library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>

</details>

<details>
<summary id="core2-package-libxcomposite1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcomposite-1-0.4.5-1-core2.1-20261016133125">libxcomposite1 1:0.4.5-1 — X11 Composite extension library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.4.99.1)</code></a>

</details>

<details>
<summary id="core2-package-libxcrypt-source"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libxcrypt-1-4.4.33-2-core2.1-20261009185630">libxcrypt-source 1:4.4.33-2</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libxcursor1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxcursor-1-1.2.1-1-core2.1-20261020161324">libxcursor1 1:1.2.1-1 — X cursor management library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.4.99.1)</code></a>; <a href="#core2-package-libxfixes3"><code>libxfixes3</code></a>; <a href="#core2-package-libxrender1"><code>libxrender1</code></a>

</details>

<details>
<summary id="core2-package-libxdamage1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxdamage-1-1.1.6-1-core2.1-20261016133326">libxdamage1 1:1.1.6-1 — X11 damaged region extension library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.4.99.1)</code></a>

</details>

<details>
<summary id="core2-package-libxdmcp6"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxdmcp-1-1.1.2-3-core2.1-20261016151011">libxdmcp6 1:1.1.2-3 — X11 Display Manager Control Protocol library</a></code></summary>

- **Depends:** <a href="#core2-package-libbsd0"><code>libbsd0 (&gt;= 0.2.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>

</details>

<details>
<summary id="core2-package-libxfce4ui-2-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651">libxfce4ui-2-0 4.18.2-2</a></code></summary>

- **Depends:** <a href="#core2-package-libxfce4ui-common"><code>libxfce4ui-common</code></a>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 1.12.4)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.21.4)</code></a>; <code>libice6 (&gt;= 1:1.0.0)</code> <em>(Debian Bookworm)</em>; <code>libsm6</code> <em>(Debian Bookworm)</em>; <code>libstartup-notification0 (&gt;= 0.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.17.2)</code></a>; <a href="#core2-package-libxfconf-0-3"><code>libxfconf-0-3 (&gt;= 4.6.0)</code></a>

</details>

<details>
<summary id="core2-package-libxfce4ui-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651">libxfce4ui-common 4.18.2-2</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libxfce4ui-glade"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651">libxfce4ui-glade 4.18.2-2 — glade API for libxfce4ui</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.2.5)</code></a>; <code>libgladeui-2-13 (&gt;= 3.16.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.12.0)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libxfce4ui-2-0"><code>libxfce4ui-2-0 (&gt;= 4.11.0)</code></a>

</details>

<details>
<summary id="core2-package-libxfce4ui-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651">libxfce4ui-utils 4.18.2-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libepoxy0"><code>libepoxy0 (&gt;= 1.2)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.16.2)</code></a>; <code>libgtop-2.0-11 (&gt;= 2.22.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxfce4ui-2-0"><code>libxfce4ui-2-0 (&gt;= 4.11.0)</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.17.2)</code></a>

</details>

<details>
<summary id="core2-package-libxfce4util-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4util-4.18.1-2-core2.1-20261010053208">libxfce4util-bin 4.18.1-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.9.0)</code></a>

</details>

<details>
<summary id="core2-package-libxfce4util-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4util-4.18.1-2-core2.1-20261010053208">libxfce4util-common 4.18.1-2</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-libxfce4util7"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4util-4.18.1-2-core2.1-20261010053208">libxfce4util7 4.18.1-2</a></code></summary>

- **Depends:** <a href="#core2-package-libxfce4util-common"><code>libxfce4util-common</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>

</details>

<details>
<summary id="core2-package-libxfconf-0-3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xfconf-4.18.0-2-core2.1-20261010053410">libxfconf-0-3 4.18.0-2</a></code></summary>

- **Depends:** <a href="#core2-package-xfconf"><code>xfconf</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>

</details>

<details>
<summary id="core2-package-libxfixes3"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxfixes-1-6.0.0-2-core2.1-20261020161340">libxfixes3 1:6.0.0-2 — X11 miscellaneous 'fixes' extension library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.6.0)</code></a>

</details>

<details>
<summary id="core2-package-libxkbcommon-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422">libxkbcommon-tools 1.5.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libxcb-xkb1"><code>libxcb-xkb1</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>; <a href="#core2-package-libxkbcommon-x11-0"><code>libxkbcommon-x11-0 (&gt;= 0.5.0)</code></a>; <a href="#core2-package-libxkbcommon0"><code>libxkbcommon0 (&gt;= 1.0.0)</code></a>; <a href="#core2-package-libxkbregistry0"><code>libxkbregistry0 (&gt;= 1.0.0)</code></a>

</details>

<details>
<summary id="core2-package-libxkbcommon-x11-0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422">libxkbcommon-x11-0 1.5.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-libxkbcommon0"><code>libxkbcommon0 (= 1.5.0-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.17)</code></a>; <a href="#core2-package-libxcb-xkb1"><code>libxcb-xkb1</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.6)</code></a>

</details>

<details>
<summary id="core2-package-libxkbcommon0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422">libxkbcommon0 1.5.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-xkb-data"><code>xkb-data</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>

</details>

<details>
<summary id="core2-package-libxkbregistry0"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422">libxkbregistry0 1.5.0-1 — library to query available RMLVO</a></code></summary>

- **Depends:** <a href="#core2-package-libxkbcommon0"><code>libxkbcommon0 (= 1.5.0-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>

</details>

<details>
<summary id="core2-package-libxml2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxml2-2.9.14-dfsg-1.3-deb12u6-core2.1-20261020161513">libxml2 2.9.14+dfsg-1.3~deb12u6 — GNOME XML library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libicu72"><code>libicu72 (&gt;= 72.1~rc-1~)</code></a>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.3.3)</code></a>

</details>

<details>
<summary id="core2-package-libxml2-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxml2-2.9.14-dfsg-1.3-deb12u6-core2.1-20261020161513">libxml2-utils 2.9.14+dfsg-1.3~deb12u6</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.9.0)</code></a>

</details>

<details>
<summary id="core2-package-libxtables12"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-iptables-1.8.9-2-core2.1-20261020160244">libxtables12 1.8.9-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libxv1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxv-2-1.0.11-1.1-core2.1-20261016133515">libxv1 2:1.0.11-1.1 — X11 Video extension library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.6.0)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>

</details>

<details>
<summary id="core2-package-libxvidcore4"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xvidcore-2-1.3.7-1-core2.1-20261016150055">libxvidcore4 2:1.3.7-1 — Open source MPEG-4 video codec (library)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-libxvmc1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libxvmc-2-1.0.12-2-core2.1-20261016133703">libxvmc1 2:1.0.12-2 — X11 Video extension library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.6.0)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <code>x11-common</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-links"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-links2-2.28-1-core2.1-20261012055305">links 2.28-1</a></code></summary>

- **Depends:** <a href="#core2-package-libbrotli1"><code>libbrotli1 (&gt;= 0.6.0)</code></a>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgpm2"><code>libgpm2 (&gt;= 1.20.7)</code></a>; <code>liblz1 (&gt;= 1.13)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-links2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-links2-2.28-1-core2.1-20261012055305">links2 2.28-1 — Web browser running in both graphics and text mode</a></code></summary>

- **Depends:** <a href="#core2-package-libbrotli1"><code>libbrotli1 (&gt;= 0.6.0)</code></a>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.2.4)</code></a>; <code>libdirectfb-1.7-7 (&gt;= 1.7.7)</code> <em>(Debian Bookworm)</em>; <code>libevent-2.1-7 (&gt;= 2.1.8-stable)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.16.0)</code></a>; <code>libgomp1 (&gt;= 4.9)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgpm2"><code>libgpm2 (&gt;= 1.20.7)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <code>liblz1 (&gt;= 1.13)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liblzma5"><code>liblzma5 (&gt;= 5.1.1alpha+20120614)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <code>librsvg2-2 (&gt;= 2.32.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.0.3)</code></a>; <a href="#core2-package-libwebp7"><code>libwebp7 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libzstd1"><code>libzstd1 (&gt;= 1.5.2)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-locate"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-findutils-4.9.0-4-core2.1-20261009164357">locate 4.9.0-4</a></code></summary>

- **Depends:** <a href="#core2-package-findutils"><code>findutils (&gt;&gt; 4.2.31-1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-logsave"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320">logsave 1.47.0-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-lynx"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-lynx-2.9.0dev.12-1-core2.1-20261012055253">lynx 2.9.0dev.12-1 — classic non-graphical (text-mode) web browser</a></code></summary>

- **Depends:** <a href="#core2-package-lynx-common"><code>lynx-common</code></a>; <a href="#core2-package-libbsd0"><code>libbsd0 (&gt;= 0.0)</code></a>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.5)</code></a>; <a href="#core2-package-libidn2-0"><code>libidn2-0 (&gt;= 2.0.0)</code></a>; <a href="#core2-package-libncursesw6"><code>libncursesw6 (&gt;= 6)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-lynx-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-lynx-2.9.0dev.12-1-core2.1-20261012055253">lynx-common 2.9.0dev.12-1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-lz4"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-lz4-1.9.4-1-core2.1-20261020161626">lz4 1.9.4-1 — Fast LZ compression algorithm library - tool</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-liblz4-1"><code>liblz4-1 (= 1.9.4-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-mc"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mc-3-4.8.29-2-core2.1-20261012055147">mc 3:4.8.29-2 — Midnight Commander - a powerful file manager</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libext2fs2"><code>libext2fs2 (&gt;= 1.37)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.3)</code></a>; <a href="#core2-package-libgpm2"><code>libgpm2 (&gt;= 1.20.7)</code></a>; <a href="#core2-package-libslang2"><code>libslang2 (&gt;= 2.2.4)</code></a>; <a href="#core2-package-libssh2-1"><code>libssh2-1 (&gt;= 1.2.8)</code></a>; <a href="#core2-package-mc-data"><code>mc-data (= 3:4.8.29-2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-mc-data"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mc-3-4.8.29-2-core2.1-20261012055147">mc-data 3:4.8.29-2</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-mpeg2dec"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mpeg2dec-0.5.1-9-core2.1-20261016145852">mpeg2dec 0.5.1-9 — Simple libmpeg2 video decoder application</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libmpeg2-4"><code>libmpeg2-4 (&gt;= 0.5.1)</code></a>; <code>libsdl1.2debian (&gt;= 1.2.15)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxv1"><code>libxv1</code></a>

</details>

<details>
<summary id="core2-package-mupdf"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mupdf-1.21.1-ds2-1-deb12u1-core2.1-20261012055501">mupdf 1.21.1+ds2-1+deb12u1 — lightweight PDF viewer</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.6)</code></a>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <code>libglut3.12 (&gt;= 3.4.0)</code> <em>(Debian Bookworm)</em>; <code>libgumbo1 (&gt;= 0.9.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 0.9.11)</code></a>; <code>libjbig2dec0 (&gt;= 0.19)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <code>libmujs2 (&gt;= 1.0.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libopenjp2-7"><code>libopenjp2-7 (&gt;= 2.0.0)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-mupdf-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-mupdf-1.21.1-ds2-1-deb12u1-core2.1-20261012055501">mupdf-tools 1.21.1+ds2-1+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.6)</code></a>; <code>libgumbo1 (&gt;= 0.9.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 0.9.11)</code></a>; <code>libjbig2dec0 (&gt;= 0.19)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <code>libmujs2 (&gt;= 1.0.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libopenjp2-7"><code>libopenjp2-7 (&gt;= 2.0.0)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-nano"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-nano-7.2-1-deb12u1-core2.1-20261009163909">nano 7.2-1+deb12u1 — small, friendly text editor inspired by Pico</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libncursesw6"><code>libncursesw6 (&gt;= 6)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>

</details>

<details>
<summary id="core2-package-nano-tiny"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-nano-7.2-1-deb12u1-core2.1-20261009163909">nano-tiny 7.2-1+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libncursesw6"><code>libncursesw6 (&gt;= 6)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>

</details>

<details>
<summary id="core2-package-ncmpcpp"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-ncmpcpp-0.9.2-2-core2.1-20261009113534">ncmpcpp 0.9.2-2 — ncurses-based client for the Music Player Daemon (MPD)</a></code></summary>

- **Depends:** <code>libboost-filesystem1.74.0 (&gt;= 1.74.0+ds1)</code> <em>(Debian Bookworm)</em>; <code>libboost-locale1.74.0 (&gt;= 1.74.0+ds1)</code> <em>(Debian Bookworm)</em>; <code>libboost-program-options1.74.0 (&gt;= 1.74.0+ds1)</code> <em>(Debian Bookworm)</em>; <code>libboost-regex1.74.0-icu72</code> <em>(Debian Bookworm)</em>; <code>libboost-thread1.74.0 (&gt;= 1.74.0+ds1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcurl3-gnutls"><code>libcurl3-gnutls (&gt;= 7.16.2)</code></a>; <a href="#core2-package-libfftw3-double3"><code>libfftw3-double3 (&gt;= 3.3.10)</code></a>; <code>libgcc-s1 (&gt;= 3.3.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libicu72"><code>libicu72 (&gt;= 72.1~rc-1~)</code></a>; <code>libmpdclient2 (&gt;= 2.9)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libncursesw6"><code>libncursesw6 (&gt;= 6)</code></a>; <a href="#core2-package-libreadline8"><code>libreadline8 (&gt;= 6.0)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <code>libtag1v5 (&gt;= 1.11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>

</details>

<details>
<summary id="core2-package-ncurses-base"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">ncurses-base 6.4-4</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-ncurses-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">ncurses-bin 6.4-4</a></code></summary>

- **Pre-Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6.3)</code></a>

</details>

<details>
<summary id="core2-package-ncurses-examples"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">ncurses-examples 6.4-4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libncursesw6"><code>libncursesw6 (&gt;= 6.1+20180203)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>

</details>

<details>
<summary id="core2-package-ncurses-term"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822">ncurses-term 6.4-4</a></code></summary>

- **Depends:** <a href="#core2-package-ncurses-base"><code>ncurses-base (&gt;= 6.1+20190713)</code></a>

</details>

<details>
<summary id="core2-package-neovim"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-neovim-0.7.2-7-core2.1-20261009082328">neovim 0.7.2-7 — heavily refactored vim fork</a></code></summary>

- **Depends:** <a href="#core2-package-neovim-runtime"><code>neovim-runtime (= 0.7.2-7+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; one of: <code>libluajit-5.1-2 (&gt;= 2.0.4+dfsg)</code> <em>(Debian Bookworm)</em> | <code>libluajit2-5.1-2 (&gt;= 2.1~)</code> <em>(Debian Bookworm)</em>; <code>libmsgpackc2 (&gt;= 2.1.0)</code> <em>(Debian Bookworm)</em>; <code>libtermkey1 (&gt;= 0.19)</code> <em>(Debian Bookworm)</em>; <code>libtree-sitter0 (&gt;= 0.20.2)</code> <em>(Debian Bookworm)</em>; <code>libunibilium4 (&gt;= 2.0)</code> <em>(Debian Bookworm)</em>; <code>libuv1 (&gt;= 1.30.1)</code> <em>(Debian Bookworm)</em>; <code>libvterm0 (&gt;= 0.1)</code> <em>(Debian Bookworm)</em>; <code>lua-luv (&gt;= 1.44.2-0)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-neovim-runtime"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-neovim-0.7.2-7-core2.1-20261009082328">neovim-runtime 0.7.2-7</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-nettle-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-nettle-3.8.1-2-core2.1-20261020161715">nettle-bin 3.8.1-2 — low level cryptographic library (binary tools)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libgmp10"><code>libgmp10 (&gt;= 2:6.2.1+dfsg1)</code></a>; <a href="#core2-package-libhogweed6"><code>libhogweed6</code></a>; <a href="#core2-package-libnettle8"><code>libnettle8 (= 3.8.1-2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-odt2txt"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-odt2txt-0.5-7-core2.1-20261012055305">odt2txt 0.5-7 — simple converter from OpenDocument Text to plain text</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-okular"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453">okular 4:22.12.3-1+deb12u1 — universal document viewer</a></code></summary>

- **Depends:** <code>kinit</code> <em>(Debian Bookworm)</em>; <code>kio</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <code>libkf5activities5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5archive5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5bookmarks5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5codecs5 (&gt;= 4.96.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5completion5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5configcore5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5configgui5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5configwidgets5 (&gt;= 5.83.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5coreaddons5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5crash5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5i18n5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5itemviews5 (&gt;= 4.96.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5jobwidgets5 (&gt;= 4.96.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5kexiv2-15.0.0 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5kiocore5 (&gt;= 5.69.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5kiogui5 (&gt;= 5.69.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5kiowidgets5 (&gt;= 5.69.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5parts5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5pty5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5purpose-bin</code> <em>(Debian Bookworm)</em>; <code>libkf5purpose5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5textwidgets5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5wallet-bin</code> <em>(Debian Bookworm)</em>; <code>libkf5wallet5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5widgetsaddons5 (&gt;= 5.77.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5windowsystem5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5xmlgui5 (&gt;= 5.80.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libokular5core10"><code>libokular5core10 (= 4:22.12.3-1+deb12u1+core2.1~BUILD)</code></a>; <code>libphonon4qt5-4 (&gt;= 4:4.8.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpoppler-qt5-1"><code>libpoppler-qt5-1 (&gt;= 22.02.0)</code></a>; <code>libqmobipocket2 (&gt;= 4:17.08~)</code> <em>(Debian Bookworm)</em>; <code>libqt5core5a (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5dbus5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5printsupport5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5texttospeech5 (&gt;= 5.12.0~)</code> <em>(Debian Bookworm)</em>; <code>libqt5widgets5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5xml5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libspectre1 (&gt;= 0.2.3)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <code>phonon4qt5</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-okular-extra-backends"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453">okular-extra-backends 4:22.12.3-1+deb12u1</a></code></summary>

- **Depends:** <code>kio</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <code>libchm1 (&gt;= 0.40)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdjvulibre21"><code>libdjvulibre21 (&gt;= 3.5.28)</code></a>; <a href="#core2-package-libepub0"><code>libepub0 (&gt;= 0.1.1)</code></a>; <code>libkf5configcore5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5configwidgets5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5coreaddons5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5i18n5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5khtml5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5kiocore5 (&gt;= 5.69.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5parts5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libmarkdown2 (&gt;= 2.0.6)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libokular5core10"><code>libokular5core10 (= 4:22.12.3-1+deb12u1+core2.1~BUILD)</code></a>; <code>libqt5core5a (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5printsupport5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5widgets5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5xml5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.0.3)</code></a>; <code>libzip4 (&gt;= 0.10)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-okular-mobile"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453">okular-mobile 4:22.12.3-1+deb12u1</a></code></summary>

- **Depends:** <code>qml-module-org-kde-kirigami2 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>qml-module-org-kde-kquickcontrolsaddons (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-qml-module-org-kde-okular"><code>qml-module-org-kde-okular (= 4:22.12.3-1+deb12u1+core2.1~BUILD)</code></a>; <code>qml-module-qtgraphicaleffects (&gt;= 5.12.0~)</code> <em>(Debian Bookworm)</em>; <code>qml-module-qtquick-controls2 (&gt;= 5.12.0~)</code> <em>(Debian Bookworm)</em>; <code>qml-module-qtquick-dialogs (&gt;= 5.12.0~)</code> <em>(Debian Bookworm)</em>; <code>qml-module-qtquick-layouts (&gt;= 5.12.0~)</code> <em>(Debian Bookworm)</em>; <code>qml-module-qtquick2 (&gt;= 5.12.0~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libkf5coreaddons5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5i18n5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libqt5core5a (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5qml5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5widgets5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 4.1.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-openmpt123"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libopenmpt-0.6.9-1-core2.1-20261016143234">openmpt123 0.6.9-1 — module music library based on OpenMPT -- music player</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libflac12"><code>libflac12 (&gt;= 1.3.0)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libopenmpt0"><code>libopenmpt0 (&gt;= 0.5.10)</code></a>; <code>libportaudio2 (&gt;= 19+svn20101113)</code> <em>(Debian Bookworm)</em>; <code>libpulse0 (&gt;= 0.99.1)</code> <em>(Debian Bookworm)</em>; <code>libsndfile1 (&gt;= 1.0.20)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-p11-kit"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-p11-kit-0.24.1-2-core2.1-20261020161738">p11-kit 0.24.1-2 — p11-glue utilities</a></code></summary>

- **Depends:** <a href="#core2-package-p11-kit-modules"><code>p11-kit-modules (&gt;= 0.24.1-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libp11-kit0"><code>libp11-kit0 (&gt;= 0.23.18.1)</code></a>; <a href="#core2-package-libtasn1-6"><code>libtasn1-6 (&gt;= 4.14)</code></a>

</details>

<details>
<summary id="core2-package-p11-kit-modules"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-p11-kit-0.24.1-2-core2.1-20261020161738">p11-kit-modules 0.24.1-2</a></code></summary>

- **Depends:** <a href="#core2-package-libp11-kit0"><code>libp11-kit0 (= 0.24.1-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libffi8"><code>libffi8 (&gt;= 3.4)</code></a>; <a href="#core2-package-libtasn1-6"><code>libtasn1-6 (&gt;= 4.14)</code></a>

</details>

<details>
<summary id="core2-package-pango1.0-tests"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751">pango1.0-tests 1.50.12+ds-1</a></code></summary>

- **Depends:** <code>fonts-cantarell</code> <em>(Debian Bookworm)</em>; <code>fonts-noto-color-emoji</code> <em>(Debian Bookworm)</em>; <code>fonts-noto-core</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.12.10)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.13.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62.0)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 2.6.0)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libpangoft2-1.0-0"><code>libpangoft2-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-pango1.0-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751">pango1.0-tools 1.50.12+ds-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.12.10)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.13.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.62.0)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 5.1.0)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libpangocairo-1.0-0"><code>libpangocairo-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libpangoft2-1.0-0"><code>libpangoft2-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libpangoxft-1.0-0"><code>libpangoxft-1.0-0 (= 1.50.12+ds-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <code>libxft2 (&gt;&gt; 2.1.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-pcre2-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649">pcre2-utils 10.42-1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libpcre2-16-0"><code>libpcre2-16-0 (&gt;= 10.34)</code></a>; <a href="#core2-package-libpcre2-32-0"><code>libpcre2-32-0 (&gt;= 10.34)</code></a>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.34)</code></a>; <a href="#core2-package-libpcre2-posix3"><code>libpcre2-posix3 (&gt;= 10.34)</code></a>

</details>

<details>
<summary id="core2-package-poppler-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344">poppler-utils 22.12.0-2+deb12u3</a></code></summary>

- **Depends:** <a href="#core2-package-libpoppler126"><code>libpoppler126 (= 22.12.0-2+deb12u3+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.12.0)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-liblcms2-2"><code>liblcms2-2 (&gt;= 2.2+git20110628)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-psmisc"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-psmisc-23.6-1-core2.1-20261009192718">psmisc 23.6-1 — utilities that use the proc file system</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>

</details>

<details>
<summary id="core2-package-qml-module-org-kde-okular"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453">qml-module-org-kde-okular 4:22.12.3-1+deb12u1</a></code></summary>

- **Depends:** <code>qml-module-org-kde-kirigami2 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>qml-module-qtgraphicaleffects (&gt;= 5.12.0~)</code> <em>(Debian Bookworm)</em>; <code>qml-module-qtquick-controls2 (&gt;= 5.12.0~)</code> <em>(Debian Bookworm)</em>; <code>qml-module-qtquick2 (&gt;= 5.12.0~)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <code>libkf5bookmarks5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5configcore5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5configgui5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5coreaddons5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5i18n5 (&gt;= 5.68.0~)</code> <em>(Debian Bookworm)</em>; <code>libkf5service-bin</code> <em>(Debian Bookworm)</em>; <code>libkf5service5 (&gt;= 4.96.0)</code> <em>(Debian Bookworm)</em>; <code>libkf5widgetsaddons5 (&gt;= 4.96.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libokular5core10"><code>libokular5core10 (= 4:22.12.3-1+deb12u1+core2.1~BUILD)</code></a>; <code>libqt5core5a (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5qml5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5quick5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em> | <code>libqt5quick5-gles (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5widgets5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libqt5xml5 (&gt;= 5.15.2~)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-qpdfview"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-qpdfview-0.5.0-ds-2-core2.1-20261012055504">qpdfview 0.5.0+ds-2 — tabbed document viewer</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcups2"><code>libcups2 (&gt;= 1.4.0)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libqt5concurrent5 (&gt;= 5.6.0~rc)</code> <em>(Debian Bookworm)</em>; <code>libqt5core5a (&gt;= 5.15.1)</code> <em>(Debian Bookworm)</em>; <code>libqt5dbus5 (&gt;= 5.14.1)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.12.2)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.12.2)</code> <em>(Debian Bookworm)</em>; <code>libqt5printsupport5 (&gt;= 5.0.2)</code> <em>(Debian Bookworm)</em>; <code>libqt5sql5 (&gt;= 5.0.2)</code> <em>(Debian Bookworm)</em>; <code>libqt5widgets5 (&gt;= 5.11.0~rc1)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 4.1.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsynctex2"><code>libsynctex2 (&gt;= 2022.20220321.62855)</code></a>; <a href="#core2-package-hicolor-icon-theme"><code>hicolor-icon-theme</code></a>; <code>libqt5sql5-sqlite</code> <em>(Debian Bookworm)</em>; <code>libqt5svg5</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-qpdfview-pdf-poppler-plugin"><code>qpdfview-pdf-poppler-plugin</code></a>

</details>

<details>
<summary id="core2-package-qpdfview-djvu-plugin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-qpdfview-0.5.0-ds-2-core2.1-20261012055504">qpdfview-djvu-plugin 0.5.0+ds-2</a></code></summary>

- **Depends:** <a href="#core2-package-qpdfview"><code>qpdfview (= 0.5.0+ds-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <a href="#core2-package-libdjvulibre21"><code>libdjvulibre21 (&gt;= 3.5.28)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libqt5core5a (&gt;= 5.15.1)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.2.0)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.2.0)</code> <em>(Debian Bookworm)</em>; <code>libqt5widgets5 (&gt;= 5.0.2)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 4.1.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-qpdfview-pdf-poppler-plugin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-qpdfview-0.5.0-ds-2-core2.1-20261012055504">qpdfview-pdf-poppler-plugin 0.5.0+ds-2</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpoppler-qt5-1"><code>libpoppler-qt5-1 (&gt;= 0.81.0)</code></a>; <code>libqt5core5a (&gt;= 5.15.1)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.0.2)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.0.2)</code> <em>(Debian Bookworm)</em>; <code>libqt5widgets5 (&gt;= 5.14.1)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 4.1.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-qpdfview-ps-plugin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-qpdfview-0.5.0-ds-2-core2.1-20261012055504">qpdfview-ps-plugin 0.5.0+ds-2</a></code></summary>

- **Depends:** <a href="#core2-package-qpdfview"><code>qpdfview (= 0.5.0+ds-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libqt5core5a (&gt;= 5.15.1)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.0.2)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.0.2)</code> <em>(Debian Bookworm)</em>; <code>libqt5widgets5 (&gt;= 5.0.2)</code> <em>(Debian Bookworm)</em>; <code>libspectre1 (&gt;= 0.2.3)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 4.1.1)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-qpdfview-translations"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-qpdfview-0.5.0-ds-2-core2.1-20261012055504">qpdfview-translations 0.5.0+ds-2</a></code></summary>

- **Depends:** <a href="#core2-package-qpdfview"><code>qpdfview (&gt;= 0.5.0+ds-2+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-readline-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-readline-8.2-1.3-core2.1-20261009161033">readline-common 8.2-1.3</a></code></summary>

- **Depends:** one of: <code>dpkg (&gt;= 1.15.4)</code> <em>(Debian Bookworm)</em> | <code>install-info</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-rlfe"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-readline-8.2-1.3-core2.1-20261009161033">rlfe 8.2-1.3 — Front-end using readline to "cook" input lines for other programs</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libreadline8"><code>libreadline8</code></a>

</details>

<details>
<summary id="core2-package-seccomp"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libseccomp-2.5.4-1-deb12u1-core2.1-20261017010131">seccomp 2.5.4-1+deb12u1 — helper tools for high level interface to Linux seccomp filter</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libseccomp2"><code>libseccomp2 (&gt;= 2.2.1)</code></a>

</details>

<details>
<summary id="core2-package-selinux-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-system-libselinux-3.4-1-core2.1-20261009190433">selinux-utils 3.4-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libpcre2-8-0"><code>libpcre2-8-0 (&gt;= 10.22)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <a href="#core2-package-libsepol2"><code>libsepol2 (&gt;= 3.4)</code></a>

</details>

<details>
<summary id="core2-package-semanage-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libsemanage-3.4-1-core2.1-20261020161025">semanage-utils 3.4-1 — SELinux policy management utilities</a></code></summary>

- **Depends:** <a href="#core2-package-libsepol2"><code>libsepol2 (&gt;= 3.4)</code></a>; <code>python3 (&gt;= 3.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-python3-selinux"><code>python3-selinux (&gt;= 3.4)</code></a>; <a href="#core2-package-python3-semanage"><code>python3-semanage (&gt;= 3.4)</code></a>

</details>

<details>
<summary id="core2-package-sepol-utils"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libsepol-3.4-2.1-core2.1-20261020161145">sepol-utils 3.4-2.1 — Security Enhanced Linux policy utility programs</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libsepol2"><code>libsepol2 (&gt;= 3.4)</code></a>

</details>

<details>
<summary id="core2-package-sfk"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-sfk-2.0.0-git50bbdede-20261022175640">sfk 2.0.0+git50bbdede-1 — Swiss File Knife command-line toolkit</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6</code></a>; <code>libgcc-s1</code> <em>(Debian Bookworm)</em>; <code>libstdc++6</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-shared-mime-info"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-shared-mime-info-2.2-1-core2.1-20261020161923">shared-mime-info 2.2-1 — FreeDesktop.org shared MIME database and spec</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.35.9)</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>

</details>

<details>
<summary id="core2-package-slsh"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-slang2-2.3.3-3-core2.1-20261012055155">slsh 2.3.3-3</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libslang2"><code>libslang2 (&gt;= 2.3.0)</code></a>; <a href="#core2-package-libslang2-modules"><code>libslang2-modules (= 2.3.3-3+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-svt-av1"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-svt-av1-1.4.1-dfsg-1-core2.1-20261016144712">svt-av1 1.4.1+dfsg-1 — Scalable Video Technology for AV1 (SVT-AV1 Encoder and Decoder)</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libsvtav1dec0"><code>libsvtav1dec0 (&gt;= 1.4.1+dfsg)</code></a>; <a href="#core2-package-libsvtav1enc1"><code>libsvtav1enc1 (&gt;= 1.4.1+dfsg)</code></a>

</details>

<details>
<summary id="core2-package-telegram-desktop"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-telegram-desktop-4.6.5-ds-2-core2.1-20261017193804">telegram-desktop 4.6.5+ds-2 — fast and secure messaging application</a></code></summary>

- **Depends:** <code>qt5-image-formats-plugins</code> <em>(Debian Bookworm)</em>; <code>libabsl20220623 (&gt;= 0~20220623.0-1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libavcodec59"><code>libavcodec59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavformat59"><code>libavformat59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (&gt;= 7:5.1)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.40.0)</code></a>; <code>libglibmm-2.68-1 (&gt;= 2.74.0)</code> <em>(Debian Bookworm)</em>; <code>libhunspell-1.7-0</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <code>libkf5coreaddons5 (&gt;= 5.96.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-liblz4-1"><code>liblz4-1 (&gt;= 0.0~r130)</code></a>; <code>libminizip1 (&gt;= 1.1)</code> <em>(Debian Bookworm)</em>; <code>libopenal1 (&gt;= 1.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libopus0"><code>libopus0 (&gt;= 1.1)</code></a>; <code>libqrcodegencpp1 (&gt;= 1.2.1)</code> <em>(Debian Bookworm)</em>; <code>libqt5core5a (&gt;= 5.15.2)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.15.2)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.15.2)</code> <em>(Debian Bookworm)</em>; <code>libqt5network5 (&gt;= 5.15.2)</code> <em>(Debian Bookworm)</em>; <code>libqt5qml5 (&gt;= 5.15.2)</code> <em>(Debian Bookworm)</em>; <code>libqt5quickwidgets5 (&gt;= 5.15.2)</code> <em>(Debian Bookworm)</em>; <code>libqt5svg5 (&gt;= 5.6.0~beta)</code> <em>(Debian Bookworm)</em>; <code>libqt5waylandcompositor5 (&gt;= 5.7.0)</code> <em>(Debian Bookworm)</em>; <code>libqt5widgets5 (&gt;= 5.15.2)</code> <em>(Debian Bookworm)</em>; <code>librlottie0-1 (&gt;= 0~git20200305.a717479+dfsg)</code> <em>(Debian Bookworm)</em>; <code>libsigc++-3.0-0 (&gt;= 2.2.0)</code> <em>(Debian Bookworm)</em>; <code>libsrtp2-1 (&gt;= 2.0.0+20161214)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <code>libstdc++6 (&gt;= 12)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libswresample4"><code>libswresample4 (&gt;= 7:5.1)</code></a>; <a href="#core2-package-libswscale6"><code>libswscale6 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libvpx7"><code>libvpx7 (&gt;= 1.12.0)</code></a>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <code>libxcb-keysyms1 (&gt;= 0.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxcb-record0"><code>libxcb-record0</code></a>; <a href="#core2-package-libxcb-screensaver0"><code>libxcb-screensaver0</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>; <a href="#core2-package-libxcomposite1"><code>libxcomposite1 (&gt;= 1:0.4.5)</code></a>; <a href="#core2-package-libxdamage1"><code>libxdamage1 (&gt;= 1:1.1)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxfixes3"><code>libxfixes3</code></a>; <a href="#core2-package-libxrandr2"><code>libxrandr2 (&gt;= 2:1.5.0)</code></a>; <code>libxtst6</code> <em>(Debian Bookworm)</em>; <code>libxxhash0 (&gt;= 0.6.5)</code> <em>(Debian Bookworm)</em>; <code>qtbase-abi-5-15-8</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-texlive-binaries"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216">texlive-binaries 2022.20220321.62855-5.1+deb12u2</a></code></summary>

- **Depends:** <a href="#core2-package-libptexenc1"><code>libptexenc1 (&gt;= 2022.20220321.62855-5.1+deb12u2+core2.1~BUILD)</code></a>; <a href="#core2-package-libptexenc1"><code>libptexenc1 (&lt;&lt; 2022.20220321.62855-5.1+deb12u2+core2.1~BUILD.1~), libkpathsea6 (&gt;= 2022.20220321.62855-5.1+deb12u2+core2.1~BUILD), libkpathsea6 (&lt;&lt; 2022.20220321.62855-5.1+deb12u2+core2.1~BUILD.1~), libsynctex2 (&gt;= 2022.20220321.62855-5.1+deb12u2+core2.1~BUILD), libsynctex2 (&lt;&lt; 2022.20220321.62855-5.1+deb12u2+core2.1~BUILD.1~), libtexlua53-5 (&gt;= 2022.20220321.62855-5.1+deb12u2+core2.1~BUILD), libtexlua53-5 (&lt;&lt; 2022.20220321.62855-5.1+deb12u2+core2.1~BUILD.1~), libtexluajit2 (&gt;= 2022.20220321.62855-5.1+deb12u2+core2.1~BUILD), libtexluajit2 (&lt;&lt; 2022.20220321.62855-5.1+deb12u2+core2.1~BUILD.1~), t1utils, tex-common, perl:any, libc6 (&gt;= 2.34), libcairo2 (&gt;= 1.2.4), libfontconfig1 (&gt;= 2.12.6), libfreetype6 (&gt;= 2.3.9), libgcc-s1 (&gt;= 4.0), libgraphite2-3 (&gt;= 1.2.2)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 2.6.0)</code></a>; <a href="#core2-package-libicu72"><code>libicu72 (&gt;= 72.1~rc-1~)</code></a>; <a href="#core2-package-libmpfr6"><code>libmpfr6 (&gt;= 3.1.3)</code></a>; <code>libpaper1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0 (&gt;= 0.10.0)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <code>libstdc++6 (&gt;= 5.2)</code> <em>(Debian Bookworm)</em>; <code>libteckit0 (&gt;= 2.5.10+ds1-1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.2.99.901)</code></a>; <code>libxaw7 (&gt;= 2:1.0.14)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxi6"><code>libxi6 (&gt;= 2:1.2.99.4)</code></a>; <code>libxmu6 (&gt;= 2:1.1.3)</code> <em>(Debian Bookworm)</em>; <code>libxpm4</code> <em>(Debian Bookworm)</em>; <code>libxt6</code> <em>(Debian Bookworm)</em>; <code>libzzip-0-13 (&gt;= 0.13.56)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-thunar"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-thunar-4.18.4-1-core2.1-20261010054751">thunar 4.18.4-1 — File Manager for Xfce</a></code></summary>

- **Depends:** <code>desktop-file-utils</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-exo-utils"><code>exo-utils</code></a>; <a href="#core2-package-shared-mime-info"><code>shared-mime-info</code></a>; <a href="#core2-package-thunar-data"><code>thunar-data (= 4.18.4-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libatk1.0-0"><code>libatk1.0-0 (&gt;= 1.12.4)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libexo-2-0"><code>libexo-2-0 (&gt;= 4.17.0)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.65.1)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.21.5)</code></a>; <code>libgudev-1.0-0 (&gt;= 146)</code> <em>(Debian Bookworm)</em>; <code>libice6 (&gt;= 1:1.0.0)</code> <em>(Debian Bookworm)</em>; <code>libnotify4 (&gt;= 0.7.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.44.6)</code></a>; <code>libsm6</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libthunarx-3-0"><code>libthunarx-3-0 (&gt;= 1.7.0)</code></a>; <a href="#core2-package-libxfce4ui-2-0"><code>libxfce4ui-2-0 (&gt;= 4.17.6)</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.17.2)</code></a>; <a href="#core2-package-libxfconf-0-3"><code>libxfconf-0-3 (&gt;= 4.6.0)</code></a>

</details>

<details>
<summary id="core2-package-thunar-data"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-thunar-4.18.4-1-core2.1-20261010054751">thunar-data 4.18.4-1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-tigervnc-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436">tigervnc-common 1.12.0+dfsg-8</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.4.99.1)</code></a>

</details>

<details>
<summary id="core2-package-tigervnc-scraping-server"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436">tigervnc-scraping-server 1.12.0+dfsg-8</a></code></summary>

- **Depends:** <a href="#core2-package-tigervnc-common"><code>tigervnc-common (= 1.12.0+dfsg-8+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.5)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0</code></a>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxdamage1"><code>libxdamage1 (&gt;= 1:1.1)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxfixes3"><code>libxfixes3</code></a>; <a href="#core2-package-libxrandr2"><code>libxrandr2 (&gt;= 2:1.2.0)</code></a>; <code>libxtst6</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <a href="#core2-package-perl"><code>perl:any</code></a>; <code>libfile-readbackwards-perl (&gt;= 1.05)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-tigervnc-standalone-server"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436">tigervnc-standalone-server 1.12.0+dfsg-8</a></code></summary>

- **Depends:** <a href="#core2-package-xkb-data"><code>xkb-data</code></a>; <code>x11-xkb-utils</code> <em>(Debian Bookworm)</em>; <code>xauth</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-tigervnc-common"><code>tigervnc-common (= 1.12.0+dfsg-8+core2.1~BUILD)</code></a>; <a href="#core2-package-libaudit1"><code>libaudit1 (&gt;= 1:2.2.1)</code></a>; <a href="#core2-package-libbsd0"><code>libbsd0 (&gt;= 0.7.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <a href="#core2-package-libgcrypt20"><code>libgcrypt20 (&gt;= 1.10.0)</code></a>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.5)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-libpam0g"><code>libpam0g (&gt;= 0.99.7.1)</code></a>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0 (&gt;= 0.30.0)</code></a>; <a href="#core2-package-libselinux1"><code>libselinux1 (&gt;= 3.1~)</code></a>; <code>libstdc++6 (&gt;= 5.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>; <code>libunwind8</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxau6"><code>libxau6 (&gt;= 1:1.0.9)</code></a>; <a href="#core2-package-libxdmcp6"><code>libxdmcp6</code></a>; <code>libxfont2 (&gt;= 1:2.0.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <a href="#core2-package-perl"><code>perl:any</code></a>; <code>libfile-readbackwards-perl (&gt;= 1.05)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-tigervnc-tools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436">tigervnc-tools 1.12.0+dfsg-8 — Virtual network computing; Tools for both clients and servers</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-tigervnc-viewer"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436">tigervnc-viewer 1.12.0+dfsg-8</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.35)</code></a>; <code>libfltk-images1.3 (&gt;= 1.3.3)</code> <em>(Debian Bookworm)</em>; <code>libfltk1.3 (&gt;= 1.3.4)</code> <em>(Debian Bookworm)</em>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.5)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-libpixman-1-0"><code>libpixman-1-0</code></a>; <code>libstdc++6 (&gt;= 5.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6 (&gt;= 2:1.2.99.901)</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxi6"><code>libxi6 (&gt;= 2:1.5.99.2)</code></a>; <a href="#core2-package-libxrandr2"><code>libxrandr2 (&gt;= 2:1.2.0)</code></a>; <a href="#core2-package-libxrender1"><code>libxrender1</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-tilda"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tilda-1.5.4-1-core2.1-20261020154326">tilda 1.5.4-1 — GTK+ based drop down terminal for Linux and Unix</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libconfuse2"><code>libconfuse2 (&gt;= 3.2.1~)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.21.5)</code></a>; <a href="#core2-package-libpango-1.0-0"><code>libpango-1.0-0 (&gt;= 1.14.0)</code></a>; <a href="#core2-package-libvte-2.91-0"><code>libvte-2.91-0 (&gt;= 0.49.92)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>

</details>

<details>
<summary id="core2-package-tumbler"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tumbler-4.18.0-1-core2.1-20261010054511">tumbler 4.18.0-1 — D-Bus thumbnailing service</a></code></summary>

- **Depends:** <a href="#core2-package-tumbler-common"><code>tumbler-common (= 4.18.0-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.67.1)</code></a>; <a href="#core2-package-libgstreamer-plugins-base1.0-0"><code>libgstreamer-plugins-base1.0-0 (&gt;= 1.0.0)</code></a>; <a href="#core2-package-libgstreamer1.0-0"><code>libgstreamer1.0-0 (&gt;= 1.4.0)</code></a>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-libpoppler-glib8"><code>libpoppler-glib8 (&gt;= 0.85.0)</code></a>; <a href="#core2-package-libtumbler-1-0"><code>libtumbler-1-0 (&gt;= 4.17.2)</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.17.1)</code></a>

</details>

<details>
<summary id="core2-package-tumbler-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tumbler-4.18.0-1-core2.1-20261010054511">tumbler-common 4.18.0-1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-tumbler-plugins-extra"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-tumbler-4.18.0-1-core2.1-20261010054511">tumbler-plugins-extra 4.18.0-1</a></code></summary>

- **Depends:** <a href="#core2-package-tumbler"><code>tumbler (= 4.18.0-1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libcurl3-gnutls"><code>libcurl3-gnutls (&gt;= 7.16.2)</code></a>; <code>libffmpegthumbnailer4v5 (&gt;= 2.2.2+git20220218+dfsg)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.30.1)</code></a>; <code>libgepub-0.7-0 (&gt;= 0.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>; <code>libgsf-1-114 (&gt;= 1.14.24)</code> <em>(Debian Bookworm)</em>; <code>libopenrawgnome7</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtumbler-1-0"><code>libtumbler-1-0 (&gt;= 4.17.2)</code></a>

</details>

<details>
<summary id="core2-package-unar"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-unar-1.10.7-ds1-really1.10.1-2-core2.1-20261012055403">unar 1.10.7+ds1+really1.10.1-2 — Unarchiver for a variety of file formats</a></code></summary>

- **Depends:** <code>gnustep-base-runtime (&gt;= 1.28.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libgnustep-base1.28 (&gt;= 1.28.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libicu72"><code>libicu72 (&gt;= 72.1~rc-1~)</code></a>; <code>libobjc4 (&gt;= 4.2.1)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <code>libwavpack1 (&gt;= 4.40.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.2.0)</code></a>

</details>

<details>
<summary id="core2-package-unzip"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-unzip-6.0-28-deb12u1-core2.1-20261012055157">unzip 6.0-28+deb12u1 — De-archiver for .zip files</a></code></summary>

- **Depends:** <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-va-driver-all"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libva-2.17.0-1-core2.1-20261016135745">va-driver-all 2.17.0-1 — Video Acceleration (VA) API -- driver metapackage</a></code></summary>

- **Depends:** one of: <a href="#core2-package-i965-va-driver"><code>i965-va-driver</code></a> | <code>i965-va-driver-shaders</code> <em>(Debian Bookworm)</em>; one of: <a href="#core2-package-intel-media-va-driver"><code>intel-media-va-driver</code></a> | <code>intel-media-va-driver-non-free</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-mesa-va-drivers"><code>mesa-va-drivers</code></a>

</details>

<details>
<summary id="core2-package-vdpau-driver-all"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libvdpau-1.5-2-core2.1-20261016142429">vdpau-driver-all 1.5-2 — Video Decode and Presentation API for Unix (driver metapackage)</a></code></summary>

- **Depends:** <code>libvdpau-va-gl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-mesa-vdpau-drivers"><code>mesa-vdpau-drivers</code></a>

</details>

<details>
<summary id="core2-package-vlc"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc 3.0.23-0+deb12u1 — multimedia player and streamer</a></code></summary>

- **Depends:** <a href="#core2-package-vlc-bin"><code>vlc-bin (= 3.0.23-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-vlc-plugin-base"><code>vlc-plugin-base (= 3.0.23-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-vlc-plugin-qt"><code>vlc-plugin-qt (= 3.0.23-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-vlc-plugin-video-output"><code>vlc-plugin-video-output (= 3.0.23-0+deb12u1+core2.1~BUILD)</code></a>

</details>

<details>
<summary id="core2-package-vlc-bin"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-bin 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libvlc-bin"><code>libvlc-bin (= 3.0.23-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libvlc5"><code>libvlc5 (&gt;= 3.0.23)</code></a>

</details>

<details>
<summary id="core2-package-vlc-data"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-data 3.0.23-0+deb12u1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-vlc-l10n"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-l10n 3.0.23-0+deb12u1</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-vlc-plugin-access-extra"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-access-extra 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>; <code>libsrt1.5-gnutls (&gt;= 1.5.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <code>libvncclient1 (&gt;= 0.9.10)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxcb-composite0"><code>libxcb-composite0</code></a>; <a href="#core2-package-libxcb-shm0"><code>libxcb-shm0</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1 (&gt;= 1.6)</code></a>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-vlc-plugin-base"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-base 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-vlc-data"><code>vlc-data (= 3.0.23-0+deb12u1+core2.1~BUILD)</code></a>; <code>liba52-0.7.4 (&gt;= 0.7.4)</code> <em>(Debian Bookworm)</em>; <code>libarchive13 (&gt;= 3.1.2)</code> <em>(Debian Bookworm)</em>; <code>libaribb24-0 (&gt;= 1.0.3)</code> <em>(Debian Bookworm)</em>; <code>libasound2 (&gt;= 1.0.27)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libass9"><code>libass9 (&gt;= 1:0.13.6)</code></a>; <a href="#core2-package-libavahi-client3"><code>libavahi-client3 (&gt;= 0.6.16)</code></a>; <a href="#core2-package-libavahi-common3"><code>libavahi-common3 (&gt;= 0.6.16)</code></a>; <code>libavc1394-0 (&gt;= 0.5.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libavcodec59"><code>libavcodec59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavformat59"><code>libavformat59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (&gt;= 7:5.1)</code></a>; <code>libbluray2 (&gt;= 1:1.0.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.13.1)</code></a>; <code>libcddb2 (&gt;= 1.3.2)</code> <em>(Debian Bookworm)</em>; <code>libchromaprint1 (&gt;= 1.3.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libdav1d6"><code>libdav1d6 (&gt;= 0.1.0)</code></a>; <a href="#core2-package-libdbus-1-3"><code>libdbus-1-3 (&gt;= 1.9.14)</code></a>; <code>libdc1394-25 (&gt;= 2.2.6)</code> <em>(Debian Bookworm)</em>; <code>libdca0 (&gt;= 0.0.5)</code> <em>(Debian Bookworm)</em>; <code>libdvbpsi10 (&gt;= 1.3.0)</code> <em>(Debian Bookworm)</em>; <code>libdvdnav4 (&gt;= 6.1.0)</code> <em>(Debian Bookworm)</em>; <code>libdvdread8 (&gt;= 6.1.0)</code> <em>(Debian Bookworm)</em>; <code>libebml5 (&gt;= 1.4.4)</code> <em>(Debian Bookworm)</em>; <code>libfaad2 (&gt;= 2.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libflac12"><code>libflac12 (&gt;= 1.3.0)</code></a>; <a href="#core2-package-libfontconfig1"><code>libfontconfig1 (&gt;= 2.12.6)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-libfribidi0"><code>libfribidi0 (&gt;= 1.0.0)</code></a>; <code>libgcc-s1 (&gt;= 3.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgcrypt20"><code>libgcrypt20 (&gt;= 1.10.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.28.0)</code></a>; <a href="#core2-package-libgnutls30"><code>libgnutls30 (&gt;= 3.7.5)</code></a>; <a href="#core2-package-libgpg-error0"><code>libgpg-error0 (&gt;= 1.14)</code></a>; <a href="#core2-package-libharfbuzz0b"><code>libharfbuzz0b (&gt;= 0.9.4)</code></a>; <code>libixml10 (&gt;= 1:1.8.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <code>libkate1 (&gt;= 0.3.0)</code> <em>(Debian Bookworm)</em>; <code>liblirc-client0</code> <em>(Debian Bookworm)</em>; <code>liblua5.2-0 (&gt;= 5.2.4)</code> <em>(Debian Bookworm)</em>; <code>libmad0 (&gt;= 0.15.1b-3)</code> <em>(Debian Bookworm)</em>; <code>libmatroska7 (&gt;= 1.7.1)</code> <em>(Debian Bookworm)</em>; <code>libmpcdec6 (&gt;= 1:0.1~r435)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libmpeg2-4"><code>libmpeg2-4 (&gt;= 0.5.1)</code></a>; <code>libmpg123-0 (&gt;= 1.28.0)</code> <em>(Debian Bookworm)</em>; <code>libmtp9 (&gt;= 1.1.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libncursesw6"><code>libncursesw6 (&gt;= 6)</code></a>; <code>libnfs13 (&gt;= 1.9.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libogg0"><code>libogg0 (&gt;= 1.1.0)</code></a>; <code>libopenmpt-modplug1 (&gt;= 0.8.9)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libopus0"><code>libopus0 (&gt;= 1.3~beta+20180516)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-libpostproc56"><code>libpostproc56 (&gt;= 7:5.0)</code></a>; <code>libprotobuf-lite32 (&gt;= 3.21.12)</code> <em>(Debian Bookworm)</em>; <code>libpulse0 (&gt;= 1.0)</code> <em>(Debian Bookworm)</em>; <code>libraw1394-11 (&gt;= 2.1.2)</code> <em>(Debian Bookworm)</em>; <code>libresid-builder0c2a</code> <em>(Debian Bookworm)</em>; <code>librsvg2-2 (&gt;= 2.14.4)</code> <em>(Debian Bookworm)</em>; <code>libsamplerate0 (&gt;= 0.1.7)</code> <em>(Debian Bookworm)</em>; <code>libsdl-image1.2 (&gt;= 1.2.10)</code> <em>(Debian Bookworm)</em>; <code>libsdl1.2debian (&gt;= 1.2.15)</code> <em>(Debian Bookworm)</em>; <code>libsecret-1-0 (&gt;= 0.7)</code> <em>(Debian Bookworm)</em>; <code>libshine3 (&gt;= 3.1.0)</code> <em>(Debian Bookworm)</em>; <code>libshout3 (&gt;= 2.2.2)</code> <em>(Debian Bookworm)</em>; <code>libsidplay2</code> <em>(Debian Bookworm)</em>; <code>libsoxr0 (&gt;= 0.1.2)</code> <em>(Debian Bookworm)</em>; <code>libspatialaudio0 (&gt;= 0.3.0+git20180730+dfsg1)</code> <em>(Debian Bookworm)</em>; <code>libspeex1 (&gt;= 1.2~)</code> <em>(Debian Bookworm)</em>; <code>libspeexdsp1 (&gt;= 1.2.1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libssh2-1"><code>libssh2-1 (&gt;= 1.2.3)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libswscale6"><code>libswscale6 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libsystemd0"><code>libsystemd0</code></a>; <code>libtag1v5 (&gt;= 1.11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libtheora0"><code>libtheora0 (&gt;= 1.0)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>; <code>libtwolame0 (&gt;= 0.3.6)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libudev1"><code>libudev1 (&gt;= 183)</code></a>; <code>libupnp13 (&gt;= 1:1.8.3)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libva-drm2"><code>libva-drm2 (&gt;= 1.1.0)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.2.0)</code></a>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <code>libvorbis0a (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <code>libvorbisenc2 (&gt;= 1.1.2)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx264-164"><code>libx264-164 (&gt;= 2:0.164.3095+gitbaee400)</code></a>; <a href="#core2-package-libx265-199"><code>libx265-199 (&gt;= 3.5)</code></a>; <code>libxcb-keysyms1 (&gt;= 0.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>; <a href="#core2-package-libxml2"><code>libxml2 (&gt;= 2.7.4)</code></a>; <code>libzvbi0 (&gt;= 0.2.35)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-vlc-plugin-fluidsynth"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-fluidsynth 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** one of: <code>fluid-soundfont-gm</code> <em>(Debian Bookworm)</em> | <code>timgm6mb-soundfont</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.27)</code></a>; <code>libfluidsynth3 (&gt;= 2.0.5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-vlc-plugin-jack"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-jack 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.8)</code></a>; one of: <code>libjack-jackd2-0 (&gt;= 1.9.10+20150825)</code> <em>(Debian Bookworm)</em> | <code>libjack-0.125</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-vlc-plugin-notify"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-notify 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.8)</code></a>; <a href="#core2-package-libgdk-pixbuf-2.0-0"><code>libgdk-pixbuf-2.0-0 (&gt;= 2.22.0)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.12.0)</code></a>; <a href="#core2-package-libgtk-3-0"><code>libgtk-3-0 (&gt;= 3.0.0)</code></a>; <code>libnotify4 (&gt;= 0.7.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-vlc-plugin-qt"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-qt 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libqt5core5a (&gt;= 5.15.1)</code> <em>(Debian Bookworm)</em>; one of: <code>libqt5gui5 (&gt;= 5.14.1)</code> <em>(Debian Bookworm)</em> | <code>libqt5gui5-gles (&gt;= 5.14.1)</code> <em>(Debian Bookworm)</em>; <code>libqt5svg5 (&gt;= 5.6.0~beta)</code> <em>(Debian Bookworm)</em>; <code>libqt5widgets5 (&gt;= 5.15.1)</code> <em>(Debian Bookworm)</em>; <code>libqt5x11extras5 (&gt;= 5.6.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.0.2)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-vlc-plugin-samba"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-samba 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.8)</code></a>; <code>libsmbclient (&gt;= 2:4.0.3+dfsg1)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-vlc-plugin-skins2"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-skins2 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <code>fonts-freefont-ttf</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-vlc-plugin-qt"><code>vlc-plugin-qt (= 3.0.23-0+deb12u1+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libfreetype6"><code>libfreetype6 (&gt;= 2.2.1)</code></a>; <a href="#core2-package-libfribidi0"><code>libfribidi0 (&gt;= 0.19.2)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <a href="#core2-package-libxext6"><code>libxext6</code></a>; <a href="#core2-package-libxinerama1"><code>libxinerama1 (&gt;= 2:1.1.4)</code></a>; <code>libxpm4</code> <em>(Debian Bookworm)</em>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-vlc-plugin-svg"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-svg 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.33)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.13.1)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.12.0)</code></a>; <code>librsvg2-2 (&gt;= 2.14.4)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-vlc-plugin-video-output"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-video-output 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <code>libaa1 (&gt;= 1.4p5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libavcodec59"><code>libavcodec59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libcaca0 (&gt;= 0.99.beta20)</code> <em>(Debian Bookworm)</em>; <code>libegl1</code> <em>(Debian Bookworm)</em>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <code>libgles2</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libplacebo208"><code>libplacebo208 (&gt;= 4.208.0)</code></a>; <a href="#core2-package-libva-drm2"><code>libva-drm2 (&gt;= 1.1.0)</code></a>; <a href="#core2-package-libva-wayland2"><code>libva-wayland2 (&gt;= 1.3.0)</code></a>; <a href="#core2-package-libva-x11-2"><code>libva-x11-2 (&gt;= 1.0.3)</code></a>; <a href="#core2-package-libva2"><code>libva2 (&gt;= 2.2.0)</code></a>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <a href="#core2-package-libwayland-client0"><code>libwayland-client0 (&gt;= 1.20.0)</code></a>; <a href="#core2-package-libwayland-egl1"><code>libwayland-egl1 (&gt;= 1.15.0)</code></a>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <code>libxcb-keysyms1 (&gt;= 0.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libxcb-shm0"><code>libxcb-shm0</code></a>; <a href="#core2-package-libxcb-xv0"><code>libxcb-xv0 (&gt;= 1.2)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-vlc-plugin-video-splitter"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-video-splitter 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <a href="#core2-package-libxcb-randr0"><code>libxcb-randr0 (&gt;= 1.1)</code></a>; <a href="#core2-package-libxcb1"><code>libxcb1</code></a>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-vlc-plugin-visualization"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852">vlc-plugin-visualization 3.0.23-0+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.29)</code></a>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libvlccore9"><code>libvlccore9 (&gt;= 3.0.23)</code></a>; <code>vlc-plugin-abi-3-0-0f</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-w3m"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-w3m-0.5.3-git20230121-2-core2.1-20261012055311">w3m 0.5.3+git20230121-2 — WWW browsable pager with excellent tables/frames support</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgc1 (&gt;= 1:7.2d)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libgpm2"><code>libgpm2 (&gt;= 1.20.7)</code></a>; <a href="#core2-package-libssl3"><code>libssl3 (&gt;= 3.0.0)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>; <a href="#core2-package-zlib1g"><code>zlib1g (&gt;= 1:1.1.4)</code></a>

</details>

<details>
<summary id="core2-package-w3m-img"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-w3m-0.5.3-git20230121-2-core2.1-20261012055311">w3m-img 0.5.3+git20230121-2</a></code></summary>

- **Depends:** <a href="#core2-package-w3m"><code>w3m (= 0.5.3+git20230121-2+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libimlib2 (&gt;= 1.4.5)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>

</details>

<details>
<summary id="core2-package-webp"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-libwebp-1.2.4-0.2-deb12u1-core2.1-20261011064208">webp 1.2.4-0.2+deb12u1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgif7 (&gt;= 5.1)</code> <em>(Debian Bookworm)</em>; <code>libgl1</code> <em>(Debian Bookworm)</em>; <code>libglut3.12 (&gt;= 3.4.0)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libjpeg62-turbo"><code>libjpeg62-turbo (&gt;= 1.3.1)</code></a>; <a href="#core2-package-libpng16-16"><code>libpng16-16 (&gt;= 1.6.2-1)</code></a>; <a href="#core2-package-libtiff6"><code>libtiff6 (&gt;= 4.0.3)</code></a>; <a href="#core2-package-libwebp7"><code>libwebp7 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libwebpdemux2"><code>libwebpdemux2 (&gt;= 1.2.4)</code></a>; <a href="#core2-package-libwebpmux3"><code>libwebpmux3 (&gt;= 1.2.4)</code></a>

</details>

<details>
<summary id="core2-package-wimtools"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-wimlib-1.13.6-1-core2.1-20261012055555">wimtools 1.13.6-1 — Tools for manipulating Windows Imaging files</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libwim15"><code>libwim15 (&gt;= 1.13.0)</code></a>

</details>

<details>
<summary id="core2-package-wodim"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-cdrkit-9-1.1.11-3.4-core2.1-20261012055245">wodim 9:1.1.11-3.4</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>

</details>

<details>
<summary id="core2-package-x264"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-x264-2-0.164.3095-gitbaee400-3-core2.1-20261016145121">x264 2:0.164.3095+gitbaee400-3 — video encoder for the H.264/MPEG-4 AVC standard</a></code></summary>

- **Depends:** <a href="#core2-package-libavcodec59"><code>libavcodec59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavformat59"><code>libavformat59 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libavutil57"><code>libavutil57 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libffms2-5 (&gt;= 2.21)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libswscale6"><code>libswscale6 (&gt;= 7:5.0)</code></a>; <a href="#core2-package-libx264-164"><code>libx264-164 (&gt;= 2:0.164.3095+gitbaee400)</code></a>

</details>

<details>
<summary id="core2-package-xfconf"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xfconf-4.18.0-2-core2.1-20261010053410">xfconf 4.18.0-2 — utilities for managing settings in Xfce</a></code></summary>

- **Depends:** one of: <code>default-dbus-session-bus</code> <em>(Debian Bookworm)</em> | <code>dbus-session-bus</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.55.2)</code></a>; <a href="#core2-package-libxfce4util7"><code>libxfce4util7 (&gt;= 4.17.3)</code></a>

</details>

<details>
<summary id="core2-package-xkb-data"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xkeyboard-config-2.35.1-1-core2.1-20261020162047">xkb-data 2.35.1-1 — X Keyboard Extension (XKB) configuration data</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-xpdf"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-xpdf-3.04-git20220601-1-core2.1-20261012055410">xpdf 3.04+git20220601-1 — Motif-based PDF reader using the Poppler library</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <code>libgcc-s1 (&gt;= 3.0)</code> <em>(Debian Bookworm)</em>; <code>libpaper1</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libpoppler126"><code>libpoppler126 (&gt;= 22.12.0)</code></a>; <code>libstdc++6 (&gt;= 11)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libx11-6"><code>libx11-6</code></a>; <code>libxm4 (&gt;= 2.3.4)</code> <em>(Debian Bookworm)</em>; <code>libxt6</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-zathura-pdf-poppler"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-zathura-pdf-poppler-0.3.1-1-core2.1-20261012055457">zathura-pdf-poppler 0.3.1-1 — PDF support for zathura</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.4)</code></a>; <a href="#core2-package-libcairo2"><code>libcairo2 (&gt;= 1.10.0)</code></a>; <code>libgirara-gtk3-3 (&gt;= 0.2.7)</code> <em>(Debian Bookworm)</em>; <a href="#core2-package-libglib2.0-0"><code>libglib2.0-0 (&gt;= 2.16.0)</code></a>; <a href="#core2-package-libpoppler-glib8"><code>libpoppler-glib8 (&gt;= 0.18.0)</code></a>; <code>zathura-abi-5</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-zip"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-zip-3.0-13-deb12u1-core2.1-20261011040024">zip 3.0-13+deb12u1 — Archiver for .zip files</a></code></summary>

- **Depends:** <a href="#core2-package-libbz2-1.0"><code>libbz2-1.0</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>

</details>

<details>
<summary id="core2-package-zlib1g"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-zlib-1-1.2.13.dfsg-1-core2.1-20261016151112">zlib1g 1:1.2.13.dfsg-1</a></code></summary>

- **Depends:** <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.14)</code></a>

</details>

<details>
<summary id="core2-package-zsh"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-zsh-5.9-4-core2.1-20261009061847">zsh 5.9-4 — shell with lots of features</a></code></summary>

- **Depends:** <a href="#core2-package-zsh-common"><code>zsh-common (= 5.9-4+core2.1~BUILD)</code></a>; <a href="#core2-package-libc6"><code>libc6 (&gt;= 2.34)</code></a>; <a href="#core2-package-libcap2"><code>libcap2 (&gt;= 1:2.10)</code></a>; <a href="#core2-package-libtinfo6"><code>libtinfo6 (&gt;= 6)</code></a>; <code>debianutils (&gt;= 5.3-1~)</code> <em>(Debian Bookworm)</em>

</details>

<details>
<summary id="core2-package-zsh-common"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-zsh-5.9-4-core2.1-20261009061847">zsh-common 5.9-4</a></code></summary>

- No declared Pre-Depends or Depends.

</details>

<details>
<summary id="core2-package-zsh-static"><code><a href="https://github.com/AmrUser-48/linux/releases/tag/core2-zsh-5.9-4-core2.1-20261009061847">zsh-static 5.9-4</a></code></summary>

- **Depends:** <code>debianutils (&gt;= 5.3-1~)</code> <em>(Debian Bookworm)</em>

</details>

</details>

**Runtime binary packages in tree:** 800. Development, documentation, and debug packages remain in the download index.
<!-- CORE2-PACKAGE-DEPENDENCY-TREE:END -->

## Latest package releases

One latest published release per Debian source package is listed here. Direct links are provided for installable .deb files; the linked release page contains build metadata, checksums, full release notes, and historical builds.

<!-- CORE2-PACKAGE-RELEASE-INDEX:START -->
### libebur128-1 (optimized)
Version: `1.2.6-1+core2.1~20261023221125` · Published: 2026-10-23 22:20:11 UTC
**Description:** implementation of the EBU R128 loudness standard
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libebur128-1`

**Binary downloads:**
- [libebur128-1_1.2.6-1+core2.1.20261023221125_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libebur128-1-1.2.6-1-core2.1-20261023221125/libebur128-1_1.2.6-1%2Bcore2.1.20261023221125_amd64.deb)
- [libebur128-dev_1.2.6-1+core2.1.20261023221125_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libebur128-1-1.2.6-1-core2.1-20261023221125/libebur128-dev_1.2.6-1%2Bcore2.1.20261023221125_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libebur128-1-1.2.6-1-core2.1-20261023221125)

### SoX NG (system)
Version: `14.8.1+core2.1~20261023214105` · Published: 2026-10-23 21:42:00 UTC
**Description:** Swiss Army knife of sound processing (SoX NG)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - sox-ng`

**Binary downloads:**
- [libsox-ng5_14.8.1+core2.1.20261023214105_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-sox-ng-14.8.1-core2.1-20261023214105/libsox-ng5_14.8.1%2Bcore2.1.20261023214105_amd64.deb)
- [sox-ng_14.8.1+core2.1.20261023214105_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-sox-ng-14.8.1-core2.1-20261023214105/sox-ng_14.8.1%2Bcore2.1.20261023214105_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-sox-ng-14.8.1-core2.1-20261023214105)

### Opus (optimized)
Version: `1.3.1-3+core2.1~20261023192526` · Published: 2026-10-23 19:27:26 UTC
**Description:** Opus codec runtime library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - opus`

**Binary downloads:**
- [libopus-dev_1.3.1-3+core2.1.20261023192526_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-opus-1.3.1-3-core2.1-20261023192526/libopus-dev_1.3.1-3%2Bcore2.1.20261023192526_amd64.deb)
- [libopus-doc_1.3.1-3+core2.1.20261023192526_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-opus-1.3.1-3-core2.1-20261023192526/libopus-doc_1.3.1-3%2Bcore2.1.20261023192526_all.deb)
- [libopus0_1.3.1-3+core2.1.20261023192526_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-opus-1.3.1-3-core2.1-20261023192526/libopus0_1.3.1-3%2Bcore2.1.20261023192526_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-opus-1.3.1-3-core2.1-20261023192526)

### flac (optimized)
Version: `1.4.2+ds-2+core2.1~20261023192521` · Published: 2026-10-23 19:26:46 UTC
**Description:** Free Lossless Audio Codec - command line tools
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - flac`

**Binary downloads:**
- [flac_1.4.2+ds-2+core2.1.20261023192521_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-flac-1.4.2-ds-2-core2.1-20261023192521/flac_1.4.2%2Bds-2%2Bcore2.1.20261023192521_amd64.deb)
- [libflac++-dev_1.4.2+ds-2+core2.1.20261023192521_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-flac-1.4.2-ds-2-core2.1-20261023192521/libflac%2B%2B-dev_1.4.2%2Bds-2%2Bcore2.1.20261023192521_amd64.deb)
- [libflac++10_1.4.2+ds-2+core2.1.20261023192521_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-flac-1.4.2-ds-2-core2.1-20261023192521/libflac%2B%2B10_1.4.2%2Bds-2%2Bcore2.1.20261023192521_amd64.deb)
- [libflac-dev_1.4.2+ds-2+core2.1.20261023192521_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-flac-1.4.2-ds-2-core2.1-20261023192521/libflac-dev_1.4.2%2Bds-2%2Bcore2.1.20261023192521_amd64.deb)
- [libflac-doc_1.4.2+ds-2+core2.1.20261023192521_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-flac-1.4.2-ds-2-core2.1-20261023192521/libflac-doc_1.4.2%2Bds-2%2Bcore2.1.20261023192521_all.deb)
- [libflac12_1.4.2+ds-2+core2.1.20261023192521_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-flac-1.4.2-ds-2-core2.1-20261023192521/libflac12_1.4.2%2Bds-2%2Bcore2.1.20261023192521_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-flac-1.4.2-ds-2-core2.1-20261023192521)

### libopusenc (optimized)
Version: `0.2.1-2+core2.1~20261023192524` · Published: 2026-10-23 19:26:17 UTC
**Description:** High-level API for encoding Opus audio streams (library)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libopusenc`

**Binary downloads:**
- [libopusenc-dev_0.2.1-2+core2.1.20261023192524_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libopusenc-0.2.1-2-core2.1-20261023192524/libopusenc-dev_0.2.1-2%2Bcore2.1.20261023192524_amd64.deb)
- [libopusenc-doc_0.2.1-2+core2.1.20261023192524_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libopusenc-0.2.1-2-core2.1-20261023192524/libopusenc-doc_0.2.1-2%2Bcore2.1.20261023192524_all.deb)
- [libopusenc0_0.2.1-2+core2.1.20261023192524_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libopusenc-0.2.1-2-core2.1-20261023192524/libopusenc0_0.2.1-2%2Bcore2.1.20261023192524_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libopusenc-0.2.1-2-core2.1-20261023192524)

### opusfile (optimized)
Version: `0.12-4+core2.1~20261023192513` · Published: 2026-10-23 19:26:06 UTC
**Description:** High-level API for basic manipulation of Ogg Opus audio streams
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - opusfile`

**Binary downloads:**
- [libopusfile-dev_0.12-4+core2.1.20261023192513_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-opusfile-0.12-4-core2.1-20261023192513/libopusfile-dev_0.12-4%2Bcore2.1.20261023192513_amd64.deb)
- [libopusfile-doc_0.12-4+core2.1.20261023192513_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-opusfile-0.12-4-core2.1-20261023192513/libopusfile-doc_0.12-4%2Bcore2.1.20261023192513_all.deb)
- [libopusfile0_0.12-4+core2.1.20261023192513_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-opusfile-0.12-4-core2.1-20261023192513/libopusfile0_0.12-4%2Bcore2.1.20261023192513_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-opusfile-0.12-4-core2.1-20261023192513)

### Opus Tools (optimized)
Version: `0.2-1+core2.1~20261023192504` · Published: 2026-10-23 19:25:58 UTC
**Description:** Opus codec command line tools
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - opus-tools`

**Binary downloads:**
- [opus-tools_0.2-1+core2.1.20261023192504_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-opus-tools-0.2-1-core2.1-20261023192504/opus-tools_0.2-1%2Bcore2.1.20261023192504_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-opus-tools-0.2-1-core2.1-20261023192504)

### libogg (optimized)
Version: `1.3.5-3+core2.1~20261023192506` · Published: 2026-10-23 19:25:57 UTC
**Description:** Ogg bitstream library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libogg`

**Binary downloads:**
- [libogg-dev_1.3.5-3+core2.1.20261023192506_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libogg-1.3.5-3-core2.1-20261023192506/libogg-dev_1.3.5-3%2Bcore2.1.20261023192506_amd64.deb)
- [libogg0_1.3.5-3+core2.1.20261023192506_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libogg-1.3.5-3-core2.1-20261023192506/libogg0_1.3.5-3%2Bcore2.1.20261023192506_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libogg-1.3.5-3-core2.1-20261023192506)

### Swiss File Knife (SFK) (optimized)
Version: `2.0.0+git50bbdede-1+core2.1~20261022175640` · Published: 2026-10-22 17:57:32 UTC
**Description:** Swiss File Knife command-line toolkit
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - sfk`

**Binary downloads:**
- [sfk_2.0.0+git50bbdede-1+core2.1.20261022175640_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-sfk-2.0.0-git50bbdede-20261022175640/sfk_2.0.0%2Bgit50bbdede-1%2Bcore2.1.20261022175640_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-sfk-2.0.0-git50bbdede-20261022175640)

### feh (optimized)
Version: `3.9.1-2+core2.1~20261020171043` · Published: 2026-10-20 17:12:23 UTC
**Description:** imlib2 based image viewer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - feh`

**Binary downloads:**
- [feh_3.9.1-2+core2.1.20261020171043_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-feh-3.9.1-2-core2.1-20261020171043/feh_3.9.1-2%2Bcore2.1.20261020171043_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-feh-3.9.1-2-core2.1-20261020171043)

### libzstd (optimized)
Version: `1.5.4+dfsg2-5+core2.1~20261020161546` · Published: 2026-10-20 16:27:16 UTC
**Description:** fast lossless compression algorithm
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libzstd`

**Binary downloads:**
- [libzstd-dev_1.5.4+dfsg2-5+core2.1.20261020161546_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libzstd-1.5.4-dfsg2-5-core2.1-20261020161546/libzstd-dev_1.5.4%2Bdfsg2-5%2Bcore2.1.20261020161546_amd64.deb)
- [libzstd1_1.5.4+dfsg2-5+core2.1.20261020161546_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libzstd-1.5.4-dfsg2-5-core2.1-20261020161546/libzstd1_1.5.4%2Bdfsg2-5%2Bcore2.1.20261020161546_amd64.deb)
- [zstd_1.5.4+dfsg2-5+core2.1.20261020161546_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libzstd-1.5.4-dfsg2-5-core2.1-20261020161546/zstd_1.5.4%2Bdfsg2-5%2Bcore2.1.20261020161546_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libzstd-1.5.4-dfsg2-5-core2.1-20261020161546)

### vte2.91 (optimized)
Version: `0.70.6-2~deb12u1+core2.1~20261020162049` · Published: 2026-10-20 16:26:02 UTC
**Description:** GObject introspection data for the VTE library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - vte2.91`

**Binary downloads:**
- [gir1.2-vte-2.91_0.70.6-2.deb12u1+core2.1.20261020162049_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049/gir1.2-vte-2.91_0.70.6-2.deb12u1%2Bcore2.1.20261020162049_amd64.deb)
- [gir1.2-vte-3.91_0.70.6-2.deb12u1+core2.1.20261020162049_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049/gir1.2-vte-3.91_0.70.6-2.deb12u1%2Bcore2.1.20261020162049_amd64.deb)
- [libvte-2.91-0_0.70.6-2.deb12u1+core2.1.20261020162049_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049/libvte-2.91-0_0.70.6-2.deb12u1%2Bcore2.1.20261020162049_amd64.deb)
- [libvte-2.91-common_0.70.6-2.deb12u1+core2.1.20261020162049_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049/libvte-2.91-common_0.70.6-2.deb12u1%2Bcore2.1.20261020162049_amd64.deb)
- [libvte-2.91-dev_0.70.6-2.deb12u1+core2.1.20261020162049_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049/libvte-2.91-dev_0.70.6-2.deb12u1%2Bcore2.1.20261020162049_amd64.deb)
- [libvte-2.91-doc_0.70.6-2.deb12u1+core2.1.20261020162049_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049/libvte-2.91-doc_0.70.6-2.deb12u1%2Bcore2.1.20261020162049_all.deb)
- [libvte-2.91-gtk4-0_0.70.6-2.deb12u1+core2.1.20261020162049_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049/libvte-2.91-gtk4-0_0.70.6-2.deb12u1%2Bcore2.1.20261020162049_amd64.deb)
- [libvte-2.91-gtk4-dev_0.70.6-2.deb12u1+core2.1.20261020162049_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049/libvte-2.91-gtk4-dev_0.70.6-2.deb12u1%2Bcore2.1.20261020162049_amd64.deb)
- [libvte-2.91-gtk4-doc_0.70.6-2.deb12u1+core2.1.20261020162049_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049/libvte-2.91-gtk4-doc_0.70.6-2.deb12u1%2Bcore2.1.20261020162049_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-vte2.91-0.70.6-2-deb12u1-core2.1-20261020162049)

### lz4 (optimized)
Version: `1.9.4-1+core2.1~20261020161626` · Published: 2026-10-20 16:23:20 UTC
**Description:** Fast LZ compression algorithm library - tool
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - lz4`

**Binary downloads:**
- [liblz4-1_1.9.4-1+core2.1.20261020161626_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lz4-1.9.4-1-core2.1-20261020161626/liblz4-1_1.9.4-1%2Bcore2.1.20261020161626_amd64.deb)
- [liblz4-dev_1.9.4-1+core2.1.20261020161626_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lz4-1.9.4-1-core2.1-20261020161626/liblz4-dev_1.9.4-1%2Bcore2.1.20261020161626_amd64.deb)
- [liblz4-tool_1.9.4-1+core2.1.20261020161626_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lz4-1.9.4-1-core2.1-20261020161626/liblz4-tool_1.9.4-1%2Bcore2.1.20261020161626_all.deb)
- [lz4_1.9.4-1+core2.1.20261020161626_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lz4-1.9.4-1-core2.1-20261020161626/lz4_1.9.4-1%2Bcore2.1.20261020161626_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-lz4-1.9.4-1-core2.1-20261020161626)

### xkeyboard-config (optimized)
Version: `2.35.1-1+core2.1~20261020162047` · Published: 2026-10-20 16:21:39 UTC
**Description:** X Keyboard Extension (XKB) configuration data
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xkeyboard-config`

**Binary downloads:**
- [xkb-data_2.35.1-1+core2.1.20261020162047_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xkeyboard-config-2.35.1-1-core2.1-20261020162047/xkb-data_2.35.1-1%2Bcore2.1.20261020162047_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xkeyboard-config-2.35.1-1-core2.1-20261020162047)

### tiff (optimized)
Version: `4.5.0-6+deb12u4+core2.1~20261020161933` · Published: 2026-10-20 16:21:14 UTC
**Description:** Tag Image File Format (TIFF) library -- C++ interface
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - tiff`

**Binary downloads:**
- [libtiff-dev_4.5.0-6+deb12u4+core2.1.20261020161933_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933/libtiff-dev_4.5.0-6%2Bdeb12u4%2Bcore2.1.20261020161933_amd64.deb)
- [libtiff-doc_4.5.0-6+deb12u4+core2.1.20261020161933_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933/libtiff-doc_4.5.0-6%2Bdeb12u4%2Bcore2.1.20261020161933_all.deb)
- [libtiff-opengl_4.5.0-6+deb12u4+core2.1.20261020161933_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933/libtiff-opengl_4.5.0-6%2Bdeb12u4%2Bcore2.1.20261020161933_amd64.deb)
- [libtiff-tools_4.5.0-6+deb12u4+core2.1.20261020161933_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933/libtiff-tools_4.5.0-6%2Bdeb12u4%2Bcore2.1.20261020161933_amd64.deb)
- [libtiff5-dev_4.5.0-6+deb12u4+core2.1.20261020161933_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933/libtiff5-dev_4.5.0-6%2Bdeb12u4%2Bcore2.1.20261020161933_amd64.deb)
- [libtiff6_4.5.0-6+deb12u4+core2.1.20261020161933_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933/libtiff6_4.5.0-6%2Bdeb12u4%2Bcore2.1.20261020161933_amd64.deb)
- [libtiffxx6_4.5.0-6+deb12u4+core2.1.20261020161933_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933/libtiffxx6_4.5.0-6%2Bdeb12u4%2Bcore2.1.20261020161933_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-tiff-4.5.0-6-deb12u4-core2.1-20261020161933)

### shared-mime-info (optimized)
Version: `2.2-1+core2.1~20261020161923` · Published: 2026-10-20 16:20:21 UTC
**Description:** FreeDesktop.org shared MIME database and spec
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - shared-mime-info`

**Binary downloads:**
- [shared-mime-info_2.2-1+core2.1.20261020161923_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-shared-mime-info-2.2-1-core2.1-20261020161923/shared-mime-info_2.2-1%2Bcore2.1.20261020161923_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-shared-mime-info-2.2-1-core2.1-20261020161923)

### p11-kit (optimized)
Version: `0.24.1-2+core2.1~20261020161738` · Published: 2026-10-20 16:19:55 UTC
**Description:** p11-glue utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - p11-kit`

**Binary downloads:**
- [libp11-kit-dev_0.24.1-2+core2.1.20261020161738_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-p11-kit-0.24.1-2-core2.1-20261020161738/libp11-kit-dev_0.24.1-2%2Bcore2.1.20261020161738_amd64.deb)
- [libp11-kit0_0.24.1-2+core2.1.20261020161738_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-p11-kit-0.24.1-2-core2.1-20261020161738/libp11-kit0_0.24.1-2%2Bcore2.1.20261020161738_amd64.deb)
- [p11-kit-doc_0.24.1-2+core2.1.20261020161738_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-p11-kit-0.24.1-2-core2.1-20261020161738/p11-kit-doc_0.24.1-2%2Bcore2.1.20261020161738_all.deb)
- [p11-kit-modules_0.24.1-2+core2.1.20261020161738_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-p11-kit-0.24.1-2-core2.1-20261020161738/p11-kit-modules_0.24.1-2%2Bcore2.1.20261020161738_amd64.deb)
- [p11-kit_0.24.1-2+core2.1.20261020161738_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-p11-kit-0.24.1-2-core2.1-20261020161738/p11-kit_0.24.1-2%2Bcore2.1.20261020161738_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-p11-kit-0.24.1-2-core2.1-20261020161738)

### pango1.0 (optimized)
Version: `1.50.12+ds-1+core2.1~20261020161751` · Published: 2026-10-20 16:19:32 UTC
**Description:** Layout and rendering of internationalized text (transitional package)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - pango1.0`

**Binary downloads:**
- [gir1.2-pango-1.0_1.50.12+ds-1+core2.1.20261020161751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751/gir1.2-pango-1.0_1.50.12%2Bds-1%2Bcore2.1.20261020161751_amd64.deb)
- [libpango-1.0-0_1.50.12+ds-1+core2.1.20261020161751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751/libpango-1.0-0_1.50.12%2Bds-1%2Bcore2.1.20261020161751_amd64.deb)
- [libpango1.0-0_1.50.12+ds-1+core2.1.20261020161751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751/libpango1.0-0_1.50.12%2Bds-1%2Bcore2.1.20261020161751_amd64.deb)
- [libpango1.0-dev_1.50.12+ds-1+core2.1.20261020161751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751/libpango1.0-dev_1.50.12%2Bds-1%2Bcore2.1.20261020161751_amd64.deb)
- [libpango1.0-doc_1.50.12+ds-1+core2.1.20261020161751_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751/libpango1.0-doc_1.50.12%2Bds-1%2Bcore2.1.20261020161751_all.deb)
- [libpangocairo-1.0-0_1.50.12+ds-1+core2.1.20261020161751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751/libpangocairo-1.0-0_1.50.12%2Bds-1%2Bcore2.1.20261020161751_amd64.deb)
- [libpangoft2-1.0-0_1.50.12+ds-1+core2.1.20261020161751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751/libpangoft2-1.0-0_1.50.12%2Bds-1%2Bcore2.1.20261020161751_amd64.deb)
- [libpangoxft-1.0-0_1.50.12+ds-1+core2.1.20261020161751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751/libpangoxft-1.0-0_1.50.12%2Bds-1%2Bcore2.1.20261020161751_amd64.deb)
- [pango1.0-tests_1.50.12+ds-1+core2.1.20261020161751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751/pango1.0-tests_1.50.12%2Bds-1%2Bcore2.1.20261020161751_amd64.deb)
- [pango1.0-tools_1.50.12+ds-1+core2.1.20261020161751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751/pango1.0-tools_1.50.12%2Bds-1%2Bcore2.1.20261020161751_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-pango1.0-1.50.12-ds-1-core2.1-20261020161751)

### nettle (optimized)
Version: `3.8.1-2+core2.1~20261020161715` · Published: 2026-10-20 16:18:40 UTC
**Description:** low level cryptographic library (binary tools)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - nettle`

**Binary downloads:**
- [libhogweed6_3.8.1-2+core2.1.20261020161715_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-nettle-3.8.1-2-core2.1-20261020161715/libhogweed6_3.8.1-2%2Bcore2.1.20261020161715_amd64.deb)
- [libnettle8_3.8.1-2+core2.1.20261020161715_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-nettle-3.8.1-2-core2.1-20261020161715/libnettle8_3.8.1-2%2Bcore2.1.20261020161715_amd64.deb)
- [nettle-bin_3.8.1-2+core2.1.20261020161715_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-nettle-3.8.1-2-core2.1-20261020161715/nettle-bin_3.8.1-2%2Bcore2.1.20261020161715_amd64.deb)
- [nettle-dev_3.8.1-2+core2.1.20261020161715_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-nettle-3.8.1-2-core2.1-20261020161715/nettle-dev_3.8.1-2%2Bcore2.1.20261020161715_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-nettle-3.8.1-2-core2.1-20261020161715)

### libxml2 (optimized)
Version: `2.9.14+dfsg-1.3~deb12u6+core2.1~20261020161513` · Published: 2026-10-20 16:18:01 UTC
**Description:** GNOME XML library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxml2`

**Binary downloads:**
- [libxml2-dev_2.9.14+dfsg-1.3.deb12u6+core2.1.20261020161513_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxml2-2.9.14-dfsg-1.3-deb12u6-core2.1-20261020161513/libxml2-dev_2.9.14%2Bdfsg-1.3.deb12u6%2Bcore2.1.20261020161513_amd64.deb)
- [libxml2-doc_2.9.14+dfsg-1.3.deb12u6+core2.1.20261020161513_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxml2-2.9.14-dfsg-1.3-deb12u6-core2.1-20261020161513/libxml2-doc_2.9.14%2Bdfsg-1.3.deb12u6%2Bcore2.1.20261020161513_all.deb)
- [libxml2-utils_2.9.14+dfsg-1.3.deb12u6+core2.1.20261020161513_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxml2-2.9.14-dfsg-1.3-deb12u6-core2.1-20261020161513/libxml2-utils_2.9.14%2Bdfsg-1.3.deb12u6%2Bcore2.1.20261020161513_amd64.deb)
- [libxml2_2.9.14+dfsg-1.3.deb12u6+core2.1.20261020161513_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxml2-2.9.14-dfsg-1.3-deb12u6-core2.1-20261020161513/libxml2_2.9.14%2Bdfsg-1.3.deb12u6%2Bcore2.1.20261020161513_amd64.deb)
- [python3-libxml2_2.9.14+dfsg-1.3.deb12u6+core2.1.20261020161513_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxml2-2.9.14-dfsg-1.3-deb12u6-core2.1-20261020161513/python3-libxml2_2.9.14%2Bdfsg-1.3.deb12u6%2Bcore2.1.20261020161513_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxml2-2.9.14-dfsg-1.3-deb12u6-core2.1-20261020161513)

### libgcrypt20 (optimized)
Version: `1.10.1-3+deb12u1+core2.1~20261020161004` · Published: 2026-10-20 16:16:42 UTC
**Description:** LGPL Crypto library - runtime library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libgcrypt20`

**Binary downloads:**
- [libgcrypt-mingw-w64-dev_1.10.1-3+deb12u1+core2.1.20261020161004_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libgcrypt20-1.10.1-3-deb12u1-core2.1-20261020161004/libgcrypt-mingw-w64-dev_1.10.1-3%2Bdeb12u1%2Bcore2.1.20261020161004_all.deb)
- [libgcrypt20-dev_1.10.1-3+deb12u1+core2.1.20261020161004_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libgcrypt20-1.10.1-3-deb12u1-core2.1-20261020161004/libgcrypt20-dev_1.10.1-3%2Bdeb12u1%2Bcore2.1.20261020161004_amd64.deb)
- [libgcrypt20-doc_1.10.1-3+deb12u1+core2.1.20261020161004_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libgcrypt20-1.10.1-3-deb12u1-core2.1-20261020161004/libgcrypt20-doc_1.10.1-3%2Bdeb12u1%2Bcore2.1.20261020161004_all.deb)
- [libgcrypt20_1.10.1-3+deb12u1+core2.1.20261020161004_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libgcrypt20-1.10.1-3-deb12u1-core2.1-20261020161004/libgcrypt20_1.10.1-3%2Bdeb12u1%2Bcore2.1.20261020161004_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libgcrypt20-1.10.1-3-deb12u1-core2.1-20261020161004)

### gnutls28 (optimized)
Version: `3.7.9-2+deb12u7+core2.1~20261020155800` · Published: 2026-10-20 16:16:41 UTC
**Description:** GNU TLS library - C++ runtime library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gnutls28`

**Binary downloads:**
- [gnutls-bin_3.7.9-2+deb12u7+core2.1.20261020155800_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800/gnutls-bin_3.7.9-2%2Bdeb12u7%2Bcore2.1.20261020155800_amd64.deb)
- [gnutls-doc_3.7.9-2+deb12u7+core2.1.20261020155800_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800/gnutls-doc_3.7.9-2%2Bdeb12u7%2Bcore2.1.20261020155800_all.deb)
- [guile-gnutls_3.7.9-2+deb12u7+core2.1.20261020155800_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800/guile-gnutls_3.7.9-2%2Bdeb12u7%2Bcore2.1.20261020155800_amd64.deb)
- [libgnutls-dane0_3.7.9-2+deb12u7+core2.1.20261020155800_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800/libgnutls-dane0_3.7.9-2%2Bdeb12u7%2Bcore2.1.20261020155800_amd64.deb)
- [libgnutls-openssl27_3.7.9-2+deb12u7+core2.1.20261020155800_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800/libgnutls-openssl27_3.7.9-2%2Bdeb12u7%2Bcore2.1.20261020155800_amd64.deb)
- [libgnutls28-dev_3.7.9-2+deb12u7+core2.1.20261020155800_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800/libgnutls28-dev_3.7.9-2%2Bdeb12u7%2Bcore2.1.20261020155800_amd64.deb)
- [libgnutls30_3.7.9-2+deb12u7+core2.1.20261020155800_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800/libgnutls30_3.7.9-2%2Bdeb12u7%2Bcore2.1.20261020155800_amd64.deb)
- [libgnutlsxx30_3.7.9-2+deb12u7+core2.1.20261020155800_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800/libgnutlsxx30_3.7.9-2%2Bdeb12u7%2Bcore2.1.20261020155800_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gnutls28-3.7.9-2-deb12u7-core2.1-20261020155800)

### libxrender (optimized)
Version: `1:0.9.10-1.1+core2.1~20261020161528` · Published: 2026-10-20 16:16:22 UTC
**Description:** X Rendering Extension client library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxrender`

**Binary downloads:**
- [libxrender-dev_0.9.10-1.1+core2.1.20261020161528_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxrender-1-0.9.10-1.1-core2.1-20261020161528/libxrender-dev_0.9.10-1.1%2Bcore2.1.20261020161528_amd64.deb)
- [libxrender1_0.9.10-1.1+core2.1.20261020161528_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxrender-1-0.9.10-1.1-core2.1-20261020161528/libxrender1_0.9.10-1.1%2Bcore2.1.20261020161528_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxrender-1-0.9.10-1.1-core2.1-20261020161528)

### libxkbcommon (optimized)
Version: `1.5.0-1+core2.1~20261020161422` · Published: 2026-10-20 16:15:27 UTC
**Description:** library to query available RMLVO
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxkbcommon`

**Binary downloads:**
- [libxkbcommon-dev_1.5.0-1+core2.1.20261020161422_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422/libxkbcommon-dev_1.5.0-1%2Bcore2.1.20261020161422_amd64.deb)
- [libxkbcommon-doc_1.5.0-1+core2.1.20261020161422_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422/libxkbcommon-doc_1.5.0-1%2Bcore2.1.20261020161422_all.deb)
- [libxkbcommon-tools_1.5.0-1+core2.1.20261020161422_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422/libxkbcommon-tools_1.5.0-1%2Bcore2.1.20261020161422_amd64.deb)
- [libxkbcommon-x11-0_1.5.0-1+core2.1.20261020161422_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422/libxkbcommon-x11-0_1.5.0-1%2Bcore2.1.20261020161422_amd64.deb)
- [libxkbcommon-x11-dev_1.5.0-1+core2.1.20261020161422_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422/libxkbcommon-x11-dev_1.5.0-1%2Bcore2.1.20261020161422_amd64.deb)
- [libxkbcommon0_1.5.0-1+core2.1.20261020161422_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422/libxkbcommon0_1.5.0-1%2Bcore2.1.20261020161422_amd64.deb)
- [libxkbregistry-dev_1.5.0-1+core2.1.20261020161422_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422/libxkbregistry-dev_1.5.0-1%2Bcore2.1.20261020161422_amd64.deb)
- [libxkbregistry0_1.5.0-1+core2.1.20261020161422_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422/libxkbregistry0_1.5.0-1%2Bcore2.1.20261020161422_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxkbcommon-1.5.0-1-core2.1-20261020161422)

### libxi (optimized)
Version: `2:1.8-1+core2.1~20261020161349` · Published: 2026-10-20 16:15:05 UTC
**Description:** X11 Input extension library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxi`

**Binary downloads:**
- [libxi-dev_1.8-1+core2.1.20261020161349_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxi-2-1.8-1-core2.1-20261020161349/libxi-dev_1.8-1%2Bcore2.1.20261020161349_amd64.deb)
- [libxi6_1.8-1+core2.1.20261020161349_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxi-2-1.8-1-core2.1-20261020161349/libxi6_1.8-1%2Bcore2.1.20261020161349_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxi-2-1.8-1-core2.1-20261020161349)

### libxinerama (optimized)
Version: `2:1.1.4-3+core2.1~20261020161404` · Published: 2026-10-20 16:14:58 UTC
**Description:** X11 Xinerama extension library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxinerama`

**Binary downloads:**
- [libxinerama-dev_1.1.4-3+core2.1.20261020161404_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxinerama-2-1.1.4-3-core2.1-20261020161404/libxinerama-dev_1.1.4-3%2Bcore2.1.20261020161404_amd64.deb)
- [libxinerama1_1.1.4-3+core2.1.20261020161404_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxinerama-2-1.1.4-3-core2.1-20261020161404/libxinerama1_1.1.4-3%2Bcore2.1.20261020161404_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxinerama-2-1.1.4-3-core2.1-20261020161404)

### libxfixes (optimized)
Version: `1:6.0.0-2+core2.1~20261020161340` · Published: 2026-10-20 16:14:39 UTC
**Description:** X11 miscellaneous 'fixes' extension library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxfixes`

**Binary downloads:**
- [libxfixes-dev_6.0.0-2+core2.1.20261020161340_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfixes-1-6.0.0-2-core2.1-20261020161340/libxfixes-dev_6.0.0-2%2Bcore2.1.20261020161340_amd64.deb)
- [libxfixes3_6.0.0-2+core2.1.20261020161340_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfixes-1-6.0.0-2-core2.1-20261020161340/libxfixes3_6.0.0-2%2Bcore2.1.20261020161340_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxfixes-1-6.0.0-2-core2.1-20261020161340)

### libxcursor (optimized)
Version: `1:1.2.1-1+core2.1~20261020161324` · Published: 2026-10-20 16:14:21 UTC
**Description:** X cursor management library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxcursor`

**Binary downloads:**
- [libxcursor-dev_1.2.1-1+core2.1.20261020161324_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcursor-1-1.2.1-1-core2.1-20261020161324/libxcursor-dev_1.2.1-1%2Bcore2.1.20261020161324_amd64.deb)
- [libxcursor1_1.2.1-1+core2.1.20261020161324_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcursor-1-1.2.1-1-core2.1-20261020161324/libxcursor1_1.2.1-1%2Bcore2.1.20261020161324_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxcursor-1-1.2.1-1-core2.1-20261020161324)

### libtasn1-6 (optimized)
Version: `4.19.0-2+deb12u1+core2.1~20261020161215` · Published: 2026-10-20 16:13:39 UTC
**Description:** Manage ASN.1 structures (runtime)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libtasn1-6`

**Binary downloads:**
- [libtasn1-6-dev_4.19.0-2+deb12u1+core2.1.20261020161215_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libtasn1-6-4.19.0-2-deb12u1-core2.1-20261020161215/libtasn1-6-dev_4.19.0-2%2Bdeb12u1%2Bcore2.1.20261020161215_amd64.deb)
- [libtasn1-6_4.19.0-2+deb12u1+core2.1.20261020161215_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libtasn1-6-4.19.0-2-deb12u1-core2.1-20261020161215/libtasn1-6_4.19.0-2%2Bdeb12u1%2Bcore2.1.20261020161215_amd64.deb)
- [libtasn1-bin_4.19.0-2+deb12u1+core2.1.20261020161215_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libtasn1-6-4.19.0-2-deb12u1-core2.1-20261020161215/libtasn1-bin_4.19.0-2%2Bdeb12u1%2Bcore2.1.20261020161215_amd64.deb)
- [libtasn1-doc_4.19.0-2+deb12u1+core2.1.20261020161215_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libtasn1-6-4.19.0-2-deb12u1-core2.1-20261020161215/libtasn1-doc_4.19.0-2%2Bdeb12u1%2Bcore2.1.20261020161215_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libtasn1-6-4.19.0-2-deb12u1-core2.1-20261020161215)

### libthai (optimized)
Version: `0.1.29-1+core2.1~20261020161219` · Published: 2026-10-20 16:13:14 UTC
**Description:** Thai language support library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libthai`

**Binary downloads:**
- [libthai-data_0.1.29-1+core2.1.20261020161219_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libthai-0.1.29-1-core2.1-20261020161219/libthai-data_0.1.29-1%2Bcore2.1.20261020161219_all.deb)
- [libthai-dev_0.1.29-1+core2.1.20261020161219_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libthai-0.1.29-1-core2.1-20261020161219/libthai-dev_0.1.29-1%2Bcore2.1.20261020161219_amd64.deb)
- [libthai-doc_0.1.29-1+core2.1.20261020161219_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libthai-0.1.29-1-core2.1-20261020161219/libthai-doc_0.1.29-1%2Bcore2.1.20261020161219_all.deb)
- [libthai0_0.1.29-1+core2.1.20261020161219_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libthai-0.1.29-1-core2.1-20261020161219/libthai0_0.1.29-1%2Bcore2.1.20261020161219_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libthai-0.1.29-1-core2.1-20261020161219)

### libsepol (optimized)
Version: `3.4-2.1+core2.1~20261020161145` · Published: 2026-10-20 16:12:54 UTC
**Description:** Security Enhanced Linux policy utility programs
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libsepol`

**Binary downloads:**
- [libsepol-dev_3.4-2.1+core2.1.20261020161145_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsepol-3.4-2.1-core2.1-20261020161145/libsepol-dev_3.4-2.1%2Bcore2.1.20261020161145_amd64.deb)
- [libsepol2_3.4-2.1+core2.1.20261020161145_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsepol-3.4-2.1-core2.1-20261020161145/libsepol2_3.4-2.1%2Bcore2.1.20261020161145_amd64.deb)
- [sepol-utils_3.4-2.1+core2.1.20261020161145_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsepol-3.4-2.1-core2.1-20261020161145/sepol-utils_3.4-2.1%2Bcore2.1.20261020161145_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libsepol-3.4-2.1-core2.1-20261020161145)

### libgpg-error (optimized)
Version: `1.46-1+core2.1~20261020161016` · Published: 2026-10-20 16:12:46 UTC
**Description:** GnuPG development runtime library (executable tools)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libgpg-error`

**Binary downloads:**
- [gpgrt-tools_1.46-1+core2.1.20261020161016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libgpg-error-1.46-1-core2.1-20261020161016/gpgrt-tools_1.46-1%2Bcore2.1.20261020161016_amd64.deb)
- [libgpg-error-dev_1.46-1+core2.1.20261020161016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libgpg-error-1.46-1-core2.1-20261020161016/libgpg-error-dev_1.46-1%2Bcore2.1.20261020161016_amd64.deb)
- [libgpg-error-l10n_1.46-1+core2.1.20261020161016_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libgpg-error-1.46-1-core2.1-20261020161016/libgpg-error-l10n_1.46-1%2Bcore2.1.20261020161016_all.deb)
- [libgpg-error-mingw-w64-dev_1.46-1+core2.1.20261020161016_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libgpg-error-1.46-1-core2.1-20261020161016/libgpg-error-mingw-w64-dev_1.46-1%2Bcore2.1.20261020161016_all.deb)
- [libgpg-error0_1.46-1+core2.1.20261020161016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libgpg-error-1.46-1-core2.1-20261020161016/libgpg-error0_1.46-1%2Bcore2.1.20261020161016_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libgpg-error-1.46-1-core2.1-20261020161016)

### libtext-glob-perl (optimized)
Version: `0.11-3+core2.1~20261020161151` · Published: 2026-10-20 16:12:35 UTC
**Description:** Perl module for matching globbing patterns against text
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libtext-glob-perl`

**Binary downloads:**
- [libtext-glob-perl_0.11-3+core2.1.20261020161151_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libtext-glob-perl-0.11-3-core2.1-20261020161151/libtext-glob-perl_0.11-3%2Bcore2.1.20261020161151_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libtext-glob-perl-0.11-3-core2.1-20261020161151)

### libsemanage (optimized)
Version: `3.4-1+core2.1~20261020161025` · Published: 2026-10-20 16:11:39 UTC
**Description:** SELinux policy management utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libsemanage`

**Binary downloads:**
- [libsemanage-common_3.4-1+core2.1.20261020161025_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsemanage-3.4-1-core2.1-20261020161025/libsemanage-common_3.4-1%2Bcore2.1.20261020161025_all.deb)
- [libsemanage-dev_3.4-1+core2.1.20261020161025_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsemanage-3.4-1-core2.1-20261020161025/libsemanage-dev_3.4-1%2Bcore2.1.20261020161025_amd64.deb)
- [libsemanage2_3.4-1+core2.1.20261020161025_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsemanage-3.4-1-core2.1-20261020161025/libsemanage2_3.4-1%2Bcore2.1.20261020161025_amd64.deb)
- [python3-semanage_3.4-1+core2.1.20261020161025_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsemanage-3.4-1-core2.1-20261020161025/python3-semanage_3.4-1%2Bcore2.1.20261020161025_amd64.deb)
- [ruby-semanage_3.4-1+core2.1.20261020161025_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsemanage-3.4-1-core2.1-20261020161025/ruby-semanage_3.4-1%2Bcore2.1.20261020161025_amd64.deb)
- [semanage-utils_3.4-1+core2.1.20261020161025_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsemanage-3.4-1-core2.1-20261020161025/semanage-utils_3.4-1%2Bcore2.1.20261020161025_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libsemanage-3.4-1-core2.1-20261020161025)

### krb5 (optimized)
Version: `1.20.1-2+deb12u5+core2.1~20261020160614` · Published: 2026-10-20 16:11:03 UTC
**Description:** TLS plugin for MIT Kerberos
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - krb5`

**Binary downloads:**
- [krb5-admin-server_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-admin-server_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [krb5-doc_1.20.1-2+deb12u5+core2.1.20261020160614_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-doc_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_all.deb)
- [krb5-gss-samples_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-gss-samples_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [krb5-k5tls_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-k5tls_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [krb5-kdc-ldap_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-kdc-ldap_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [krb5-kdc_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-kdc_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [krb5-kpropd_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-kpropd_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [krb5-locales_1.20.1-2+deb12u5+core2.1.20261020160614_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-locales_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_all.deb)
- [krb5-multidev_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-multidev_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [krb5-otp_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-otp_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [krb5-pkinit_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-pkinit_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [krb5-user_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/krb5-user_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [libgssapi-krb5-2_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/libgssapi-krb5-2_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [libgssrpc4_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/libgssrpc4_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [libk5crypto3_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/libk5crypto3_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [libkadm5clnt-mit12_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/libkadm5clnt-mit12_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [libkadm5srv-mit12_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/libkadm5srv-mit12_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [libkdb5-10_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/libkdb5-10_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [libkrad-dev_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/libkrad-dev_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [libkrad0_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/libkrad0_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [libkrb5-3_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/libkrb5-3_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [libkrb5-dev_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/libkrb5-dev_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
- [libkrb5support0_1.20.1-2+deb12u5+core2.1.20261020160614_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614/libkrb5support0_1.20.1-2%2Bdeb12u5%2Bcore2.1.20261020160614_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-krb5-1.20.1-2-deb12u5-core2.1-20261020160614)

### libnumber-compare-perl (optimized)
Version: `0.03-3+core2.1~20261020161009` · Published: 2026-10-20 16:11:01 UTC
**Description:** module for performing numeric comparisons in Perl
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libnumber-compare-perl`

**Binary downloads:**
- [libnumber-compare-perl_0.03-3+core2.1.20261020161009_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libnumber-compare-perl-0.03-3-core2.1-20261020161009/libnumber-compare-perl_0.03-3%2Bcore2.1.20261020161009_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libnumber-compare-perl-0.03-3-core2.1-20261020161009)

### gtk+3.0 (optimized)
Version: `3.24.38-2~deb12u3+core2.1~20261020155945` · Published: 2026-10-20 16:10:55 UTC
**Description:** GNOME Accessibility Implementation Library -- shared libraries
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gtk+3.0`

**Binary downloads:**
- [gir1.2-gtk-3.0_3.24.38-2.deb12u3+core2.1.20261020155945_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945/gir1.2-gtk-3.0_3.24.38-2.deb12u3%2Bcore2.1.20261020155945_amd64.deb)
- [gtk-3-examples_3.24.38-2.deb12u3+core2.1.20261020155945_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945/gtk-3-examples_3.24.38-2.deb12u3%2Bcore2.1.20261020155945_amd64.deb)
- [gtk-update-icon-cache_3.24.38-2.deb12u3+core2.1.20261020155945_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945/gtk-update-icon-cache_3.24.38-2.deb12u3%2Bcore2.1.20261020155945_amd64.deb)
- [libgail-3-0_3.24.38-2.deb12u3+core2.1.20261020155945_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945/libgail-3-0_3.24.38-2.deb12u3%2Bcore2.1.20261020155945_amd64.deb)
- [libgail-3-dev_3.24.38-2.deb12u3+core2.1.20261020155945_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945/libgail-3-dev_3.24.38-2.deb12u3%2Bcore2.1.20261020155945_amd64.deb)
- [libgail-3-doc_3.24.38-2.deb12u3+core2.1.20261020155945_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945/libgail-3-doc_3.24.38-2.deb12u3%2Bcore2.1.20261020155945_all.deb)
- [libgtk-3-0_3.24.38-2.deb12u3+core2.1.20261020155945_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945/libgtk-3-0_3.24.38-2.deb12u3%2Bcore2.1.20261020155945_amd64.deb)
- [libgtk-3-bin_3.24.38-2.deb12u3+core2.1.20261020155945_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945/libgtk-3-bin_3.24.38-2.deb12u3%2Bcore2.1.20261020155945_amd64.deb)
- [libgtk-3-common_3.24.38-2.deb12u3+core2.1.20261020155945_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945/libgtk-3-common_3.24.38-2.deb12u3%2Bcore2.1.20261020155945_all.deb)
- [libgtk-3-dev_3.24.38-2.deb12u3+core2.1.20261020155945_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945/libgtk-3-dev_3.24.38-2.deb12u3%2Bcore2.1.20261020155945_amd64.deb)
- [libgtk-3-doc_3.24.38-2.deb12u3+core2.1.20261020155945_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945/libgtk-3-doc_3.24.38-2.deb12u3%2Bcore2.1.20261020155945_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gtk%2B3.0-3.24.38-2-deb12u3-core2.1-20261020155945)

### libfile-find-rule-perl (optimized)
Version: `0.34-4~deb12u1+core2.1~20261020160848` · Published: 2026-10-20 16:09:29 UTC
**Description:** module to search for files based on rules
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libfile-find-rule-perl`

**Binary downloads:**
- [libfile-find-rule-perl_0.34-4.deb12u1+core2.1.20261020160848_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libfile-find-rule-perl-0.34-4-deb12u1-core2.1-20261020160848/libfile-find-rule-perl_0.34-4.deb12u1%2Bcore2.1.20261020160848_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libfile-find-rule-perl-0.34-4-deb12u1-core2.1-20261020160848)

### libdeflate (optimized)
Version: `1.14-1+core2.1~20261020160817` · Published: 2026-10-20 16:09:15 UTC
**Description:** tools for whole-buffer compression and decompression library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libdeflate`

**Binary downloads:**
- [libdeflate-dev_1.14-1+core2.1.20261020160817_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdeflate-1.14-1-core2.1-20261020160817/libdeflate-dev_1.14-1%2Bcore2.1.20261020160817_amd64.deb)
- [libdeflate-tools_1.14-1+core2.1.20261020160817_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdeflate-1.14-1-core2.1-20261020160817/libdeflate-tools_1.14-1%2Bcore2.1.20261020160817_amd64.deb)
- [libdeflate0_1.14-1+core2.1.20261020160817_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdeflate-1.14-1-core2.1-20261020160817/libdeflate0_1.14-1%2Bcore2.1.20261020160817_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libdeflate-1.14-1-core2.1-20261020160817)

### libdatrie (optimized)
Version: `0.2.13-2+core2.1~20261020160819` · Published: 2026-10-20 16:09:11 UTC
**Description:** Programs for double-array trie library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libdatrie`

**Binary downloads:**
- [libdatrie-dev_0.2.13-2+core2.1.20261020160819_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdatrie-0.2.13-2-core2.1-20261020160819/libdatrie-dev_0.2.13-2%2Bcore2.1.20261020160819_amd64.deb)
- [libdatrie-doc_0.2.13-2+core2.1.20261020160819_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdatrie-0.2.13-2-core2.1-20261020160819/libdatrie-doc_0.2.13-2%2Bcore2.1.20261020160819_all.deb)
- [libdatrie1-bin_0.2.13-2+core2.1.20261020160819_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdatrie-0.2.13-2-core2.1-20261020160819/libdatrie1-bin_0.2.13-2%2Bcore2.1.20261020160819_amd64.deb)
- [libdatrie1_0.2.13-2+core2.1.20261020160819_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdatrie-0.2.13-2-core2.1-20261020160819/libdatrie1_0.2.13-2%2Bcore2.1.20261020160819_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libdatrie-0.2.13-2-core2.1-20261020160819)

### libconfuse (optimized)
Version: `3.3-3+core2.1~20261020160734` · Published: 2026-10-20 16:08:33 UTC
**Description:** Common files for libConfuse
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libconfuse`

**Binary downloads:**
- [libconfuse-common_3.3-3+core2.1.20261020160734_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libconfuse-3.3-3-core2.1-20261020160734/libconfuse-common_3.3-3%2Bcore2.1.20261020160734_all.deb)
- [libconfuse-dev_3.3-3+core2.1.20261020160734_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libconfuse-3.3-3-core2.1-20261020160734/libconfuse-dev_3.3-3%2Bcore2.1.20261020160734_amd64.deb)
- [libconfuse-doc_3.3-3+core2.1.20261020160734_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libconfuse-3.3-3-core2.1-20261020160734/libconfuse-doc_3.3-3%2Bcore2.1.20261020160734_all.deb)
- [libconfuse2_3.3-3+core2.1.20261020160734_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libconfuse-3.3-3-core2.1-20261020160734/libconfuse2_3.3-3%2Bcore2.1.20261020160734_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libconfuse-3.3-3-core2.1-20261020160734)

### lerc (optimized)
Version: `4.0.0+ds-2+core2.1~20261020160636` · Published: 2026-10-20 16:08:00 UTC
**Description:** Python 3 bindings to the Limited Error Raster Compression library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - lerc`

**Binary downloads:**
- [liblerc-dev_4.0.0+ds-2+core2.1.20261020160636_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lerc-4.0.0-ds-2-core2.1-20261020160636/liblerc-dev_4.0.0%2Bds-2%2Bcore2.1.20261020160636_amd64.deb)
- [liblerc4_4.0.0+ds-2+core2.1.20261020160636_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lerc-4.0.0-ds-2-core2.1-20261020160636/liblerc4_4.0.0%2Bds-2%2Bcore2.1.20261020160636_amd64.deb)
- [python3-lerc_4.0.0+ds-2+core2.1.20261020160636_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lerc-4.0.0-ds-2-core2.1-20261020160636/python3-lerc_4.0.0%2Bds-2%2Bcore2.1.20261020160636_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-lerc-4.0.0-ds-2-core2.1-20261020160636)

### icu (optimized)
Version: `72.1-3+deb12u1+core2.1~20261020160050` · Published: 2026-10-20 16:07:38 UTC
**Description:** Development utilities for International Components for Unicode
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - icu`

**Binary downloads:**
- [icu-devtools_72.1-3+deb12u1+core2.1.20261020160050_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-icu-72.1-3-deb12u1-core2.1-20261020160050/icu-devtools_72.1-3%2Bdeb12u1%2Bcore2.1.20261020160050_amd64.deb)
- [icu-doc_72.1-3+deb12u1+core2.1.20261020160050_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-icu-72.1-3-deb12u1-core2.1-20261020160050/icu-doc_72.1-3%2Bdeb12u1%2Bcore2.1.20261020160050_all.deb)
- [libicu-dev_72.1-3+deb12u1+core2.1.20261020160050_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-icu-72.1-3-deb12u1-core2.1-20261020160050/libicu-dev_72.1-3%2Bdeb12u1%2Bcore2.1.20261020160050_amd64.deb)
- [libicu72_72.1-3+deb12u1+core2.1.20261020160050_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-icu-72.1-3-deb12u1-core2.1-20261020160050/libicu72_72.1-3%2Bdeb12u1%2Bcore2.1.20261020160050_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-icu-72.1-3-deb12u1-core2.1-20261020160050)

### libcap-ng (optimized)
Version: `0.8.3-1+core2.1~20261020160633` · Published: 2026-10-20 16:07:35 UTC
**Description:** alternate POSIX capabilities library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libcap-ng`

**Binary downloads:**
- [libcap-ng-dev_0.8.3-1+core2.1.20261020160633_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libcap-ng-0.8.3-1-core2.1-20261020160633/libcap-ng-dev_0.8.3-1%2Bcore2.1.20261020160633_amd64.deb)
- [libcap-ng-utils_0.8.3-1+core2.1.20261020160633_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libcap-ng-0.8.3-1-core2.1-20261020160633/libcap-ng-utils_0.8.3-1%2Bcore2.1.20261020160633_amd64.deb)
- [libcap-ng0_0.8.3-1+core2.1.20261020160633_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libcap-ng-0.8.3-1-core2.1-20261020160633/libcap-ng0_0.8.3-1%2Bcore2.1.20261020160633_amd64.deb)
- [python3-cap-ng_0.8.3-1+core2.1.20261020160633_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libcap-ng-0.8.3-1-core2.1-20261020160633/python3-cap-ng_0.8.3-1%2Bcore2.1.20261020160633_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libcap-ng-0.8.3-1-core2.1-20261020160633)

### lcms2 (optimized)
Version: `2.14-2+deb12u1+core2.1~20261020160533` · Published: 2026-10-20 16:06:37 UTC
**Description:** Little CMS 2 color management library (utilities)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - lcms2`

**Binary downloads:**
- [liblcms2-2_2.14-2+deb12u1+core2.1.20261020160533_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lcms2-2.14-2-deb12u1-core2.1-20261020160533/liblcms2-2_2.14-2%2Bdeb12u1%2Bcore2.1.20261020160533_amd64.deb)
- [liblcms2-dev_2.14-2+deb12u1+core2.1.20261020160533_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lcms2-2.14-2-deb12u1-core2.1-20261020160533/liblcms2-dev_2.14-2%2Bdeb12u1%2Bcore2.1.20261020160533_amd64.deb)
- [liblcms2-utils_2.14-2+deb12u1+core2.1.20261020160533_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lcms2-2.14-2-deb12u1-core2.1-20261020160533/liblcms2-utils_2.14-2%2Bdeb12u1%2Bcore2.1.20261020160533_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-lcms2-2.14-2-deb12u1-core2.1-20261020160533)

### json-c (optimized)
Version: `0.16-2+core2.1~20261020160448` · Published: 2026-10-20 16:05:43 UTC
**Description:** JSON manipulation library - shared library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - json-c`

**Binary downloads:**
- [libjson-c-dev_0.16-2+core2.1.20261020160448_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-json-c-0.16-2-core2.1-20261020160448/libjson-c-dev_0.16-2%2Bcore2.1.20261020160448_amd64.deb)
- [libjson-c-doc_0.16-2+core2.1.20261020160448_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-json-c-0.16-2-core2.1-20261020160448/libjson-c-doc_0.16-2%2Bcore2.1.20261020160448_all.deb)
- [libjson-c5_0.16-2+core2.1.20261020160448_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-json-c-0.16-2-core2.1-20261020160448/libjson-c5_0.16-2%2Bcore2.1.20261020160448_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-json-c-0.16-2-core2.1-20261020160448)

### harfbuzz (optimized)
Version: `6.0.0+dfsg-3+core2.1~20261020160021` · Published: 2026-10-20 16:05:42 UTC
**Description:** OpenType text shaping engine ICU backend
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - harfbuzz`

**Binary downloads:**
- [gir1.2-harfbuzz-0.0_6.0.0+dfsg-3+core2.1.20261020160021_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021/gir1.2-harfbuzz-0.0_6.0.0%2Bdfsg-3%2Bcore2.1.20261020160021_amd64.deb)
- [libharfbuzz-bin_6.0.0+dfsg-3+core2.1.20261020160021_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021/libharfbuzz-bin_6.0.0%2Bdfsg-3%2Bcore2.1.20261020160021_amd64.deb)
- [libharfbuzz-dev_6.0.0+dfsg-3+core2.1.20261020160021_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021/libharfbuzz-dev_6.0.0%2Bdfsg-3%2Bcore2.1.20261020160021_amd64.deb)
- [libharfbuzz-doc_6.0.0+dfsg-3+core2.1.20261020160021_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021/libharfbuzz-doc_6.0.0%2Bdfsg-3%2Bcore2.1.20261020160021_all.deb)
- [libharfbuzz-gobject0_6.0.0+dfsg-3+core2.1.20261020160021_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021/libharfbuzz-gobject0_6.0.0%2Bdfsg-3%2Bcore2.1.20261020160021_amd64.deb)
- [libharfbuzz-icu0_6.0.0+dfsg-3+core2.1.20261020160021_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021/libharfbuzz-icu0_6.0.0%2Bdfsg-3%2Bcore2.1.20261020160021_amd64.deb)
- [libharfbuzz-subset0_6.0.0+dfsg-3+core2.1.20261020160021_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021/libharfbuzz-subset0_6.0.0%2Bdfsg-3%2Bcore2.1.20261020160021_amd64.deb)
- [libharfbuzz0b_6.0.0+dfsg-3+core2.1.20261020160021_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021/libharfbuzz0b_6.0.0%2Bdfsg-3%2Bcore2.1.20261020160021_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-harfbuzz-6.0.0-dfsg-3-core2.1-20261020160021)

### jbigkit (optimized)
Version: `2.1-6.1+core2.1~20261020160309` · Published: 2026-10-20 16:04:01 UTC
**Description:** JBIGkit binaries
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - jbigkit`

**Binary downloads:**
- [jbigkit-bin_2.1-6.1+core2.1.20261020160309_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-jbigkit-2.1-6.1-core2.1-20261020160309/jbigkit-bin_2.1-6.1%2Bcore2.1.20261020160309_amd64.deb)
- [jbigkit-testdata_2.1-6.1+core2.1.20261020160309_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-jbigkit-2.1-6.1-core2.1-20261020160309/jbigkit-testdata_2.1-6.1%2Bcore2.1.20261020160309_amd64.deb)
- [libjbig-dev_2.1-6.1+core2.1.20261020160309_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-jbigkit-2.1-6.1-core2.1-20261020160309/libjbig-dev_2.1-6.1%2Bcore2.1.20261020160309_amd64.deb)
- [libjbig0_2.1-6.1+core2.1.20261020160309_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-jbigkit-2.1-6.1-core2.1-20261020160309/libjbig0_2.1-6.1%2Bcore2.1.20261020160309_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-jbigkit-2.1-6.1-core2.1-20261020160309)

### db5.3 (optimized)
Version: `5.3.28+dfsg2-1+core2.1~20261020155531` · Published: 2026-10-20 16:04:00 UTC
**Description:** Berkeley v5.3 SQL Database Utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - db5.3`

**Binary downloads:**
- [db5.3-doc_5.3.28+dfsg2-1+core2.1.20261020155531_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/db5.3-doc_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_all.deb)
- [db5.3-sql-util_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/db5.3-sql-util_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [db5.3-util_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/db5.3-util_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [libdb5.3++-dev_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3%2B%2B-dev_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [libdb5.3++_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3%2B%2B_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [libdb5.3-dev_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3-dev_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [libdb5.3-java-dev_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3-java-dev_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [libdb5.3-java-jni_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3-java-jni_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [libdb5.3-java_5.3.28+dfsg2-1+core2.1.20261020155531_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3-java_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_all.deb)
- [libdb5.3-sql-dev_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3-sql-dev_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [libdb5.3-sql_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3-sql_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [libdb5.3-stl-dev_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3-stl-dev_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [libdb5.3-stl_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3-stl_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [libdb5.3-tcl_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3-tcl_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
- [libdb5.3_5.3.28+dfsg2-1+core2.1.20261020155531_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531/libdb5.3_5.3.28%2Bdfsg2-1%2Bcore2.1.20261020155531_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-db5.3-5.3.28-dfsg2-1-core2.1-20261020155531)

### iptables (optimized)
Version: `1.8.9-2+core2.1~20261020160244` · Published: 2026-10-20 16:03:58 UTC
**Description:** administration tools for packet filtering and NAT
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - iptables`

**Binary downloads:**
- [iptables_1.8.9-2+core2.1.20261020160244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-iptables-1.8.9-2-core2.1-20261020160244/iptables_1.8.9-2%2Bcore2.1.20261020160244_amd64.deb)
- [libip4tc-dev_1.8.9-2+core2.1.20261020160244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-iptables-1.8.9-2-core2.1-20261020160244/libip4tc-dev_1.8.9-2%2Bcore2.1.20261020160244_amd64.deb)
- [libip4tc2_1.8.9-2+core2.1.20261020160244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-iptables-1.8.9-2-core2.1-20261020160244/libip4tc2_1.8.9-2%2Bcore2.1.20261020160244_amd64.deb)
- [libip6tc-dev_1.8.9-2+core2.1.20261020160244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-iptables-1.8.9-2-core2.1-20261020160244/libip6tc-dev_1.8.9-2%2Bcore2.1.20261020160244_amd64.deb)
- [libip6tc2_1.8.9-2+core2.1.20261020160244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-iptables-1.8.9-2-core2.1-20261020160244/libip6tc2_1.8.9-2%2Bcore2.1.20261020160244_amd64.deb)
- [libiptc-dev_1.8.9-2+core2.1.20261020160244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-iptables-1.8.9-2-core2.1-20261020160244/libiptc-dev_1.8.9-2%2Bcore2.1.20261020160244_amd64.deb)
- [libiptc0_1.8.9-2+core2.1.20261020160244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-iptables-1.8.9-2-core2.1-20261020160244/libiptc0_1.8.9-2%2Bcore2.1.20261020160244_amd64.deb)
- [libxtables-dev_1.8.9-2+core2.1.20261020160244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-iptables-1.8.9-2-core2.1-20261020160244/libxtables-dev_1.8.9-2%2Bcore2.1.20261020160244_amd64.deb)
- [libxtables12_1.8.9-2+core2.1.20261020160244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-iptables-1.8.9-2-core2.1-20261020160244/libxtables12_1.8.9-2%2Bcore2.1.20261020160244_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-iptables-1.8.9-2-core2.1-20261020160244)

### hicolor-icon-theme (optimized)
Version: `0.17-2+core2.1~20261020160041` · Published: 2026-10-20 16:01:56 UTC
**Description:** default fallback theme for FreeDesktop.org icon themes
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - hicolor-icon-theme`

**Binary downloads:**
- [hicolor-icon-theme_0.17-2+core2.1.20261020160041_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-hicolor-icon-theme-0.17-2-core2.1-20261020160041/hicolor-icon-theme_0.17-2%2Bcore2.1.20261020160041_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-hicolor-icon-theme-0.17-2-core2.1-20261020160041)

### graphite2 (optimized)
Version: `1.3.14-1+deb12u1+core2.1~20261020160000` · Published: 2026-10-20 16:01:22 UTC
**Description:** Python bindings for libgraphite2
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - graphite2`

**Binary downloads:**
- [libgraphite2-3_1.3.14-1+deb12u1+core2.1.20261020160000_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-graphite2-1.3.14-1-deb12u1-core2.1-20261020160000/libgraphite2-3_1.3.14-1%2Bdeb12u1%2Bcore2.1.20261020160000_amd64.deb)
- [libgraphite2-dev_1.3.14-1+deb12u1+core2.1.20261020160000_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-graphite2-1.3.14-1-deb12u1-core2.1-20261020160000/libgraphite2-dev_1.3.14-1%2Bdeb12u1%2Bcore2.1.20261020160000_amd64.deb)
- [libgraphite2-doc_1.3.14-1+deb12u1+core2.1.20261020160000_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-graphite2-1.3.14-1-deb12u1-core2.1-20261020160000/libgraphite2-doc_1.3.14-1%2Bdeb12u1%2Bcore2.1.20261020160000_all.deb)
- [libgraphite2-utils_1.3.14-1+deb12u1+core2.1.20261020160000_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-graphite2-1.3.14-1-deb12u1-core2.1-20261020160000/libgraphite2-utils_1.3.14-1%2Bdeb12u1%2Bcore2.1.20261020160000_amd64.deb)
- [python3-graphite2_1.3.14-1+deb12u1+core2.1.20261020160000_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-graphite2-1.3.14-1-deb12u1-core2.1-20261020160000/python3-graphite2_1.3.14-1%2Bdeb12u1%2Bcore2.1.20261020160000_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-graphite2-1.3.14-1-deb12u1-core2.1-20261020160000)

### dbus (optimized)
Version: `1.14.10-1~deb12u1+core2.1~20261020155524` · Published: 2026-10-20 16:00:09 UTC
**Description:** simple interprocess messaging system (system message bus)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - dbus`

**Binary downloads:**
- [dbus-1-doc_1.14.10-1.deb12u1+core2.1.20261020155524_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524/dbus-1-doc_1.14.10-1.deb12u1%2Bcore2.1.20261020155524_all.deb)
- [dbus-bin_1.14.10-1.deb12u1+core2.1.20261020155524_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524/dbus-bin_1.14.10-1.deb12u1%2Bcore2.1.20261020155524_amd64.deb)
- [dbus-daemon_1.14.10-1.deb12u1+core2.1.20261020155524_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524/dbus-daemon_1.14.10-1.deb12u1%2Bcore2.1.20261020155524_amd64.deb)
- [dbus-session-bus-common_1.14.10-1.deb12u1+core2.1.20261020155524_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524/dbus-session-bus-common_1.14.10-1.deb12u1%2Bcore2.1.20261020155524_all.deb)
- [dbus-system-bus-common_1.14.10-1.deb12u1+core2.1.20261020155524_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524/dbus-system-bus-common_1.14.10-1.deb12u1%2Bcore2.1.20261020155524_all.deb)
- [dbus-tests_1.14.10-1.deb12u1+core2.1.20261020155524_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524/dbus-tests_1.14.10-1.deb12u1%2Bcore2.1.20261020155524_amd64.deb)
- [dbus-user-session_1.14.10-1.deb12u1+core2.1.20261020155524_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524/dbus-user-session_1.14.10-1.deb12u1%2Bcore2.1.20261020155524_amd64.deb)
- [dbus-x11_1.14.10-1.deb12u1+core2.1.20261020155524_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524/dbus-x11_1.14.10-1.deb12u1%2Bcore2.1.20261020155524_amd64.deb)
- [dbus_1.14.10-1.deb12u1+core2.1.20261020155524_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524/dbus_1.14.10-1.deb12u1%2Bcore2.1.20261020155524_amd64.deb)
- [libdbus-1-3_1.14.10-1.deb12u1+core2.1.20261020155524_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524/libdbus-1-3_1.14.10-1.deb12u1%2Bcore2.1.20261020155524_amd64.deb)
- [libdbus-1-dev_1.14.10-1.deb12u1+core2.1.20261020155524_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524/libdbus-1-dev_1.14.10-1.deb12u1%2Bcore2.1.20261020155524_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-dbus-1.14.10-1-deb12u1-core2.1-20261020155524)

### apparmor (optimized)
Version: `3.0.8-3+core2.1~20261020155241` · Published: 2026-10-20 15:59:40 UTC
**Description:** user-space parser utility for AppArmor
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - apparmor`

**Binary downloads:**
- [apparmor-notify_3.0.8-3+core2.1.20261020155241_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apparmor-3.0.8-3-core2.1-20261020155241/apparmor-notify_3.0.8-3%2Bcore2.1.20261020155241_all.deb)
- [apparmor-profiles_3.0.8-3+core2.1.20261020155241_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apparmor-3.0.8-3-core2.1-20261020155241/apparmor-profiles_3.0.8-3%2Bcore2.1.20261020155241_all.deb)
- [apparmor-utils_3.0.8-3+core2.1.20261020155241_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apparmor-3.0.8-3-core2.1-20261020155241/apparmor-utils_3.0.8-3%2Bcore2.1.20261020155241_all.deb)
- [apparmor_3.0.8-3+core2.1.20261020155241_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apparmor-3.0.8-3-core2.1-20261020155241/apparmor_3.0.8-3%2Bcore2.1.20261020155241_amd64.deb)
- [dh-apparmor_3.0.8-3+core2.1.20261020155241_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apparmor-3.0.8-3-core2.1-20261020155241/dh-apparmor_3.0.8-3%2Bcore2.1.20261020155241_all.deb)
- [libapache2-mod-apparmor_3.0.8-3+core2.1.20261020155241_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apparmor-3.0.8-3-core2.1-20261020155241/libapache2-mod-apparmor_3.0.8-3%2Bcore2.1.20261020155241_amd64.deb)
- [libapparmor-dev_3.0.8-3+core2.1.20261020155241_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apparmor-3.0.8-3-core2.1-20261020155241/libapparmor-dev_3.0.8-3%2Bcore2.1.20261020155241_amd64.deb)
- [libapparmor1_3.0.8-3+core2.1.20261020155241_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apparmor-3.0.8-3-core2.1-20261020155241/libapparmor1_3.0.8-3%2Bcore2.1.20261020155241_amd64.deb)
- [libpam-apparmor_3.0.8-3+core2.1.20261020155241_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apparmor-3.0.8-3-core2.1-20261020155241/libpam-apparmor_3.0.8-3%2Bcore2.1.20261020155241_amd64.deb)
- [python3-apparmor_3.0.8-3+core2.1.20261020155241_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apparmor-3.0.8-3-core2.1-20261020155241/python3-apparmor_3.0.8-3%2Bcore2.1.20261020155241_all.deb)
- [python3-libapparmor_3.0.8-3+core2.1.20261020155241_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apparmor-3.0.8-3-core2.1-20261020155241/python3-libapparmor_3.0.8-3%2Bcore2.1.20261020155241_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-apparmor-3.0.8-3-core2.1-20261020155241)

### gdk-pixbuf (optimized)
Version: `2.42.10+dfsg-1+deb12u4+core2.1~20261020155747` · Published: 2026-10-20 15:59:22 UTC
**Description:** GDK Pixbuf library - GObject-Introspection
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gdk-pixbuf`

**Binary downloads:**
- [gdk-pixbuf-tests_2.42.10+dfsg-1+deb12u4+core2.1.20261020155747_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747/gdk-pixbuf-tests_2.42.10%2Bdfsg-1%2Bdeb12u4%2Bcore2.1.20261020155747_amd64.deb)
- [gir1.2-gdkpixbuf-2.0_2.42.10+dfsg-1+deb12u4+core2.1.20261020155747_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747/gir1.2-gdkpixbuf-2.0_2.42.10%2Bdfsg-1%2Bdeb12u4%2Bcore2.1.20261020155747_amd64.deb)
- [libgdk-pixbuf-2.0-0_2.42.10+dfsg-1+deb12u4+core2.1.20261020155747_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747/libgdk-pixbuf-2.0-0_2.42.10%2Bdfsg-1%2Bdeb12u4%2Bcore2.1.20261020155747_amd64.deb)
- [libgdk-pixbuf-2.0-dev_2.42.10+dfsg-1+deb12u4+core2.1.20261020155747_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747/libgdk-pixbuf-2.0-dev_2.42.10%2Bdfsg-1%2Bdeb12u4%2Bcore2.1.20261020155747_amd64.deb)
- [libgdk-pixbuf2.0-bin_2.42.10+dfsg-1+deb12u4+core2.1.20261020155747_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747/libgdk-pixbuf2.0-bin_2.42.10%2Bdfsg-1%2Bdeb12u4%2Bcore2.1.20261020155747_amd64.deb)
- [libgdk-pixbuf2.0-common_2.42.10+dfsg-1+deb12u4+core2.1.20261020155747_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747/libgdk-pixbuf2.0-common_2.42.10%2Bdfsg-1%2Bdeb12u4%2Bcore2.1.20261020155747_all.deb)
- [libgdk-pixbuf2.0-doc_2.42.10+dfsg-1+deb12u4+core2.1.20261020155747_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747/libgdk-pixbuf2.0-doc_2.42.10%2Bdfsg-1%2Bdeb12u4%2Bcore2.1.20261020155747_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gdk-pixbuf-2.42.10-dfsg-1-deb12u4-core2.1-20261020155747)

### gdbm (optimized)
Version: `1.23-3+core2.1~20261020155702` · Published: 2026-10-20 15:58:22 UTC
**Description:** GNU dbm database routines (legacy support runtime version)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gdbm`

**Binary downloads:**
- [gdbm-l10n_1.23-3+core2.1.20261020155702_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdbm-1.23-3-core2.1-20261020155702/gdbm-l10n_1.23-3%2Bcore2.1.20261020155702_all.deb)
- [gdbmtool_1.23-3+core2.1.20261020155702_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdbm-1.23-3-core2.1-20261020155702/gdbmtool_1.23-3%2Bcore2.1.20261020155702_amd64.deb)
- [libgdbm-compat-dev_1.23-3+core2.1.20261020155702_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdbm-1.23-3-core2.1-20261020155702/libgdbm-compat-dev_1.23-3%2Bcore2.1.20261020155702_amd64.deb)
- [libgdbm-compat4_1.23-3+core2.1.20261020155702_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdbm-1.23-3-core2.1-20261020155702/libgdbm-compat4_1.23-3%2Bcore2.1.20261020155702_amd64.deb)
- [libgdbm-dev_1.23-3+core2.1.20261020155702_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdbm-1.23-3-core2.1-20261020155702/libgdbm-dev_1.23-3%2Bcore2.1.20261020155702_amd64.deb)
- [libgdbm6_1.23-3+core2.1.20261020155702_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gdbm-1.23-3-core2.1-20261020155702/libgdbm6_1.23-3%2Bcore2.1.20261020155702_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gdbm-1.23-3-core2.1-20261020155702)

### fribidi (optimized)
Version: `1.0.8-2.1+core2.1~20261020155618` · Published: 2026-10-20 15:57:17 UTC
**Description:** Free Implementation of the Unicode BiDi algorithm (utility)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - fribidi`

**Binary downloads:**
- [libfribidi-bin_1.0.8-2.1+core2.1.20261020155618_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fribidi-1.0.8-2.1-core2.1-20261020155618/libfribidi-bin_1.0.8-2.1%2Bcore2.1.20261020155618_amd64.deb)
- [libfribidi-dev_1.0.8-2.1+core2.1.20261020155618_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fribidi-1.0.8-2.1-core2.1-20261020155618/libfribidi-dev_1.0.8-2.1%2Bcore2.1.20261020155618_amd64.deb)
- [libfribidi0_1.0.8-2.1+core2.1.20261020155618_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fribidi-1.0.8-2.1-core2.1-20261020155618/libfribidi0_1.0.8-2.1%2Bcore2.1.20261020155618_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-fribidi-1.0.8-2.1-core2.1-20261020155618)

### cups (optimized)
Version: `2.4.2-3+deb12u9+core2.1~20261020155438` · Published: 2026-10-20 15:56:38 UTC
**Description:** Common UNIX Printing System(tm) - PPD/driver support, web interface
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - cups`

**Binary downloads:**
- [cups-bsd_2.4.2-3+deb12u9+core2.1.20261020155438_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/cups-bsd_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_amd64.deb)
- [cups-client_2.4.2-3+deb12u9+core2.1.20261020155438_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/cups-client_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_amd64.deb)
- [cups-common_2.4.2-3+deb12u9+core2.1.20261020155438_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/cups-common_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_all.deb)
- [cups-core-drivers_2.4.2-3+deb12u9+core2.1.20261020155438_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/cups-core-drivers_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_amd64.deb)
- [cups-daemon_2.4.2-3+deb12u9+core2.1.20261020155438_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/cups-daemon_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_amd64.deb)
- [cups-ipp-utils_2.4.2-3+deb12u9+core2.1.20261020155438_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/cups-ipp-utils_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_amd64.deb)
- [cups-ppdc_2.4.2-3+deb12u9+core2.1.20261020155438_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/cups-ppdc_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_amd64.deb)
- [cups-server-common_2.4.2-3+deb12u9+core2.1.20261020155438_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/cups-server-common_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_all.deb)
- [cups_2.4.2-3+deb12u9+core2.1.20261020155438_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/cups_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_amd64.deb)
- [libcups2-dev_2.4.2-3+deb12u9+core2.1.20261020155438_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/libcups2-dev_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_amd64.deb)
- [libcups2_2.4.2-3+deb12u9+core2.1.20261020155438_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/libcups2_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_amd64.deb)
- [libcupsimage2-dev_2.4.2-3+deb12u9+core2.1.20261020155438_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/libcupsimage2-dev_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_amd64.deb)
- [libcupsimage2_2.4.2-3+deb12u9+core2.1.20261020155438_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438/libcupsimage2_2.4.2-3%2Bdeb12u9%2Bcore2.1.20261020155438_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-cups-2.4.2-3-deb12u9-core2.1-20261020155438)

### dconf (optimized)
Version: `0.40.0-4+core2.1~20261020155533` · Published: 2026-10-20 15:56:35 UTC
**Description:** simple configuration storage system - utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - dconf`

**Binary downloads:**
- [dconf-cli_0.40.0-4+core2.1.20261020155533_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dconf-0.40.0-4-core2.1-20261020155533/dconf-cli_0.40.0-4%2Bcore2.1.20261020155533_amd64.deb)
- [dconf-gsettings-backend_0.40.0-4+core2.1.20261020155533_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dconf-0.40.0-4-core2.1-20261020155533/dconf-gsettings-backend_0.40.0-4%2Bcore2.1.20261020155533_amd64.deb)
- [dconf-service_0.40.0-4+core2.1.20261020155533_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dconf-0.40.0-4-core2.1-20261020155533/dconf-service_0.40.0-4%2Bcore2.1.20261020155533_amd64.deb)
- [libdconf-dev_0.40.0-4+core2.1.20261020155533_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dconf-0.40.0-4-core2.1-20261020155533/libdconf-dev_0.40.0-4%2Bcore2.1.20261020155533_amd64.deb)
- [libdconf-doc_0.40.0-4+core2.1.20261020155533_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dconf-0.40.0-4-core2.1-20261020155533/libdconf-doc_0.40.0-4%2Bcore2.1.20261020155533_all.deb)
- [libdconf1_0.40.0-4+core2.1.20261020155533_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dconf-0.40.0-4-core2.1-20261020155533/libdconf1_0.40.0-4%2Bcore2.1.20261020155533_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-dconf-0.40.0-4-core2.1-20261020155533)

### colord (optimized)
Version: `1.4.6-2.2+core2.1~20261020155348` · Published: 2026-10-20 15:55:15 UTC
**Description:** system service to manage device colour profiles -- system daemon
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - colord`

**Binary downloads:**
- [colord-data_1.4.6-2.2+core2.1.20261020155348_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-colord-1.4.6-2.2-core2.1-20261020155348/colord-data_1.4.6-2.2%2Bcore2.1.20261020155348_all.deb)
- [colord-sensor-argyll_1.4.6-2.2+core2.1.20261020155348_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-colord-1.4.6-2.2-core2.1-20261020155348/colord-sensor-argyll_1.4.6-2.2%2Bcore2.1.20261020155348_amd64.deb)
- [colord-tests_1.4.6-2.2+core2.1.20261020155348_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-colord-1.4.6-2.2-core2.1-20261020155348/colord-tests_1.4.6-2.2%2Bcore2.1.20261020155348_amd64.deb)
- [colord_1.4.6-2.2+core2.1.20261020155348_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-colord-1.4.6-2.2-core2.1-20261020155348/colord_1.4.6-2.2%2Bcore2.1.20261020155348_amd64.deb)
- [gir1.2-colord-1.0_1.4.6-2.2+core2.1.20261020155348_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-colord-1.4.6-2.2-core2.1-20261020155348/gir1.2-colord-1.0_1.4.6-2.2%2Bcore2.1.20261020155348_amd64.deb)
- [gir1.2-colorhug-1.0_1.4.6-2.2+core2.1.20261020155348_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-colord-1.4.6-2.2-core2.1-20261020155348/gir1.2-colorhug-1.0_1.4.6-2.2%2Bcore2.1.20261020155348_amd64.deb)
- [libcolord-dev_1.4.6-2.2+core2.1.20261020155348_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-colord-1.4.6-2.2-core2.1-20261020155348/libcolord-dev_1.4.6-2.2%2Bcore2.1.20261020155348_amd64.deb)
- [libcolord2_1.4.6-2.2+core2.1.20261020155348_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-colord-1.4.6-2.2-core2.1-20261020155348/libcolord2_1.4.6-2.2%2Bcore2.1.20261020155348_amd64.deb)
- [libcolorhug-dev_1.4.6-2.2+core2.1.20261020155348_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-colord-1.4.6-2.2-core2.1-20261020155348/libcolorhug-dev_1.4.6-2.2%2Bcore2.1.20261020155348_amd64.deb)
- [libcolorhug2_1.4.6-2.2+core2.1.20261020155348_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-colord-1.4.6-2.2-core2.1-20261020155348/libcolorhug2_1.4.6-2.2%2Bcore2.1.20261020155348_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-colord-1.4.6-2.2-core2.1-20261020155348)

### adwaita-icon-theme (optimized)
Version: `43-1+core2.1~20261020155234` · Published: 2026-10-20 15:54:40 UTC
**Description:** default icon theme of GNOME
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - adwaita-icon-theme`

**Binary downloads:**
- [adwaita-icon-theme_43-1+core2.1.20261020155234_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-adwaita-icon-theme-43-1-core2.1-20261020155234/adwaita-icon-theme_43-1%2Bcore2.1.20261020155234_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-adwaita-icon-theme-43-1-core2.1-20261020155234)

### avahi (optimized)
Version: `0.8-10+deb12u1+core2.1~20261020155255` · Published: 2026-10-20 15:54:36 UTC
**Description:** GObject introspection data for Avahi
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - avahi`

**Binary downloads:**
- [avahi-autoipd_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/avahi-autoipd_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [avahi-daemon_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/avahi-daemon_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [avahi-discover_0.8-10+deb12u1+core2.1.20261020155255_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/avahi-discover_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_all.deb)
- [avahi-dnsconfd_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/avahi-dnsconfd_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [avahi-ui-utils_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/avahi-ui-utils_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [avahi-utils_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/avahi-utils_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [gir1.2-avahi-0.6_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/gir1.2-avahi-0.6_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-client-dev_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-client-dev_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-client3_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-client3_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-common-data_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-common-data_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-common-dev_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-common-dev_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-common3_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-common3_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-compat-libdnssd-dev_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-compat-libdnssd-dev_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-compat-libdnssd1_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-compat-libdnssd1_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-core-dev_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-core-dev_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-core7_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-core7_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-glib-dev_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-glib-dev_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-glib1_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-glib1_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-gobject-dev_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-gobject-dev_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-gobject0_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-gobject0_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-ui-gtk3-0_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-ui-gtk3-0_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [libavahi-ui-gtk3-dev_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/libavahi-ui-gtk3-dev_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
- [python3-avahi_0.8-10+deb12u1+core2.1.20261020155255_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255/python3-avahi_0.8-10%2Bdeb12u1%2Bcore2.1.20261020155255_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-avahi-0.8-10-deb12u1-core2.1-20261020155255)

### audit (optimized)
Version: `1:3.0.9-1+core2.1~20261020155244` · Published: 2026-10-20 15:54:23 UTC
**Description:** Dynamic library for security auditing - common files
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - audit`

**Binary downloads:**
- [audispd-plugins_3.0.9-1+core2.1.20261020155244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-audit-1-3.0.9-1-core2.1-20261020155244/audispd-plugins_3.0.9-1%2Bcore2.1.20261020155244_amd64.deb)
- [auditd_3.0.9-1+core2.1.20261020155244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-audit-1-3.0.9-1-core2.1-20261020155244/auditd_3.0.9-1%2Bcore2.1.20261020155244_amd64.deb)
- [golang-redhat-audit-dev_3.0.9-1+core2.1.20261020155244_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-audit-1-3.0.9-1-core2.1-20261020155244/golang-redhat-audit-dev_3.0.9-1%2Bcore2.1.20261020155244_all.deb)
- [libaudit-common_3.0.9-1+core2.1.20261020155244_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-audit-1-3.0.9-1-core2.1-20261020155244/libaudit-common_3.0.9-1%2Bcore2.1.20261020155244_all.deb)
- [libaudit-dev_3.0.9-1+core2.1.20261020155244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-audit-1-3.0.9-1-core2.1-20261020155244/libaudit-dev_3.0.9-1%2Bcore2.1.20261020155244_amd64.deb)
- [libaudit1_3.0.9-1+core2.1.20261020155244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-audit-1-3.0.9-1-core2.1-20261020155244/libaudit1_3.0.9-1%2Bcore2.1.20261020155244_amd64.deb)
- [libauparse-dev_3.0.9-1+core2.1.20261020155244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-audit-1-3.0.9-1-core2.1-20261020155244/libauparse-dev_3.0.9-1%2Bcore2.1.20261020155244_amd64.deb)
- [libauparse0_3.0.9-1+core2.1.20261020155244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-audit-1-3.0.9-1-core2.1-20261020155244/libauparse0_3.0.9-1%2Bcore2.1.20261020155244_amd64.deb)
- [python3-audit_3.0.9-1+core2.1.20261020155244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-audit-1-3.0.9-1-core2.1-20261020155244/python3-audit_3.0.9-1%2Bcore2.1.20261020155244_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-audit-1-3.0.9-1-core2.1-20261020155244)

### at-spi2-core (optimized)
Version: `2.46.0-5+core2.1~20261020155253` · Published: 2026-10-20 15:54:23 UTC
**Description:** Assistive Technology Service Provider Interface (D-Bus core)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - at-spi2-core`

**Binary downloads:**
- [at-spi2-common_2.46.0-5+core2.1.20261020155253_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/at-spi2-common_2.46.0-5%2Bcore2.1.20261020155253_all.deb)
- [at-spi2-core_2.46.0-5+core2.1.20261020155253_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/at-spi2-core_2.46.0-5%2Bcore2.1.20261020155253_amd64.deb)
- [at-spi2-doc_2.46.0-5+core2.1.20261020155253_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/at-spi2-doc_2.46.0-5%2Bcore2.1.20261020155253_all.deb)
- [gir1.2-atk-1.0_2.46.0-5+core2.1.20261020155253_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/gir1.2-atk-1.0_2.46.0-5%2Bcore2.1.20261020155253_amd64.deb)
- [gir1.2-atspi-2.0_2.46.0-5+core2.1.20261020155253_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/gir1.2-atspi-2.0_2.46.0-5%2Bcore2.1.20261020155253_amd64.deb)
- [libatk-adaptor_2.46.0-5+core2.1.20261020155253_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/libatk-adaptor_2.46.0-5%2Bcore2.1.20261020155253_amd64.deb)
- [libatk-bridge2.0-0_2.46.0-5+core2.1.20261020155253_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/libatk-bridge2.0-0_2.46.0-5%2Bcore2.1.20261020155253_amd64.deb)
- [libatk-bridge2.0-dev_2.46.0-5+core2.1.20261020155253_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/libatk-bridge2.0-dev_2.46.0-5%2Bcore2.1.20261020155253_amd64.deb)
- [libatk1.0-0_2.46.0-5+core2.1.20261020155253_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/libatk1.0-0_2.46.0-5%2Bcore2.1.20261020155253_amd64.deb)
- [libatk1.0-dev_2.46.0-5+core2.1.20261020155253_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/libatk1.0-dev_2.46.0-5%2Bcore2.1.20261020155253_amd64.deb)
- [libatk1.0-doc_2.46.0-5+core2.1.20261020155253_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/libatk1.0-doc_2.46.0-5%2Bcore2.1.20261020155253_all.deb)
- [libatspi2.0-0_2.46.0-5+core2.1.20261020155253_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/libatspi2.0-0_2.46.0-5%2Bcore2.1.20261020155253_amd64.deb)
- [libatspi2.0-dev_2.46.0-5+core2.1.20261020155253_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253/libatspi2.0-dev_2.46.0-5%2Bcore2.1.20261020155253_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-at-spi2-core-2.46.0-5-core2.1-20261020155253)

### argon2 (optimized)
Version: `0~20171227-0.3+deb12u1+core2.1~20261020155240` · Published: 2026-10-20 15:53:44 UTC
**Description:** memory-hard hashing function - utility
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - argon2`

**Binary downloads:**
- [argon2_0.20171227-0.3+deb12u1+core2.1.20261020155240_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-argon2-0-20171227-0.3-deb12u1-core2.1-20261020155240/argon2_0.20171227-0.3%2Bdeb12u1%2Bcore2.1.20261020155240_amd64.deb)
- [libargon2-0_0.20171227-0.3+deb12u1+core2.1.20261020155240_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-argon2-0-20171227-0.3-deb12u1-core2.1-20261020155240/libargon2-0_0.20171227-0.3%2Bdeb12u1%2Bcore2.1.20261020155240_amd64.deb)
- [libargon2-1_0.20171227-0.3+deb12u1+core2.1.20261020155240_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-argon2-0-20171227-0.3-deb12u1-core2.1-20261020155240/libargon2-1_0.20171227-0.3%2Bdeb12u1%2Bcore2.1.20261020155240_amd64.deb)
- [libargon2-dev_0.20171227-0.3+deb12u1+core2.1.20261020155240_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-argon2-0-20171227-0.3-deb12u1-core2.1-20261020155240/libargon2-dev_0.20171227-0.3%2Bdeb12u1%2Bcore2.1.20261020155240_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-argon2-0-20171227-0.3-deb12u1-core2.1-20261020155240)

### tilda (optimized)
Version: `1.5.4-1+core2.1~20261020154326` · Published: 2026-10-20 15:44:35 UTC
**Description:** GTK+ based drop down terminal for Linux and Unix
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - tilda`

**Binary downloads:**
- [tilda_1.5.4-1+core2.1.20261020154326_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tilda-1.5.4-1-core2.1-20261020154326/tilda_1.5.4-1%2Bcore2.1.20261020154326_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-tilda-1.5.4-1-core2.1-20261020154326)

### rust-bat (optimized)
Version: `0.22.1-4+core2.1~20261018000710` · Published: 2026-10-18 00:12:44 UTC
**Description:** cat(1) clone with syntax highlighting and git integration
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - rust-bat`

**Binary downloads:**
- [bat_0.22.1-4+core2.1.20261018000710_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-rust-bat-0.22.1-4-core2.1-20261018000710/bat_0.22.1-4%2Bcore2.1.20261018000710_amd64.deb)
- [librust-bat-dev_0.22.1-4+core2.1.20261018000710_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-rust-bat-0.22.1-4-core2.1-20261018000710/librust-bat-dev_0.22.1-4%2Bcore2.1.20261018000710_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-rust-bat-0.22.1-4-core2.1-20261018000710)

### telegram-desktop (optimized)
Version: `4.6.5+ds-2+core2.1~20261017193804` · Published: 2026-10-17 20:33:10 UTC
**Description:** fast and secure messaging application
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - telegram-desktop`

**Binary downloads:**
- [telegram-desktop_4.6.5+ds-2+core2.1.20261017193804_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-telegram-desktop-4.6.5-ds-2-core2.1-20261017193804/telegram-desktop_4.6.5%2Bds-2%2Bcore2.1.20261017193804_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-telegram-desktop-4.6.5-ds-2-core2.1-20261017193804)

### libseccomp (system)
Version: `2.5.4-1+deb12u1+core2.1~20261017010131` · Published: 2026-10-17 01:07:04 UTC
**Description:** helper tools for high level interface to Linux seccomp filter
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libseccomp`

**Binary downloads:**
- [libseccomp-dev_2.5.4-1+deb12u1+core2.1.20261017010131_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libseccomp-2.5.4-1-deb12u1-core2.1-20261017010131/libseccomp-dev_2.5.4-1%2Bdeb12u1%2Bcore2.1.20261017010131_amd64.deb)
- [libseccomp2_2.5.4-1+deb12u1+core2.1.20261017010131_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libseccomp-2.5.4-1-deb12u1-core2.1-20261017010131/libseccomp2_2.5.4-1%2Bdeb12u1%2Bcore2.1.20261017010131_amd64.deb)
- [python3-seccomp_2.5.4-1+deb12u1+core2.1.20261017010131_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libseccomp-2.5.4-1-deb12u1-core2.1-20261017010131/python3-seccomp_2.5.4-1%2Bdeb12u1%2Bcore2.1.20261017010131_amd64.deb)
- [seccomp_2.5.4-1+deb12u1+core2.1.20261017010131_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libseccomp-2.5.4-1-deb12u1-core2.1-20261017010131/seccomp_2.5.4-1%2Bdeb12u1%2Bcore2.1.20261017010131_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libseccomp-2.5.4-1-deb12u1-core2.1-20261017010131)

### Mesa (optimized)
Version: `22.3.6-1+deb12u2+core2.1~20261016214939` · Published: 2026-10-16 21:59:48 UTC
**Description:** free implementation of the OpenGL API -- DRI modules
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - mesa`

**Binary downloads:**
- [libegl-mesa0_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libegl-mesa0_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libegl1-mesa-dev_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libegl1-mesa-dev_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libegl1-mesa_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libegl1-mesa_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libgbm-dev_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libgbm-dev_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libgbm1_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libgbm1_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libgl1-mesa-dev_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libgl1-mesa-dev_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libgl1-mesa-dri_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libgl1-mesa-dri_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libgl1-mesa-glx_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libgl1-mesa-glx_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libglapi-mesa_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libglapi-mesa_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libgles2-mesa-dev_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libgles2-mesa-dev_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libgles2-mesa_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libgles2-mesa_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libglx-mesa0_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libglx-mesa0_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libosmesa6-dev_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libosmesa6-dev_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libosmesa6_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libosmesa6_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [libwayland-egl1-mesa_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/libwayland-egl1-mesa_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [mesa-common-dev_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/mesa-common-dev_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [mesa-va-drivers_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/mesa-va-drivers_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
- [mesa-vdpau-drivers_22.3.6-1+deb12u2+core2.1.20261016214939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939/mesa-vdpau-drivers_22.3.6-1%2Bdeb12u2%2Bcore2.1.20261016214939_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-mesa-22.3.6-1-deb12u2-core2.1-20261016214939)

### libmp3lame0 (system)
Version: `3.100-6+core2.1~20261016213051` · Published: 2026-10-16 21:31:29 UTC
**Description:** MP3 encoding library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libmp3lame0`

**Binary downloads:**
- [lame-doc_3.100-6+core2.1.20261016213051_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libmp3lame0-3.100-6-core2.1-20261016213051/lame-doc_3.100-6%2Bcore2.1.20261016213051_all.deb)
- [lame_3.100-6+core2.1.20261016213051_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libmp3lame0-3.100-6-core2.1-20261016213051/lame_3.100-6%2Bcore2.1.20261016213051_amd64.deb)
- [libmp3lame-dev_3.100-6+core2.1.20261016213051_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libmp3lame0-3.100-6-core2.1-20261016213051/libmp3lame-dev_3.100-6%2Bcore2.1.20261016213051_amd64.deb)
- [libmp3lame0_3.100-6+core2.1.20261016213051_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libmp3lame0-3.100-6-core2.1-20261016213051/libmp3lame0_3.100-6%2Bcore2.1.20261016213051_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libmp3lame0-3.100-6-core2.1-20261016213051)

### gst-plugins-bad1.0 (optimized)
Version: `1.22.0-4+deb12u8+core2.1~20261016163835` · Published: 2026-10-16 16:44:20 UTC
**Description:** GStreamer OpenCV libraries
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gst-plugins-bad1.0`

**Binary downloads:**
- [gir1.2-gst-plugins-bad-1.0_1.22.0-4+deb12u8+core2.1.20261016163835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835/gir1.2-gst-plugins-bad-1.0_1.22.0-4%2Bdeb12u8%2Bcore2.1.20261016163835_amd64.deb)
- [gstreamer1.0-opencv_1.22.0-4+deb12u8+core2.1.20261016163835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835/gstreamer1.0-opencv_1.22.0-4%2Bdeb12u8%2Bcore2.1.20261016163835_amd64.deb)
- [gstreamer1.0-plugins-bad-apps_1.22.0-4+deb12u8+core2.1.20261016163835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835/gstreamer1.0-plugins-bad-apps_1.22.0-4%2Bdeb12u8%2Bcore2.1.20261016163835_amd64.deb)
- [gstreamer1.0-plugins-bad_1.22.0-4+deb12u8+core2.1.20261016163835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835/gstreamer1.0-plugins-bad_1.22.0-4%2Bdeb12u8%2Bcore2.1.20261016163835_amd64.deb)
- [gstreamer1.0-wpe_1.22.0-4+deb12u8+core2.1.20261016163835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835/gstreamer1.0-wpe_1.22.0-4%2Bdeb12u8%2Bcore2.1.20261016163835_amd64.deb)
- [libgstreamer-opencv1.0-0_1.22.0-4+deb12u8+core2.1.20261016163835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835/libgstreamer-opencv1.0-0_1.22.0-4%2Bdeb12u8%2Bcore2.1.20261016163835_amd64.deb)
- [libgstreamer-plugins-bad1.0-0_1.22.0-4+deb12u8+core2.1.20261016163835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835/libgstreamer-plugins-bad1.0-0_1.22.0-4%2Bdeb12u8%2Bcore2.1.20261016163835_amd64.deb)
- [libgstreamer-plugins-bad1.0-dev_1.22.0-4+deb12u8+core2.1.20261016163835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835/libgstreamer-plugins-bad1.0-dev_1.22.0-4%2Bdeb12u8%2Bcore2.1.20261016163835_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-bad1.0-1.22.0-4-deb12u8-core2.1-20261016163835)

### vlc (optimized)
Version: `3.0.23-0+deb12u1+core2.1~20261016151852` · Published: 2026-10-16 15:27:01 UTC
**Description:** multimedia player and streamer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - vlc`

**Binary downloads:**
- [libvlc-bin_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/libvlc-bin_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [libvlc-dev_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/libvlc-dev_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [libvlc5_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/libvlc5_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [libvlccore-dev_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/libvlccore-dev_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [libvlccore9_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/libvlccore9_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-bin_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-bin_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-data_3.0.23-0+deb12u1+core2.1.20261016151852_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-data_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_all.deb)
- [vlc-l10n_3.0.23-0+deb12u1+core2.1.20261016151852_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-l10n_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_all.deb)
- [vlc-plugin-access-extra_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-access-extra_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-plugin-base_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-base_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-plugin-fluidsynth_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-fluidsynth_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-plugin-jack_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-jack_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-plugin-notify_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-notify_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-plugin-qt_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-qt_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-plugin-samba_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-samba_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-plugin-skins2_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-skins2_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-plugin-svg_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-svg_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-plugin-video-output_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-video-output_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-plugin-video-splitter_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-video-splitter_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc-plugin-visualization_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc-plugin-visualization_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
- [vlc_3.0.23-0+deb12u1+core2.1.20261016151852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852/vlc_3.0.23-0%2Bdeb12u1%2Bcore2.1.20261016151852_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-vlc-3.0.23-0-deb12u1-core2.1-20261016151852)

### rust-alacritty (optimized)
Version: `0.11.0-4+core2.1~20261016151054` · Published: 2026-10-16 15:17:51 UTC
**Description:** Fast, cross-platform, OpenGL terminal emulator
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - rust-alacritty`

**Binary downloads:**
- [alacritty_0.11.0-4+core2.1.20261016151054_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-rust-alacritty-0.11.0-4-core2.1-20261016151054/alacritty_0.11.0-4%2Bcore2.1.20261016151054_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-rust-alacritty-0.11.0-4-core2.1-20261016151054)

### gstreamer-vaapi (optimized)
Version: `1.22.0-2+core2.1~20261016151532` · Published: 2026-10-16 15:16:38 UTC
**Description:** VA-API plugins for GStreamer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gstreamer-vaapi`

**Binary downloads:**
- [gstreamer1.0-vaapi_1.22.0-2+core2.1.20261016151532_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gstreamer-vaapi-1.22.0-2-core2.1-20261016151532/gstreamer1.0-vaapi_1.22.0-2%2Bcore2.1.20261016151532_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gstreamer-vaapi-1.22.0-2-core2.1-20261016151532)

### libxcb (optimized)
Version: `1.15-1+core2.1~20261016151016` · Published: 2026-10-16 15:14:17 UTC
**Description:** X C Binding, xtest extension
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxcb`

**Binary downloads:**
- [libxcb-composite0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-composite0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-composite0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-composite0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-damage0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-damage0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-damage0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-damage0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-doc_1.15-1+core2.1.20261016151016_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-doc_1.15-1%2Bcore2.1.20261016151016_all.deb)
- [libxcb-dpms0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-dpms0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-dpms0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-dpms0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-dri2-0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-dri2-0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-dri2-0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-dri2-0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-dri3-0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-dri3-0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-dri3-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-dri3-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-glx0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-glx0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-glx0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-glx0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-present-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-present-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-present0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-present0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-randr0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-randr0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-randr0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-randr0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-record0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-record0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-record0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-record0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-render0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-render0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-render0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-render0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-res0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-res0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-res0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-res0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-screensaver0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-screensaver0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-screensaver0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-screensaver0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-shape0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-shape0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-shape0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-shape0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-shm0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-shm0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-shm0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-shm0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-sync-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-sync-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-sync1_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-sync1_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xf86dri0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xf86dri0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xf86dri0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xf86dri0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xfixes0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xfixes0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xfixes0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xfixes0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xinerama0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xinerama0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xinerama0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xinerama0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xinput-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xinput-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xinput0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xinput0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xkb-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xkb-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xkb1_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xkb1_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xtest0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xtest0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xtest0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xtest0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xv0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xv0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xv0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xv0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xvmc0-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xvmc0-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb-xvmc0_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb-xvmc0_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb1-dev_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb1-dev_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
- [libxcb1_1.15-1+core2.1.20261016151016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcb-1.15-1-core2.1-20261016151016/libxcb1_1.15-1%2Bcore2.1.20261016151016_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxcb-1.15-1-core2.1-20261016151016)

### gst-libav1.0 (optimized)
Version: `1.22.0-2+core2.1~20261016151258` · Published: 2026-10-16 15:13:51 UTC
**Description:** ffmpeg plugin for GStreamer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gst-libav1.0`

**Binary downloads:**
- [gstreamer1.0-libav_1.22.0-2+core2.1.20261016151258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-libav1.0-1.22.0-2-core2.1-20261016151258/gstreamer1.0-libav_1.22.0-2%2Bcore2.1.20261016151258_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gst-libav1.0-1.22.0-2-core2.1-20261016151258)

### zlib (optimized)
Version: `1:1.2.13.dfsg-1+core2.1~20261016151112` · Published: 2026-10-16 15:12:18 UTC
**Description:** compression library - 32 bit runtime
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - zlib`

**Binary downloads:**
- [lib32z1-dev_1.2.13.dfsg-1+core2.1.20261016151112_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zlib-1-1.2.13.dfsg-1-core2.1-20261016151112/lib32z1-dev_1.2.13.dfsg-1%2Bcore2.1.20261016151112_amd64.deb)
- [lib32z1_1.2.13.dfsg-1+core2.1.20261016151112_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zlib-1-1.2.13.dfsg-1-core2.1-20261016151112/lib32z1_1.2.13.dfsg-1%2Bcore2.1.20261016151112_amd64.deb)
- [zlib1g-dev_1.2.13.dfsg-1+core2.1.20261016151112_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zlib-1-1.2.13.dfsg-1-core2.1-20261016151112/zlib1g-dev_1.2.13.dfsg-1%2Bcore2.1.20261016151112_amd64.deb)
- [zlib1g_1.2.13.dfsg-1+core2.1.20261016151112_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zlib-1-1.2.13.dfsg-1-core2.1-20261016151112/zlib1g_1.2.13.dfsg-1%2Bcore2.1.20261016151112_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-zlib-1-1.2.13.dfsg-1-core2.1-20261016151112)

### libpng1.6 (optimized)
Version: `1.6.39-2+deb12u6+core2.1~20261016150951` · Published: 2026-10-16 15:11:30 UTC
**Description:** PNG library - tools (version 1.6)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libpng1.6`

**Binary downloads:**
- [libpng-dev_1.6.39-2+deb12u6+core2.1.20261016150951_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libpng1.6-1.6.39-2-deb12u6-core2.1-20261016150951/libpng-dev_1.6.39-2%2Bdeb12u6%2Bcore2.1.20261016150951_amd64.deb)
- [libpng-tools_1.6.39-2+deb12u6+core2.1.20261016150951_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libpng1.6-1.6.39-2-deb12u6-core2.1-20261016150951/libpng-tools_1.6.39-2%2Bdeb12u6%2Bcore2.1.20261016150951_amd64.deb)
- [libpng16-16_1.6.39-2+deb12u6+core2.1.20261016150951_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libpng1.6-1.6.39-2-deb12u6-core2.1-20261016150951/libpng16-16_1.6.39-2%2Bdeb12u6%2Bcore2.1.20261016150951_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libpng1.6-1.6.39-2-deb12u6-core2.1-20261016150951)

### libxdmcp (optimized)
Version: `1:1.1.2-3+core2.1~20261016151011` · Published: 2026-10-16 15:11:01 UTC
**Description:** X11 Display Manager Control Protocol library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxdmcp`

**Binary downloads:**
- [libxdmcp-dev_1.1.2-3+core2.1.20261016151011_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxdmcp-1-1.1.2-3-core2.1-20261016151011/libxdmcp-dev_1.1.2-3%2Bcore2.1.20261016151011_amd64.deb)
- [libxdmcp6_1.1.2-3+core2.1.20261016151011_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxdmcp-1-1.1.2-3-core2.1-20261016151011/libxdmcp6_1.1.2-3%2Bcore2.1.20261016151011_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxdmcp-1-1.1.2-3-core2.1-20261016151011)

### fontconfig (optimized)
Version: `2.14.1-4+core2.1~20261016150850` · Published: 2026-10-16 15:11:01 UTC
**Description:** generic font configuration library - support binaries
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - fontconfig`

**Binary downloads:**
- [fontconfig-config_2.14.1-4+core2.1.20261016150850_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fontconfig-2.14.1-4-core2.1-20261016150850/fontconfig-config_2.14.1-4%2Bcore2.1.20261016150850_amd64.deb)
- [fontconfig_2.14.1-4+core2.1.20261016150850_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fontconfig-2.14.1-4-core2.1-20261016150850/fontconfig_2.14.1-4%2Bcore2.1.20261016150850_amd64.deb)
- [libfontconfig-dev_2.14.1-4+core2.1.20261016150850_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fontconfig-2.14.1-4-core2.1-20261016150850/libfontconfig-dev_2.14.1-4%2Bcore2.1.20261016150850_amd64.deb)
- [libfontconfig-doc_2.14.1-4+core2.1.20261016150850_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fontconfig-2.14.1-4-core2.1-20261016150850/libfontconfig-doc_2.14.1-4%2Bcore2.1.20261016150850_all.deb)
- [libfontconfig1-dev_2.14.1-4+core2.1.20261016150850_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fontconfig-2.14.1-4-core2.1-20261016150850/libfontconfig1-dev_2.14.1-4%2Bcore2.1.20261016150850_amd64.deb)
- [libfontconfig1_2.14.1-4+core2.1.20261016150850_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fontconfig-2.14.1-4-core2.1-20261016150850/libfontconfig1_2.14.1-4%2Bcore2.1.20261016150850_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-fontconfig-2.14.1-4-core2.1-20261016150850)

### libxau (optimized)
Version: `1:1.0.9-1+core2.1~20261016151004` · Published: 2026-10-16 15:10:59 UTC
**Description:** X11 authorisation library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxau`

**Binary downloads:**
- [libxau-dev_1.0.9-1+core2.1.20261016151004_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxau-1-1.0.9-1-core2.1-20261016151004/libxau-dev_1.0.9-1%2Bcore2.1.20261016151004_amd64.deb)
- [libxau6_1.0.9-1+core2.1.20261016151004_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxau-1-1.0.9-1-core2.1-20261016151004/libxau6_1.0.9-1%2Bcore2.1.20261016151004_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxau-1-1.0.9-1-core2.1-20261016151004)

### libmd (optimized)
Version: `1.0.4-2+core2.1~20261016150931` · Published: 2026-10-16 15:10:25 UTC
**Description:** message digest functions from BSD systems - shared library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libmd`

**Binary downloads:**
- [libmd-dev_1.0.4-2+core2.1.20261016150931_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libmd-1.0.4-2-core2.1-20261016150931/libmd-dev_1.0.4-2%2Bcore2.1.20261016150931_amd64.deb)
- [libmd0_1.0.4-2+core2.1.20261016150931_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libmd-1.0.4-2-core2.1-20261016150931/libmd0_1.0.4-2%2Bcore2.1.20261016150931_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libmd-1.0.4-2-core2.1-20261016150931)

### libbsd (optimized)
Version: `0.11.7-2+core2.1~20261016150833` · Published: 2026-10-16 15:09:36 UTC
**Description:** utility functions from BSD systems - shared library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libbsd`

**Binary downloads:**
- [libbsd-dev_0.11.7-2+core2.1.20261016150833_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libbsd-0.11.7-2-core2.1-20261016150833/libbsd-dev_0.11.7-2%2Bcore2.1.20261016150833_amd64.deb)
- [libbsd0_0.11.7-2+core2.1.20261016150833_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libbsd-0.11.7-2-core2.1-20261016150833/libbsd0_0.11.7-2%2Bcore2.1.20261016150833_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libbsd-0.11.7-2-core2.1-20261016150833)

### freetype (optimized)
Version: `2.12.1+dfsg-5+deb12u4+core2.1~20261016150739` · Published: 2026-10-16 15:09:31 UTC
**Description:** FreeType 2 demonstration programs
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - freetype`

**Binary downloads:**
- [freetype2-demos_2.12.1+dfsg-5+deb12u4+core2.1.20261016150739_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-freetype-2.12.1-dfsg-5-deb12u4-core2.1-20261016150739/freetype2-demos_2.12.1%2Bdfsg-5%2Bdeb12u4%2Bcore2.1.20261016150739_amd64.deb)
- [freetype2-doc_2.12.1+dfsg-5+deb12u4+core2.1.20261016150739_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-freetype-2.12.1-dfsg-5-deb12u4-core2.1-20261016150739/freetype2-doc_2.12.1%2Bdfsg-5%2Bdeb12u4%2Bcore2.1.20261016150739_all.deb)
- [libfreetype-dev_2.12.1+dfsg-5+deb12u4+core2.1.20261016150739_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-freetype-2.12.1-dfsg-5-deb12u4-core2.1-20261016150739/libfreetype-dev_2.12.1%2Bdfsg-5%2Bdeb12u4%2Bcore2.1.20261016150739_amd64.deb)
- [libfreetype6-dev_2.12.1+dfsg-5+deb12u4+core2.1.20261016150739_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-freetype-2.12.1-dfsg-5-deb12u4-core2.1-20261016150739/libfreetype6-dev_2.12.1%2Bdfsg-5%2Bdeb12u4%2Bcore2.1.20261016150739_amd64.deb)
- [libfreetype6_2.12.1+dfsg-5+deb12u4+core2.1.20261016150739_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-freetype-2.12.1-dfsg-5-deb12u4-core2.1-20261016150739/libfreetype6_2.12.1%2Bdfsg-5%2Bdeb12u4%2Bcore2.1.20261016150739_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-freetype-2.12.1-dfsg-5-deb12u4-core2.1-20261016150739)

### fonts-dejavu (optimized)
Version: `2.37-6+core2.1~20261016150744` · Published: 2026-10-16 15:09:21 UTC
**Description:** metapackage to pull in fonts-dejavu-core and fonts-dejavu-extra
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - fonts-dejavu`

**Binary downloads:**
- [fonts-dejavu-core_2.37-6+core2.1.20261016150744_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fonts-dejavu-2.37-6-core2.1-20261016150744/fonts-dejavu-core_2.37-6%2Bcore2.1.20261016150744_all.deb)
- [fonts-dejavu-extra_2.37-6+core2.1.20261016150744_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fonts-dejavu-2.37-6-core2.1-20261016150744/fonts-dejavu-extra_2.37-6%2Bcore2.1.20261016150744_all.deb)
- [fonts-dejavu-web_2.37-6+core2.1.20261016150744_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fonts-dejavu-2.37-6-core2.1-20261016150744/fonts-dejavu-web_2.37-6%2Bcore2.1.20261016150744_all.deb)
- [fonts-dejavu_2.37-6+core2.1.20261016150744_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fonts-dejavu-2.37-6-core2.1-20261016150744/fonts-dejavu_2.37-6%2Bcore2.1.20261016150744_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-fonts-dejavu-2.37-6-core2.1-20261016150744)

### brotli (optimized)
Version: `1.0.9-2+core2.1~20261016150736` · Published: 2026-10-16 15:09:19 UTC
**Description:** lossless compression algorithm and format (command line utility)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - brotli`

**Binary downloads:**
- [brotli_1.0.9-2+core2.1.20261016150736_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-brotli-1.0.9-2-core2.1-20261016150736/brotli_1.0.9-2%2Bcore2.1.20261016150736_amd64.deb)
- [libbrotli-dev_1.0.9-2+core2.1.20261016150736_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-brotli-1.0.9-2-core2.1-20261016150736/libbrotli-dev_1.0.9-2%2Bcore2.1.20261016150736_amd64.deb)
- [libbrotli1_1.0.9-2+core2.1.20261016150736_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-brotli-1.0.9-2-core2.1-20261016150736/libbrotli1_1.0.9-2%2Bcore2.1.20261016150736_amd64.deb)
- [python3-brotli_1.0.9-2+core2.1.20261016150736_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-brotli-1.0.9-2-core2.1-20261016150736/python3-brotli_1.0.9-2%2Bcore2.1.20261016150736_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-brotli-1.0.9-2-core2.1-20261016150736)

### expat (optimized)
Version: `2.5.0-1+deb12u4+core2.1~20261016150748` · Published: 2026-10-16 15:08:59 UTC
**Description:** XML parsing C library - example application
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - expat`

**Binary downloads:**
- [expat_2.5.0-1+deb12u4+core2.1.20261016150748_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-expat-2.5.0-1-deb12u4-core2.1-20261016150748/expat_2.5.0-1%2Bdeb12u4%2Bcore2.1.20261016150748_amd64.deb)
- [libexpat1-dev_2.5.0-1+deb12u4+core2.1.20261016150748_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-expat-2.5.0-1-deb12u4-core2.1-20261016150748/libexpat1-dev_2.5.0-1%2Bdeb12u4%2Bcore2.1.20261016150748_amd64.deb)
- [libexpat1_2.5.0-1+deb12u4+core2.1.20261016150748_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-expat-2.5.0-1-deb12u4-core2.1-20261016150748/libexpat1_2.5.0-1%2Bdeb12u4%2Bcore2.1.20261016150748_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-expat-2.5.0-1-deb12u4-core2.1-20261016150748)

### libtheora (optimized)
Version: `1.1.1+dfsg.1-16.1+deb12u1+core2.1~20261016150347` · Published: 2026-10-16 15:04:56 UTC
**Description:** Theora Video Compression Codec (example encoder, decoder)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libtheora`

**Binary downloads:**
- [libtheora-bin_1.1.1+dfsg.1-16.1+deb12u1+core2.1.20261016150347_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libtheora-1.1.1-dfsg.1-16.1-deb12u1-core2.1-20261016150347/libtheora-bin_1.1.1%2Bdfsg.1-16.1%2Bdeb12u1%2Bcore2.1.20261016150347_amd64.deb)
- [libtheora-dev_1.1.1+dfsg.1-16.1+deb12u1+core2.1.20261016150347_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libtheora-1.1.1-dfsg.1-16.1-deb12u1-core2.1-20261016150347/libtheora-dev_1.1.1%2Bdfsg.1-16.1%2Bdeb12u1%2Bcore2.1.20261016150347_amd64.deb)
- [libtheora-doc_1.1.1+dfsg.1-16.1+deb12u1+core2.1.20261016150347_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libtheora-1.1.1-dfsg.1-16.1-deb12u1-core2.1-20261016150347/libtheora-doc_1.1.1%2Bdfsg.1-16.1%2Bdeb12u1%2Bcore2.1.20261016150347_all.deb)
- [libtheora0_1.1.1+dfsg.1-16.1+deb12u1+core2.1.20261016150347_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libtheora-1.1.1-dfsg.1-16.1-deb12u1-core2.1-20261016150347/libtheora0_1.1.1%2Bdfsg.1-16.1%2Bdeb12u1%2Bcore2.1.20261016150347_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libtheora-1.1.1-dfsg.1-16.1-deb12u1-core2.1-20261016150347)

### xvidcore (optimized)
Version: `2:1.3.7-1+core2.1~20261016150055` · Published: 2026-10-16 15:01:51 UTC
**Description:** Open source MPEG-4 video codec (library)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xvidcore`

**Binary downloads:**
- [libxvidcore-dev_1.3.7-1+core2.1.20261016150055_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xvidcore-2-1.3.7-1-core2.1-20261016150055/libxvidcore-dev_1.3.7-1%2Bcore2.1.20261016150055_amd64.deb)
- [libxvidcore4_1.3.7-1+core2.1.20261016150055_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xvidcore-2-1.3.7-1-core2.1-20261016150055/libxvidcore4_1.3.7-1%2Bcore2.1.20261016150055_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xvidcore-2-1.3.7-1-core2.1-20261016150055)

### mpeg2dec (optimized)
Version: `0.5.1-9+core2.1~20261016145852` · Published: 2026-10-16 14:59:50 UTC
**Description:** Simple libmpeg2 video decoder application
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - mpeg2dec`

**Binary downloads:**
- [libmpeg2-4-dev_0.5.1-9+core2.1.20261016145852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mpeg2dec-0.5.1-9-core2.1-20261016145852/libmpeg2-4-dev_0.5.1-9%2Bcore2.1.20261016145852_amd64.deb)
- [libmpeg2-4_0.5.1-9+core2.1.20261016145852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mpeg2dec-0.5.1-9-core2.1-20261016145852/libmpeg2-4_0.5.1-9%2Bcore2.1.20261016145852_amd64.deb)
- [mpeg2dec_0.5.1-9+core2.1.20261016145852_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mpeg2dec-0.5.1-9-core2.1-20261016145852/mpeg2dec_0.5.1-9%2Bcore2.1.20261016145852_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-mpeg2dec-0.5.1-9-core2.1-20261016145852)

### x265 (optimized)
Version: `3.5-2+core2.1~20261016145405` · Published: 2026-10-16 14:57:50 UTC
**Description:** H.265/HEVC video stream encoder
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - x265`

**Binary downloads:**
- [libx265-199_3.5-2+core2.1.20261016145405_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-x265-3.5-2-core2.1-20261016145405/libx265-199_3.5-2%2Bcore2.1.20261016145405_amd64.deb)
- [libx265-dev_3.5-2+core2.1.20261016145405_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-x265-3.5-2-core2.1-20261016145405/libx265-dev_3.5-2%2Bcore2.1.20261016145405_amd64.deb)
- [libx265-doc_3.5-2+core2.1.20261016145405_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-x265-3.5-2-core2.1-20261016145405/libx265-doc_3.5-2%2Bcore2.1.20261016145405_all.deb)
- [x265_3.5-2+core2.1.20261016145405_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-x265-3.5-2-core2.1-20261016145405/x265_3.5-2%2Bcore2.1.20261016145405_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-x265-3.5-2-core2.1-20261016145405)

### x264 (optimized)
Version: `2:0.164.3095+gitbaee400-3+core2.1~20261016145121` · Published: 2026-10-16 14:53:17 UTC
**Description:** video encoder for the H.264/MPEG-4 AVC standard
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - x264`

**Binary downloads:**
- [libx264-164_0.164.3095+gitbaee400-3+core2.1.20261016145121_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-x264-2-0.164.3095-gitbaee400-3-core2.1-20261016145121/libx264-164_0.164.3095%2Bgitbaee400-3%2Bcore2.1.20261016145121_amd64.deb)
- [libx264-dev_0.164.3095+gitbaee400-3+core2.1.20261016145121_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-x264-2-0.164.3095-gitbaee400-3-core2.1-20261016145121/libx264-dev_0.164.3095%2Bgitbaee400-3%2Bcore2.1.20261016145121_amd64.deb)
- [x264_0.164.3095+gitbaee400-3+core2.1.20261016145121_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-x264-2-0.164.3095-gitbaee400-3-core2.1-20261016145121/x264_0.164.3095%2Bgitbaee400-3%2Bcore2.1.20261016145121_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-x264-2-0.164.3095-gitbaee400-3-core2.1-20261016145121)

### svt-av1 (optimized)
Version: `1.4.1+dfsg-1+core2.1~20261016144712` · Published: 2026-10-16 14:50:22 UTC
**Description:** Scalable Video Technology for AV1 (SVT-AV1 Encoder and Decoder)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - svt-av1`

**Binary downloads:**
- [libsvtav1-dev_1.4.1+dfsg-1+core2.1.20261016144712_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-svt-av1-1.4.1-dfsg-1-core2.1-20261016144712/libsvtav1-dev_1.4.1%2Bdfsg-1%2Bcore2.1.20261016144712_all.deb)
- [libsvtav1dec-dev_1.4.1+dfsg-1+core2.1.20261016144712_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-svt-av1-1.4.1-dfsg-1-core2.1-20261016144712/libsvtav1dec-dev_1.4.1%2Bdfsg-1%2Bcore2.1.20261016144712_amd64.deb)
- [libsvtav1dec0_1.4.1+dfsg-1+core2.1.20261016144712_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-svt-av1-1.4.1-dfsg-1-core2.1-20261016144712/libsvtav1dec0_1.4.1%2Bdfsg-1%2Bcore2.1.20261016144712_amd64.deb)
- [libsvtav1enc-dev_1.4.1+dfsg-1+core2.1.20261016144712_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-svt-av1-1.4.1-dfsg-1-core2.1-20261016144712/libsvtav1enc-dev_1.4.1%2Bdfsg-1%2Bcore2.1.20261016144712_amd64.deb)
- [libsvtav1enc1_1.4.1+dfsg-1+core2.1.20261016144712_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-svt-av1-1.4.1-dfsg-1-core2.1-20261016144712/libsvtav1enc1_1.4.1%2Bdfsg-1%2Bcore2.1.20261016144712_amd64.deb)
- [svt-av1_1.4.1+dfsg-1+core2.1.20261016144712_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-svt-av1-1.4.1-dfsg-1-core2.1-20261016144712/svt-av1_1.4.1%2Bdfsg-1%2Bcore2.1.20261016144712_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-svt-av1-1.4.1-dfsg-1-core2.1-20261016144712)

### aom (optimized)
Version: `3.6.0-1+deb12u3+core2.1~20261016144330` · Published: 2026-10-16 14:46:13 UTC
**Description:** AV1 Video Codec Library -- Tools
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - aom`

**Binary downloads:**
- [aom-tools_3.6.0-1+deb12u3+core2.1.20261016144330_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-aom-3.6.0-1-deb12u3-core2.1-20261016144330/aom-tools_3.6.0-1%2Bdeb12u3%2Bcore2.1.20261016144330_amd64.deb)
- [libaom-dev_3.6.0-1+deb12u3+core2.1.20261016144330_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-aom-3.6.0-1-deb12u3-core2.1-20261016144330/libaom-dev_3.6.0-1%2Bdeb12u3%2Bcore2.1.20261016144330_amd64.deb)
- [libaom-doc_3.6.0-1+deb12u3+core2.1.20261016144330_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-aom-3.6.0-1-deb12u3-core2.1-20261016144330/libaom-doc_3.6.0-1%2Bdeb12u3%2Bcore2.1.20261016144330_all.deb)
- [libaom3_3.6.0-1+deb12u3+core2.1.20261016144330_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-aom-3.6.0-1-deb12u3-core2.1-20261016144330/libaom3_3.6.0-1%2Bdeb12u3%2Bcore2.1.20261016144330_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-aom-3.6.0-1-deb12u3-core2.1-20261016144330)

### dav1d (optimized)
Version: `1.0.0-2+deb12u1+core2.1~20261016144008` · Published: 2026-10-16 14:41:59 UTC
**Description:** fast and small AV1 video stream decoder
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - dav1d`

**Binary downloads:**
- [dav1d_1.0.0-2+deb12u1+core2.1.20261016144008_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dav1d-1.0.0-2-deb12u1-core2.1-20261016144008/dav1d_1.0.0-2%2Bdeb12u1%2Bcore2.1.20261016144008_amd64.deb)
- [libdav1d-dev_1.0.0-2+deb12u1+core2.1.20261016144008_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dav1d-1.0.0-2-deb12u1-core2.1-20261016144008/libdav1d-dev_1.0.0-2%2Bdeb12u1%2Bcore2.1.20261016144008_amd64.deb)
- [libdav1d6_1.0.0-2+deb12u1+core2.1.20261016144008_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dav1d-1.0.0-2-deb12u1-core2.1-20261016144008/libdav1d6_1.0.0-2%2Bdeb12u1%2Bcore2.1.20261016144008_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-dav1d-1.0.0-2-deb12u1-core2.1-20261016144008)

### libopenmpt (optimized)
Version: `0.6.9-1+core2.1~20261016143234` · Published: 2026-10-16 14:39:13 UTC
**Description:** module music library based on OpenMPT -- music player
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libopenmpt`

**Binary downloads:**
- [libopenmpt-dev_0.6.9-1+core2.1.20261016143234_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libopenmpt-0.6.9-1-core2.1-20261016143234/libopenmpt-dev_0.6.9-1%2Bcore2.1.20261016143234_amd64.deb)
- [libopenmpt-doc_0.6.9-1+core2.1.20261016143234_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libopenmpt-0.6.9-1-core2.1-20261016143234/libopenmpt-doc_0.6.9-1%2Bcore2.1.20261016143234_all.deb)
- [libopenmpt0_0.6.9-1+core2.1.20261016143234_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libopenmpt-0.6.9-1-core2.1-20261016143234/libopenmpt0_0.6.9-1%2Bcore2.1.20261016143234_amd64.deb)
- [openmpt123_0.6.9-1+core2.1.20261016143234_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libopenmpt-0.6.9-1-core2.1-20261016143234/openmpt123_0.6.9-1%2Bcore2.1.20261016143234_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libopenmpt-0.6.9-1-core2.1-20261016143234)

### orc (optimized)
Version: `1:0.4.33-2+core2.1~20261016143016` · Published: 2026-10-16 14:31:28 UTC
**Description:** Library of Optimized Inner Loops Runtime Compiler (development tools)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - orc`

**Binary downloads:**
- [liborc-0.4-0_0.4.33-2+core2.1.20261016143016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-orc-1-0.4.33-2-core2.1-20261016143016/liborc-0.4-0_0.4.33-2%2Bcore2.1.20261016143016_amd64.deb)
- [liborc-0.4-dev-bin_0.4.33-2+core2.1.20261016143016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-orc-1-0.4.33-2-core2.1-20261016143016/liborc-0.4-dev-bin_0.4.33-2%2Bcore2.1.20261016143016_amd64.deb)
- [liborc-0.4-dev_0.4.33-2+core2.1.20261016143016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-orc-1-0.4.33-2-core2.1-20261016143016/liborc-0.4-dev_0.4.33-2%2Bcore2.1.20261016143016_amd64.deb)
- [liborc-0.4-doc_0.4.33-2+core2.1.20261016143016_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-orc-1-0.4.33-2-core2.1-20261016143016/liborc-0.4-doc_0.4.33-2%2Bcore2.1.20261016143016_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-orc-1-0.4.33-2-core2.1-20261016143016)

### libass (optimized)
Version: `1:0.17.1-1+deb12u1+core2.1~20261016142820` · Published: 2026-10-16 14:29:17 UTC
**Description:** library for SSA/ASS subtitles rendering
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libass`

**Binary downloads:**
- [libass-dev_0.17.1-1+deb12u1+core2.1.20261016142820_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libass-1-0.17.1-1-deb12u1-core2.1-20261016142820/libass-dev_0.17.1-1%2Bdeb12u1%2Bcore2.1.20261016142820_amd64.deb)
- [libass9_0.17.1-1+deb12u1+core2.1.20261016142820_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libass-1-0.17.1-1-deb12u1-core2.1-20261016142820/libass9_0.17.1-1%2Bdeb12u1%2Bcore2.1.20261016142820_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libass-1-0.17.1-1-deb12u1-core2.1-20261016142820)

### libplacebo (optimized)
Version: `4.208.0-3+core2.1~20261016142619` · Published: 2026-10-16 14:27:16 UTC
**Description:** GPU-accelerated video/image rendering primitives (shared library)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libplacebo`

**Binary downloads:**
- [libplacebo-dev_4.208.0-3+core2.1.20261016142619_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libplacebo-4.208.0-3-core2.1-20261016142619/libplacebo-dev_4.208.0-3%2Bcore2.1.20261016142619_amd64.deb)
- [libplacebo208_4.208.0-3+core2.1.20261016142619_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libplacebo-4.208.0-3-core2.1-20261016142619/libplacebo208_4.208.0-3%2Bcore2.1.20261016142619_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libplacebo-4.208.0-3-core2.1-20261016142619)

### libvdpau (optimized)
Version: `1.5-2+core2.1~20261016142429` · Published: 2026-10-16 14:25:24 UTC
**Description:** Video Decode and Presentation API for Unix (driver metapackage)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libvdpau`

**Binary downloads:**
- [libvdpau-dev_1.5-2+core2.1.20261016142429_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libvdpau-1.5-2-core2.1-20261016142429/libvdpau-dev_1.5-2%2Bcore2.1.20261016142429_amd64.deb)
- [libvdpau-doc_1.5-2+core2.1.20261016142429_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libvdpau-1.5-2-core2.1-20261016142429/libvdpau-doc_1.5-2%2Bcore2.1.20261016142429_all.deb)
- [libvdpau1_1.5-2+core2.1.20261016142429_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libvdpau-1.5-2-core2.1-20261016142429/libvdpau1_1.5-2%2Bcore2.1.20261016142429_amd64.deb)
- [vdpau-driver-all_1.5-2+core2.1.20261016142429_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libvdpau-1.5-2-core2.1-20261016142429/vdpau-driver-all_1.5-2%2Bcore2.1.20261016142429_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libvdpau-1.5-2-core2.1-20261016142429)

### intel-media-driver (optimized)
Version: `23.1.1+dfsg1-1+core2.1~20261016140210` · Published: 2026-10-16 14:22:32 UTC
**Description:** Intel C for Media Runtime -- shared library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - intel-media-driver`

**Binary downloads:**
- [intel-media-va-driver_23.1.1+dfsg1-1+core2.1.20261016140210_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-intel-media-driver-23.1.1-dfsg1-1-core2.1-20261016140210/intel-media-va-driver_23.1.1%2Bdfsg1-1%2Bcore2.1.20261016140210_amd64.deb)
- [libigfxcmrt-dev_23.1.1+dfsg1-1+core2.1.20261016140210_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-intel-media-driver-23.1.1-dfsg1-1-core2.1-20261016140210/libigfxcmrt-dev_23.1.1%2Bdfsg1-1%2Bcore2.1.20261016140210_amd64.deb)
- [libigfxcmrt7_23.1.1+dfsg1-1+core2.1.20261016140210_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-intel-media-driver-23.1.1-dfsg1-1-core2.1-20261016140210/libigfxcmrt7_23.1.1%2Bdfsg1-1%2Bcore2.1.20261016140210_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-intel-media-driver-23.1.1-dfsg1-1-core2.1-20261016140210)

### intel-vaapi-driver (optimized)
Version: `2.4.1+dfsg1-1+core2.1~20261016135957` · Published: 2026-10-16 14:01:08 UTC
**Description:** VAAPI driver for Intel G45 & HD Graphics family
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - intel-vaapi-driver`

**Binary downloads:**
- [i965-va-driver_2.4.1+dfsg1-1+core2.1.20261016135957_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-intel-vaapi-driver-2.4.1-dfsg1-1-core2.1-20261016135957/i965-va-driver_2.4.1%2Bdfsg1-1%2Bcore2.1.20261016135957_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-intel-vaapi-driver-2.4.1-dfsg1-1-core2.1-20261016135957)

### libva (optimized)
Version: `2.17.0-1+core2.1~20261016135745` · Published: 2026-10-16 13:58:54 UTC
**Description:** Video Acceleration (VA) API -- driver metapackage
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libva`

**Binary downloads:**
- [libva-dev_2.17.0-1+core2.1.20261016135745_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libva-2.17.0-1-core2.1-20261016135745/libva-dev_2.17.0-1%2Bcore2.1.20261016135745_amd64.deb)
- [libva-drm2_2.17.0-1+core2.1.20261016135745_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libva-2.17.0-1-core2.1-20261016135745/libva-drm2_2.17.0-1%2Bcore2.1.20261016135745_amd64.deb)
- [libva-glx2_2.17.0-1+core2.1.20261016135745_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libva-2.17.0-1-core2.1-20261016135745/libva-glx2_2.17.0-1%2Bcore2.1.20261016135745_amd64.deb)
- [libva-wayland2_2.17.0-1+core2.1.20261016135745_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libva-2.17.0-1-core2.1-20261016135745/libva-wayland2_2.17.0-1%2Bcore2.1.20261016135745_amd64.deb)
- [libva-x11-2_2.17.0-1+core2.1.20261016135745_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libva-2.17.0-1-core2.1-20261016135745/libva-x11-2_2.17.0-1%2Bcore2.1.20261016135745_amd64.deb)
- [libva2_2.17.0-1+core2.1.20261016135745_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libva-2.17.0-1-core2.1-20261016135745/libva2_2.17.0-1%2Bcore2.1.20261016135745_amd64.deb)
- [va-driver-all_2.17.0-1+core2.1.20261016135745_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libva-2.17.0-1-core2.1-20261016135745/va-driver-all_2.17.0-1%2Bcore2.1.20261016135745_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libva-2.17.0-1-core2.1-20261016135745)

### cairo (optimized)
Version: `1.16.0-7+core2.1~20261016135244` · Published: 2026-10-16 13:56:48 UTC
**Description:** Cairo 2D vector graphics library (GObject library)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - cairo`

**Binary downloads:**
- [cairo-perf-utils_1.16.0-7+core2.1.20261016135244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cairo-1.16.0-7-core2.1-20261016135244/cairo-perf-utils_1.16.0-7%2Bcore2.1.20261016135244_amd64.deb)
- [libcairo-gobject2_1.16.0-7+core2.1.20261016135244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cairo-1.16.0-7-core2.1-20261016135244/libcairo-gobject2_1.16.0-7%2Bcore2.1.20261016135244_amd64.deb)
- [libcairo-script-interpreter2_1.16.0-7+core2.1.20261016135244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cairo-1.16.0-7-core2.1-20261016135244/libcairo-script-interpreter2_1.16.0-7%2Bcore2.1.20261016135244_amd64.deb)
- [libcairo2-dev_1.16.0-7+core2.1.20261016135244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cairo-1.16.0-7-core2.1-20261016135244/libcairo2-dev_1.16.0-7%2Bcore2.1.20261016135244_amd64.deb)
- [libcairo2-doc_1.16.0-7+core2.1.20261016135244_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cairo-1.16.0-7-core2.1-20261016135244/libcairo2-doc_1.16.0-7%2Bcore2.1.20261016135244_all.deb)
- [libcairo2_1.16.0-7+core2.1.20261016135244_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cairo-1.16.0-7-core2.1-20261016135244/libcairo2_1.16.0-7%2Bcore2.1.20261016135244_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-cairo-1.16.0-7-core2.1-20261016135244)

### openjpeg2 (optimized)
Version: `2.5.0-2+deb12u3+core2.1~20261016135019` · Published: 2026-10-16 13:51:38 UTC
**Description:** tool to allow caching of JPEG 2000 files using JPIP protocol
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - openjpeg2`

**Binary downloads:**
- [libopenjp2-7-dev_2.5.0-2+deb12u3+core2.1.20261016135019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019/libopenjp2-7-dev_2.5.0-2%2Bdeb12u3%2Bcore2.1.20261016135019_amd64.deb)
- [libopenjp2-7_2.5.0-2+deb12u3+core2.1.20261016135019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019/libopenjp2-7_2.5.0-2%2Bdeb12u3%2Bcore2.1.20261016135019_amd64.deb)
- [libopenjp2-tools_2.5.0-2+deb12u3+core2.1.20261016135019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019/libopenjp2-tools_2.5.0-2%2Bdeb12u3%2Bcore2.1.20261016135019_amd64.deb)
- [libopenjpip-dec-server_2.5.0-2+deb12u3+core2.1.20261016135019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019/libopenjpip-dec-server_2.5.0-2%2Bdeb12u3%2Bcore2.1.20261016135019_amd64.deb)
- [libopenjpip-server_2.5.0-2+deb12u3+core2.1.20261016135019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019/libopenjpip-server_2.5.0-2%2Bdeb12u3%2Bcore2.1.20261016135019_amd64.deb)
- [libopenjpip-viewer_2.5.0-2+deb12u3+core2.1.20261016135019_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019/libopenjpip-viewer_2.5.0-2%2Bdeb12u3%2Bcore2.1.20261016135019_all.deb)
- [libopenjpip7_2.5.0-2+deb12u3+core2.1.20261016135019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019/libopenjpip7_2.5.0-2%2Bdeb12u3%2Bcore2.1.20261016135019_amd64.deb)
- [openjpeg-doc_2.5.0-2+deb12u3+core2.1.20261016135019_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019/openjpeg-doc_2.5.0-2%2Bdeb12u3%2Bcore2.1.20261016135019_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-openjpeg2-2.5.0-2-deb12u3-core2.1-20261016135019)

### libsdl2 (optimized)
Version: `2.26.5+dfsg-1+core2.1~20261016134254` · Published: 2026-10-16 13:46:08 UTC
**Description:** Simple DirectMedia Layer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libsdl2`

**Binary downloads:**
- [libsdl2-2.0-0_2.26.5+dfsg-1+core2.1.20261016134254_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsdl2-2.26.5-dfsg-1-core2.1-20261016134254/libsdl2-2.0-0_2.26.5%2Bdfsg-1%2Bcore2.1.20261016134254_amd64.deb)
- [libsdl2-dev_2.26.5+dfsg-1+core2.1.20261016134254_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsdl2-2.26.5-dfsg-1-core2.1-20261016134254/libsdl2-dev_2.26.5%2Bdfsg-1%2Bcore2.1.20261016134254_amd64.deb)
- [libsdl2-doc_2.26.5+dfsg-1+core2.1.20261016134254_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsdl2-2.26.5-dfsg-1-core2.1-20261016134254/libsdl2-doc_2.26.5%2Bdfsg-1%2Bcore2.1.20261016134254_all.deb)
- [libsdl2-tests_2.26.5+dfsg-1+core2.1.20261016134254_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libsdl2-2.26.5-dfsg-1-core2.1-20261016134254/libsdl2-tests_2.26.5%2Bdfsg-1%2Bcore2.1.20261016134254_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libsdl2-2.26.5-dfsg-1-core2.1-20261016134254)

### libepoxy (optimized)
Version: `1.5.10-1+core2.1~20261016134055` · Published: 2026-10-16 13:41:52 UTC
**Description:** OpenGL function pointer management library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libepoxy`

**Binary downloads:**
- [libepoxy-dev_1.5.10-1+core2.1.20261016134055_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libepoxy-1.5.10-1-core2.1-20261016134055/libepoxy-dev_1.5.10-1%2Bcore2.1.20261016134055_amd64.deb)
- [libepoxy0_1.5.10-1+core2.1.20261016134055_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libepoxy-1.5.10-1-core2.1-20261016134055/libepoxy0_1.5.10-1%2Bcore2.1.20261016134055_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libepoxy-1.5.10-1-core2.1-20261016134055)

### wayland (optimized)
Version: `1.21.0-1+core2.1~20261016133904` · Published: 2026-10-16 13:40:07 UTC
**Description:** wayland compositor infrastructure - EGL library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - wayland`

**Binary downloads:**
- [libwayland-bin_1.21.0-1+core2.1.20261016133904_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wayland-1.21.0-1-core2.1-20261016133904/libwayland-bin_1.21.0-1%2Bcore2.1.20261016133904_amd64.deb)
- [libwayland-client0_1.21.0-1+core2.1.20261016133904_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wayland-1.21.0-1-core2.1-20261016133904/libwayland-client0_1.21.0-1%2Bcore2.1.20261016133904_amd64.deb)
- [libwayland-cursor0_1.21.0-1+core2.1.20261016133904_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wayland-1.21.0-1-core2.1-20261016133904/libwayland-cursor0_1.21.0-1%2Bcore2.1.20261016133904_amd64.deb)
- [libwayland-dev_1.21.0-1+core2.1.20261016133904_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wayland-1.21.0-1-core2.1-20261016133904/libwayland-dev_1.21.0-1%2Bcore2.1.20261016133904_amd64.deb)
- [libwayland-doc_1.21.0-1+core2.1.20261016133904_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wayland-1.21.0-1-core2.1-20261016133904/libwayland-doc_1.21.0-1%2Bcore2.1.20261016133904_all.deb)
- [libwayland-egl-backend-dev_1.21.0-1+core2.1.20261016133904_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wayland-1.21.0-1-core2.1-20261016133904/libwayland-egl-backend-dev_1.21.0-1%2Bcore2.1.20261016133904_amd64.deb)
- [libwayland-egl1_1.21.0-1+core2.1.20261016133904_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wayland-1.21.0-1-core2.1-20261016133904/libwayland-egl1_1.21.0-1%2Bcore2.1.20261016133904_amd64.deb)
- [libwayland-server0_1.21.0-1+core2.1.20261016133904_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wayland-1.21.0-1-core2.1-20261016133904/libwayland-server0_1.21.0-1%2Bcore2.1.20261016133904_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-wayland-1.21.0-1-core2.1-20261016133904)

### libxvmc (optimized)
Version: `2:1.0.12-2+core2.1~20261016133703` · Published: 2026-10-16 13:37:56 UTC
**Description:** X11 Video extension library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxvmc`

**Binary downloads:**
- [libxvmc-dev_1.0.12-2+core2.1.20261016133703_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxvmc-2-1.0.12-2-core2.1-20261016133703/libxvmc-dev_1.0.12-2%2Bcore2.1.20261016133703_amd64.deb)
- [libxvmc1_1.0.12-2+core2.1.20261016133703_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxvmc-2-1.0.12-2-core2.1-20261016133703/libxvmc1_1.0.12-2%2Bcore2.1.20261016133703_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxvmc-2-1.0.12-2-core2.1-20261016133703)

### libxv (optimized)
Version: `2:1.0.11-1.1+core2.1~20261016133515` · Published: 2026-10-16 13:36:06 UTC
**Description:** X11 Video extension library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxv`

**Binary downloads:**
- [libxv-dev_1.0.11-1.1+core2.1.20261016133515_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxv-2-1.0.11-1.1-core2.1-20261016133515/libxv-dev_1.0.11-1.1%2Bcore2.1.20261016133515_amd64.deb)
- [libxv1_1.0.11-1.1+core2.1.20261016133515_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxv-2-1.0.11-1.1-core2.1-20261016133515/libxv1_1.0.11-1.1%2Bcore2.1.20261016133515_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxv-2-1.0.11-1.1-core2.1-20261016133515)

### libxdamage (optimized)
Version: `1:1.1.6-1+core2.1~20261016133326` · Published: 2026-10-16 13:34:17 UTC
**Description:** X11 damaged region extension library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxdamage`

**Binary downloads:**
- [libxdamage-dev_1.1.6-1+core2.1.20261016133326_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxdamage-1-1.1.6-1-core2.1-20261016133326/libxdamage-dev_1.1.6-1%2Bcore2.1.20261016133326_amd64.deb)
- [libxdamage1_1.1.6-1+core2.1.20261016133326_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxdamage-1-1.1.6-1-core2.1-20261016133326/libxdamage1_1.1.6-1%2Bcore2.1.20261016133326_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxdamage-1-1.1.6-1-core2.1-20261016133326)

### libxcomposite (optimized)
Version: `1:0.4.5-1+core2.1~20261016133125` · Published: 2026-10-16 13:32:25 UTC
**Description:** X11 Composite extension library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxcomposite`

**Binary downloads:**
- [libxcomposite-dev_0.4.5-1+core2.1.20261016133125_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcomposite-1-0.4.5-1-core2.1-20261016133125/libxcomposite-dev_0.4.5-1%2Bcore2.1.20261016133125_amd64.deb)
- [libxcomposite1_0.4.5-1+core2.1.20261016133125_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxcomposite-1-0.4.5-1-core2.1-20261016133125/libxcomposite1_0.4.5-1%2Bcore2.1.20261016133125_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxcomposite-1-0.4.5-1-core2.1-20261016133125)

### libxrandr (optimized)
Version: `2:1.5.2-2+core2.1~20261016132856` · Published: 2026-10-16 13:29:53 UTC
**Description:** X11 RandR extension library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxrandr`

**Binary downloads:**
- [libxrandr-dev_1.5.2-2+core2.1.20261016132856_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxrandr-2-1.5.2-2-core2.1-20261016132856/libxrandr-dev_1.5.2-2%2Bcore2.1.20261016132856_amd64.deb)
- [libxrandr2_1.5.2-2+core2.1.20261016132856_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxrandr-2-1.5.2-2-core2.1-20261016132856/libxrandr2_1.5.2-2%2Bcore2.1.20261016132856_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxrandr-2-1.5.2-2-core2.1-20261016132856)

### libxext (optimized)
Version: `2:1.3.4-1+core2.1~20261016132313` · Published: 2026-10-16 13:27:50 UTC
**Description:** X11 miscellaneous extension library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxext`

**Binary downloads:**
- [libxext-dev_1.3.4-1+core2.1.20261016132313_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxext-2-1.3.4-1-core2.1-20261016132313/libxext-dev_1.3.4-1%2Bcore2.1.20261016132313_amd64.deb)
- [libxext-doc_1.3.4-1+core2.1.20261016132313_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxext-2-1.3.4-1-core2.1-20261016132313/libxext-doc_1.3.4-1%2Bcore2.1.20261016132313_all.deb)
- [libxext6_1.3.4-1+core2.1.20261016132313_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxext-2-1.3.4-1-core2.1-20261016132313/libxext6_1.3.4-1%2Bcore2.1.20261016132313_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxext-2-1.3.4-1-core2.1-20261016132313)

### libx11 (optimized)
Version: `2:1.8.4-2+deb12u2+core2.1~20261016131846` · Published: 2026-10-16 13:22:18 UTC
**Description:** Xlib/XCB interface library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libx11`

**Binary downloads:**
- [libx11-6_1.8.4-2+deb12u2+core2.1.20261016131846_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libx11-2-1.8.4-2-deb12u2-core2.1-20261016131846/libx11-6_1.8.4-2%2Bdeb12u2%2Bcore2.1.20261016131846_amd64.deb)
- [libx11-data_1.8.4-2+deb12u2+core2.1.20261016131846_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libx11-2-1.8.4-2-deb12u2-core2.1-20261016131846/libx11-data_1.8.4-2%2Bdeb12u2%2Bcore2.1.20261016131846_all.deb)
- [libx11-dev_1.8.4-2+deb12u2+core2.1.20261016131846_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libx11-2-1.8.4-2-deb12u2-core2.1-20261016131846/libx11-dev_1.8.4-2%2Bdeb12u2%2Bcore2.1.20261016131846_amd64.deb)
- [libx11-doc_1.8.4-2+deb12u2+core2.1.20261016131846_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libx11-2-1.8.4-2-deb12u2-core2.1-20261016131846/libx11-doc_1.8.4-2%2Bdeb12u2%2Bcore2.1.20261016131846_all.deb)
- [libx11-xcb-dev_1.8.4-2+deb12u2+core2.1.20261016131846_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libx11-2-1.8.4-2-deb12u2-core2.1-20261016131846/libx11-xcb-dev_1.8.4-2%2Bdeb12u2%2Bcore2.1.20261016131846_amd64.deb)
- [libx11-xcb1_1.8.4-2+deb12u2+core2.1.20261016131846_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libx11-2-1.8.4-2-deb12u2-core2.1-20261016131846/libx11-xcb1_1.8.4-2%2Bdeb12u2%2Bcore2.1.20261016131846_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libx11-2-1.8.4-2-deb12u2-core2.1-20261016131846)

### gst-plugins-good1.0 (optimized)
Version: `1.22.0-5+deb12u4+core2.1~20261016120601` · Published: 2026-10-16 12:10:23 UTC
**Description:** GStreamer plugin for PulseAudio (transitional package)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gst-plugins-good1.0`

**Binary downloads:**
- [gstreamer1.0-gtk3_1.22.0-5+deb12u4+core2.1.20261016120601_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-good1.0-1.22.0-5-deb12u4-core2.1-20261016120601/gstreamer1.0-gtk3_1.22.0-5%2Bdeb12u4%2Bcore2.1.20261016120601_amd64.deb)
- [gstreamer1.0-plugins-good_1.22.0-5+deb12u4+core2.1.20261016120601_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-good1.0-1.22.0-5-deb12u4-core2.1-20261016120601/gstreamer1.0-plugins-good_1.22.0-5%2Bdeb12u4%2Bcore2.1.20261016120601_amd64.deb)
- [gstreamer1.0-pulseaudio_1.22.0-5+deb12u4+core2.1.20261016120601_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-good1.0-1.22.0-5-deb12u4-core2.1-20261016120601/gstreamer1.0-pulseaudio_1.22.0-5%2Bdeb12u4%2Bcore2.1.20261016120601_amd64.deb)
- [gstreamer1.0-qt5_1.22.0-5+deb12u4+core2.1.20261016120601_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-good1.0-1.22.0-5-deb12u4-core2.1-20261016120601/gstreamer1.0-qt5_1.22.0-5%2Bdeb12u4%2Bcore2.1.20261016120601_amd64.deb)
- [gstreamer1.0-qt6_1.22.0-5+deb12u4+core2.1.20261016120601_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-good1.0-1.22.0-5-deb12u4-core2.1-20261016120601/gstreamer1.0-qt6_1.22.0-5%2Bdeb12u4%2Bcore2.1.20261016120601_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-good1.0-1.22.0-5-deb12u4-core2.1-20261016120601)

### gst-plugins-base1.0 (optimized)
Version: `1.22.0-3+deb12u7+core2.1~20261016120019` · Published: 2026-10-16 12:03:58 UTC
**Description:** GStreamer helper programs from the "base" set
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gst-plugins-base1.0`

**Binary downloads:**
- [gir1.2-gst-plugins-base-1.0_1.22.0-3+deb12u7+core2.1.20261016120019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019/gir1.2-gst-plugins-base-1.0_1.22.0-3%2Bdeb12u7%2Bcore2.1.20261016120019_amd64.deb)
- [gstreamer1.0-alsa_1.22.0-3+deb12u7+core2.1.20261016120019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019/gstreamer1.0-alsa_1.22.0-3%2Bdeb12u7%2Bcore2.1.20261016120019_amd64.deb)
- [gstreamer1.0-gl_1.22.0-3+deb12u7+core2.1.20261016120019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019/gstreamer1.0-gl_1.22.0-3%2Bdeb12u7%2Bcore2.1.20261016120019_amd64.deb)
- [gstreamer1.0-plugins-base-apps_1.22.0-3+deb12u7+core2.1.20261016120019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019/gstreamer1.0-plugins-base-apps_1.22.0-3%2Bdeb12u7%2Bcore2.1.20261016120019_amd64.deb)
- [gstreamer1.0-plugins-base_1.22.0-3+deb12u7+core2.1.20261016120019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019/gstreamer1.0-plugins-base_1.22.0-3%2Bdeb12u7%2Bcore2.1.20261016120019_amd64.deb)
- [gstreamer1.0-x_1.22.0-3+deb12u7+core2.1.20261016120019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019/gstreamer1.0-x_1.22.0-3%2Bdeb12u7%2Bcore2.1.20261016120019_amd64.deb)
- [libgstreamer-gl1.0-0_1.22.0-3+deb12u7+core2.1.20261016120019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019/libgstreamer-gl1.0-0_1.22.0-3%2Bdeb12u7%2Bcore2.1.20261016120019_amd64.deb)
- [libgstreamer-plugins-base1.0-0_1.22.0-3+deb12u7+core2.1.20261016120019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019/libgstreamer-plugins-base1.0-0_1.22.0-3%2Bdeb12u7%2Bcore2.1.20261016120019_amd64.deb)
- [libgstreamer-plugins-base1.0-dev_1.22.0-3+deb12u7+core2.1.20261016120019_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019/libgstreamer-plugins-base1.0-dev_1.22.0-3%2Bdeb12u7%2Bcore2.1.20261016120019_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gst-plugins-base1.0-1.22.0-3-deb12u7-core2.1-20261016120019)

### libvpx (optimized)
Version: `1.12.0-1+deb12u5+core2.1~20261016115550` · Published: 2026-10-16 11:59:15 UTC
**Description:** VP8 and VP9 video codec encoding/decoding tools
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libvpx`

**Binary downloads:**
- [libvpx-dev_1.12.0-1+deb12u5+core2.1.20261016115550_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libvpx-1.12.0-1-deb12u5-core2.1-20261016115550/libvpx-dev_1.12.0-1%2Bdeb12u5%2Bcore2.1.20261016115550_amd64.deb)
- [libvpx-doc_1.12.0-1+deb12u5+core2.1.20261016115550_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libvpx-1.12.0-1-deb12u5-core2.1-20261016115550/libvpx-doc_1.12.0-1%2Bdeb12u5%2Bcore2.1.20261016115550_all.deb)
- [libvpx7_1.12.0-1+deb12u5+core2.1.20261016115550_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libvpx-1.12.0-1-deb12u5-core2.1-20261016115550/libvpx7_1.12.0-1%2Bdeb12u5%2Bcore2.1.20261016115550_amd64.deb)
- [vpx-tools_1.12.0-1+deb12u5+core2.1.20261016115550_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libvpx-1.12.0-1-deb12u5-core2.1-20261016115550/vpx-tools_1.12.0-1%2Bdeb12u5%2Bcore2.1.20261016115550_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libvpx-1.12.0-1-deb12u5-core2.1-20261016115550)

### libpciaccess (optimized)
Version: `0.17-2+core2.1~20261016115401` · Published: 2026-10-16 11:54:51 UTC
**Description:** Generic PCI access library for X
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libpciaccess`

**Binary downloads:**
- [libpciaccess-dev_0.17-2+core2.1.20261016115401_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libpciaccess-0.17-2-core2.1-20261016115401/libpciaccess-dev_0.17-2%2Bcore2.1.20261016115401_amd64.deb)
- [libpciaccess0_0.17-2+core2.1.20261016115401_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libpciaccess-0.17-2-core2.1-20261016115401/libpciaccess0_0.17-2%2Bcore2.1.20261016115401_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libpciaccess-0.17-2-core2.1-20261016115401)

### libdrm (optimized)
Version: `2.4.114-1+core2.1~20261016115216` · Published: 2026-10-16 11:53:16 UTC
**Description:** Userspace interface to kernel DRM services -- common files
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libdrm`

**Binary downloads:**
- [libdrm-amdgpu1_2.4.114-1+core2.1.20261016115216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdrm-2.4.114-1-core2.1-20261016115216/libdrm-amdgpu1_2.4.114-1%2Bcore2.1.20261016115216_amd64.deb)
- [libdrm-common_2.4.114-1+core2.1.20261016115216_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdrm-2.4.114-1-core2.1-20261016115216/libdrm-common_2.4.114-1%2Bcore2.1.20261016115216_all.deb)
- [libdrm-dev_2.4.114-1+core2.1.20261016115216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdrm-2.4.114-1-core2.1-20261016115216/libdrm-dev_2.4.114-1%2Bcore2.1.20261016115216_amd64.deb)
- [libdrm-intel1_2.4.114-1+core2.1.20261016115216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdrm-2.4.114-1-core2.1-20261016115216/libdrm-intel1_2.4.114-1%2Bcore2.1.20261016115216_amd64.deb)
- [libdrm-nouveau2_2.4.114-1+core2.1.20261016115216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdrm-2.4.114-1-core2.1-20261016115216/libdrm-nouveau2_2.4.114-1%2Bcore2.1.20261016115216_amd64.deb)
- [libdrm-radeon1_2.4.114-1+core2.1.20261016115216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdrm-2.4.114-1-core2.1-20261016115216/libdrm-radeon1_2.4.114-1%2Bcore2.1.20261016115216_amd64.deb)
- [libdrm-tests_2.4.114-1+core2.1.20261016115216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdrm-2.4.114-1-core2.1-20261016115216/libdrm-tests_2.4.114-1%2Bcore2.1.20261016115216_amd64.deb)
- [libdrm2_2.4.114-1+core2.1.20261016115216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libdrm-2.4.114-1-core2.1-20261016115216/libdrm2_2.4.114-1%2Bcore2.1.20261016115216_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libdrm-2.4.114-1-core2.1-20261016115216)

### xserver-xorg-video-intel (optimized)
Version: `2:2.99.917+git20210115-1+core2.1~20261016113213` · Published: 2026-10-16 11:33:52 UTC
**Description:** X.Org X server -- Intel i8xx, i9xx display driver
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xserver-xorg-video-intel`

**Binary downloads:**
- [xserver-xorg-video-intel_2.99.917+git20210115-1+core2.1.20261016113213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xserver-xorg-video-intel-2-2.99.917-git20210115-1-core2.1-20261016113213/xserver-xorg-video-intel_2.99.917%2Bgit20210115-1%2Bcore2.1.20261016113213_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xserver-xorg-video-intel-2-2.99.917-git20210115-1-core2.1-20261016113213)

### xserver-xorg-input-synaptics (optimized)
Version: `1.9.2-1+core2.1~20261016113016` · Published: 2026-10-16 11:31:11 UTC
**Description:** Synaptics TouchPad driver for X.Org server
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xserver-xorg-input-synaptics`

**Binary downloads:**
- [xserver-xorg-input-synaptics-dev_1.9.2-1+core2.1.20261016113016_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xserver-xorg-input-synaptics-1.9.2-1-core2.1-20261016113016/xserver-xorg-input-synaptics-dev_1.9.2-1%2Bcore2.1.20261016113016_all.deb)
- [xserver-xorg-input-synaptics_1.9.2-1+core2.1.20261016113016_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xserver-xorg-input-synaptics-1.9.2-1-core2.1-20261016113016/xserver-xorg-input-synaptics_1.9.2-1%2Bcore2.1.20261016113016_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xserver-xorg-input-synaptics-1.9.2-1-core2.1-20261016113016)

### xserver-xorg-input-libinput (optimized)
Version: `1.2.1-1+core2.1~20261016112819` · Published: 2026-10-16 11:29:15 UTC
**Description:** X.Org X server -- libinput input driver
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xserver-xorg-input-libinput`

**Binary downloads:**
- [xserver-xorg-input-libinput-dev_1.2.1-1+core2.1.20261016112819_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xserver-xorg-input-libinput-1.2.1-1-core2.1-20261016112819/xserver-xorg-input-libinput-dev_1.2.1-1%2Bcore2.1.20261016112819_all.deb)
- [xserver-xorg-input-libinput_1.2.1-1+core2.1.20261016112819_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xserver-xorg-input-libinput-1.2.1-1-core2.1-20261016112819/xserver-xorg-input-libinput_1.2.1-1%2Bcore2.1.20261016112819_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xserver-xorg-input-libinput-1.2.1-1-core2.1-20261016112819)

### xserver-xorg-input-keyboard (optimized)
Version: `1:1.9.0-1+core2.1~20261016112635` · Published: 2026-10-16 11:27:25 UTC
**Description:** X.Org X server -- keyboard input driver
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xserver-xorg-input-keyboard`

**Binary downloads:**
- [xserver-xorg-input-kbd_1.9.0-1+core2.1.20261016112635_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xserver-xorg-input-keyboard-1-1.9.0-1-core2.1-20261016112635/xserver-xorg-input-kbd_1.9.0-1%2Bcore2.1.20261016112635_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xserver-xorg-input-keyboard-1-1.9.0-1-core2.1-20261016112635)

### less (optimized)
Version: `590-2.1~deb12u2+core2.1~20261012093417` · Published: 2026-10-12 09:35:12 UTC
**Description:** pager program similar to more
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - less`

**Binary downloads:**
- [less_590-2.1.deb12u2+core2.1.20261012093417_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-less-590-2.1-deb12u2-core2.1-20261012093417/less_590-2.1.deb12u2%2Bcore2.1.20261012093417_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-less-590-2.1-deb12u2-core2.1-20261012093417)

### busybox (optimized)
Version: `1:1.35.0-4+deb12u1+core2.1~20261012093022` · Published: 2026-10-12 09:33:49 UTC
**Description:** Tiny utilities for small and embedded systems
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - busybox`

**Binary downloads:**
- [busybox-static_1.35.0-4+deb12u1+core2.1.20261012093022_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-busybox-1-1.35.0-4-deb12u1-core2.1-20261012093022/busybox-static_1.35.0-4%2Bdeb12u1%2Bcore2.1.20261012093022_amd64.deb)
- [busybox-syslogd_1.35.0-4+deb12u1+core2.1.20261012093022_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-busybox-1-1.35.0-4-deb12u1-core2.1-20261012093022/busybox-syslogd_1.35.0-4%2Bdeb12u1%2Bcore2.1.20261012093022_all.deb)
- [busybox_1.35.0-4+deb12u1+core2.1.20261012093022_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-busybox-1-1.35.0-4-deb12u1-core2.1-20261012093022/busybox_1.35.0-4%2Bdeb12u1%2Bcore2.1.20261012093022_amd64.deb)
- [udhcpc_1.35.0-4+deb12u1+core2.1.20261012093022_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-busybox-1-1.35.0-4-deb12u1-core2.1-20261012093022/udhcpc_1.35.0-4%2Bdeb12u1%2Bcore2.1.20261012093022_amd64.deb)
- [udhcpd_1.35.0-4+deb12u1+core2.1.20261012093022_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-busybox-1-1.35.0-4-deb12u1-core2.1-20261012093022/udhcpd_1.35.0-4%2Bdeb12u1%2Bcore2.1.20261012093022_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-busybox-1-1.35.0-4-deb12u1-core2.1-20261012093022)

### libunistring (optimized)
Version: `1.0-2+core2.1~20261012093008` · Published: 2026-10-12 09:32:34 UTC
**Description:** Unicode string library for C
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libunistring`

**Binary downloads:**
- [libunistring-dev_1.0-2+core2.1.20261012093008_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libunistring-1.0-2-core2.1-20261012093008/libunistring-dev_1.0-2%2Bcore2.1.20261012093008_amd64.deb)
- [libunistring2_1.0-2+core2.1.20261012093008_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libunistring-1.0-2-core2.1-20261012093008/libunistring2_1.0-2%2Bcore2.1.20261012093008_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libunistring-1.0-2-core2.1-20261012093008)

### libidn2 (optimized)
Version: `2.3.3-1+core2.1~20261012093052` · Published: 2026-10-12 09:32:02 UTC
**Description:** Internationalized domain names (IDNA2008/TR46) command line tool
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libidn2`

**Binary downloads:**
- [idn2_2.3.3-1+core2.1.20261012093052_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libidn2-2.3.3-1-core2.1-20261012093052/idn2_2.3.3-1%2Bcore2.1.20261012093052_amd64.deb)
- [libidn2-0_2.3.3-1+core2.1.20261012093052_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libidn2-2.3.3-1-core2.1-20261012093052/libidn2-0_2.3.3-1%2Bcore2.1.20261012093052_amd64.deb)
- [libidn2-dev_2.3.3-1+core2.1.20261012093052_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libidn2-2.3.3-1-core2.1-20261012093052/libidn2-dev_2.3.3-1%2Bcore2.1.20261012093052_amd64.deb)
- [libidn2-doc_2.3.3-1+core2.1.20261012093052_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libidn2-2.3.3-1-core2.1-20261012093052/libidn2-doc_2.3.3-1%2Bcore2.1.20261012093052_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libidn2-2.3.3-1-core2.1-20261012093052)

### glib2.0 (optimized)
Version: `2.74.6-2+deb12u9+core2.1~20261012055158` · Published: 2026-10-12 06:07:36 UTC
**Description:** Programs for the GLib library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - glib2.0`

**Binary downloads:**
- [libglib2.0-0_2.74.6-2+deb12u9+core2.1.20261012055158_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158/libglib2.0-0_2.74.6-2%2Bdeb12u9%2Bcore2.1.20261012055158_amd64.deb)
- [libglib2.0-bin_2.74.6-2+deb12u9+core2.1.20261012055158_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158/libglib2.0-bin_2.74.6-2%2Bdeb12u9%2Bcore2.1.20261012055158_amd64.deb)
- [libglib2.0-data_2.74.6-2+deb12u9+core2.1.20261012055158_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158/libglib2.0-data_2.74.6-2%2Bdeb12u9%2Bcore2.1.20261012055158_all.deb)
- [libglib2.0-dev-bin_2.74.6-2+deb12u9+core2.1.20261012055158_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158/libglib2.0-dev-bin_2.74.6-2%2Bdeb12u9%2Bcore2.1.20261012055158_amd64.deb)
- [libglib2.0-dev_2.74.6-2+deb12u9+core2.1.20261012055158_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158/libglib2.0-dev_2.74.6-2%2Bdeb12u9%2Bcore2.1.20261012055158_amd64.deb)
- [libglib2.0-doc_2.74.6-2+deb12u9+core2.1.20261012055158_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158/libglib2.0-doc_2.74.6-2%2Bdeb12u9%2Bcore2.1.20261012055158_all.deb)
- [libglib2.0-tests_2.74.6-2+deb12u9+core2.1.20261012055158_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158/libglib2.0-tests_2.74.6-2%2Bdeb12u9%2Bcore2.1.20261012055158_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-glib2.0-2.74.6-2-deb12u9-core2.1-20261012055158)

### texlive-bin (optimized)
Version: `2022.20220321.62855-5.1+deb12u2+core2.1~20261012055216` · Published: 2026-10-12 06:04:36 UTC
**Description:** transitional package (lib)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - texlive-bin`

**Binary downloads:**
- [libkpathsea-dev_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libkpathsea-dev_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_amd64.deb)
- [libkpathsea6_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libkpathsea6_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_amd64.deb)
- [libptexenc-dev_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libptexenc-dev_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_amd64.deb)
- [libptexenc1_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libptexenc1_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_amd64.deb)
- [libsynctex-dev_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libsynctex-dev_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_amd64.deb)
- [libsynctex2_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libsynctex2_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_amd64.deb)
- [libtexlua-dev_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libtexlua-dev_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_amd64.deb)
- [libtexlua53-5_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libtexlua53-5_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_amd64.deb)
- [libtexlua53-dev_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libtexlua53-dev_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_all.deb)
- [libtexlua53_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libtexlua53_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_all.deb)
- [libtexluajit-dev_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libtexluajit-dev_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_amd64.deb)
- [libtexluajit2_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/libtexluajit2_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_amd64.deb)
- [texlive-binaries_2022.20220321.62855-5.1+deb12u2+core2.1.20261012055216_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216/texlive-binaries_2022.20220321.62855-5.1%2Bdeb12u2%2Bcore2.1.20261012055216_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-texlive-bin-2022.20220321.62855-5.1-deb12u2-core2.1-20261012055216)

### poppler (optimized)
Version: `22.12.0-2+deb12u3+core2.1~20261012055344` · Published: 2026-10-12 05:59:35 UTC
**Description:** GObject introspection data for poppler-glib
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - poppler`

**Binary downloads:**
- [gir1.2-poppler-0.18_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/gir1.2-poppler-0.18_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [libpoppler-cpp-dev_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler-cpp-dev_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [libpoppler-cpp0v5_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler-cpp0v5_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [libpoppler-dev_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler-dev_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [libpoppler-glib-dev_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler-glib-dev_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [libpoppler-glib-doc_22.12.0-2+deb12u3+core2.1.20261012055344_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler-glib-doc_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_all.deb)
- [libpoppler-glib8_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler-glib8_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [libpoppler-private-dev_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler-private-dev_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [libpoppler-qt5-1_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler-qt5-1_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [libpoppler-qt5-dev_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler-qt5-dev_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [libpoppler-qt6-3_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler-qt6-3_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [libpoppler-qt6-dev_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler-qt6-dev_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [libpoppler126_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/libpoppler126_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
- [poppler-utils_22.12.0-2+deb12u3+core2.1.20261012055344_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344/poppler-utils_22.12.0-2%2Bdeb12u3%2Bcore2.1.20261012055344_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-poppler-22.12.0-2-deb12u3-core2.1-20261012055344)

### atril (optimized)
Version: `1.26.0-2+deb12u4+core2.1~20261012055510` · Published: 2026-10-12 05:58:44 UTC
**Description:** MATE document viewer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - atril`

**Binary downloads:**
- [atril-common_1.26.0-2+deb12u4+core2.1.20261012055510_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510/atril-common_1.26.0-2%2Bdeb12u4%2Bcore2.1.20261012055510_all.deb)
- [atril_1.26.0-2+deb12u4+core2.1.20261012055510_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510/atril_1.26.0-2%2Bdeb12u4%2Bcore2.1.20261012055510_amd64.deb)
- [gir1.2-atrildocument-1.5.0_1.26.0-2+deb12u4+core2.1.20261012055510_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510/gir1.2-atrildocument-1.5.0_1.26.0-2%2Bdeb12u4%2Bcore2.1.20261012055510_amd64.deb)
- [gir1.2-atrilview-1.5.0_1.26.0-2+deb12u4+core2.1.20261012055510_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510/gir1.2-atrilview-1.5.0_1.26.0-2%2Bdeb12u4%2Bcore2.1.20261012055510_amd64.deb)
- [libatrildocument-dev_1.26.0-2+deb12u4+core2.1.20261012055510_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510/libatrildocument-dev_1.26.0-2%2Bdeb12u4%2Bcore2.1.20261012055510_amd64.deb)
- [libatrildocument3_1.26.0-2+deb12u4+core2.1.20261012055510_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510/libatrildocument3_1.26.0-2%2Bdeb12u4%2Bcore2.1.20261012055510_amd64.deb)
- [libatrilview-dev_1.26.0-2+deb12u4+core2.1.20261012055510_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510/libatrilview-dev_1.26.0-2%2Bdeb12u4%2Bcore2.1.20261012055510_amd64.deb)
- [libatrilview3_1.26.0-2+deb12u4+core2.1.20261012055510_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510/libatrilview3_1.26.0-2%2Bdeb12u4%2Bcore2.1.20261012055510_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-atril-1.26.0-2-deb12u4-core2.1-20261012055510)

### okular (optimized)
Version: `4:22.12.3-1+deb12u1+core2.1~20261012055453` · Published: 2026-10-12 05:58:38 UTC
**Description:** universal document viewer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - okular`

**Binary downloads:**
- [libokular5core10_22.12.3-1+deb12u1+core2.1.20261012055453_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453/libokular5core10_22.12.3-1%2Bdeb12u1%2Bcore2.1.20261012055453_amd64.deb)
- [okular-dev_22.12.3-1+deb12u1+core2.1.20261012055453_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453/okular-dev_22.12.3-1%2Bdeb12u1%2Bcore2.1.20261012055453_amd64.deb)
- [okular-extra-backends_22.12.3-1+deb12u1+core2.1.20261012055453_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453/okular-extra-backends_22.12.3-1%2Bdeb12u1%2Bcore2.1.20261012055453_amd64.deb)
- [okular-mobile_22.12.3-1+deb12u1+core2.1.20261012055453_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453/okular-mobile_22.12.3-1%2Bdeb12u1%2Bcore2.1.20261012055453_amd64.deb)
- [okular_22.12.3-1+deb12u1+core2.1.20261012055453_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453/okular_22.12.3-1%2Bdeb12u1%2Bcore2.1.20261012055453_amd64.deb)
- [qml-module-org-kde-okular_22.12.3-1+deb12u1+core2.1.20261012055453_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453/qml-module-org-kde-okular_22.12.3-1%2Bdeb12u1%2Bcore2.1.20261012055453_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-okular-4-22.12.3-1-deb12u1-core2.1-20261012055453)

### mupdf (optimized)
Version: `1.21.1+ds2-1+deb12u1+core2.1~20261012055501` · Published: 2026-10-12 05:57:27 UTC
**Description:** lightweight PDF viewer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - mupdf`

**Binary downloads:**
- [libmupdf-dev_1.21.1+ds2-1+deb12u1+core2.1.20261012055501_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mupdf-1.21.1-ds2-1-deb12u1-core2.1-20261012055501/libmupdf-dev_1.21.1%2Bds2-1%2Bdeb12u1%2Bcore2.1.20261012055501_amd64.deb)
- [mupdf-tools_1.21.1+ds2-1+deb12u1+core2.1.20261012055501_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mupdf-1.21.1-ds2-1-deb12u1-core2.1-20261012055501/mupdf-tools_1.21.1%2Bds2-1%2Bdeb12u1%2Bcore2.1.20261012055501_amd64.deb)
- [mupdf_1.21.1+ds2-1+deb12u1+core2.1.20261012055501_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mupdf-1.21.1-ds2-1-deb12u1-core2.1-20261012055501/mupdf_1.21.1%2Bds2-1%2Bdeb12u1%2Bcore2.1.20261012055501_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-mupdf-1.21.1-ds2-1-deb12u1-core2.1-20261012055501)

### wimlib (optimized)
Version: `1.13.6-1+core2.1~20261012055555` · Published: 2026-10-12 05:57:15 UTC
**Description:** Tools for manipulating Windows Imaging files
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - wimlib`

**Binary downloads:**
- [libwim-dev_1.13.6-1+core2.1.20261012055555_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wimlib-1.13.6-1-core2.1-20261012055555/libwim-dev_1.13.6-1%2Bcore2.1.20261012055555_amd64.deb)
- [libwim-doc_1.13.6-1+core2.1.20261012055555_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wimlib-1.13.6-1-core2.1-20261012055555/libwim-doc_1.13.6-1%2Bcore2.1.20261012055555_all.deb)
- [libwim15_1.13.6-1+core2.1.20261012055555_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wimlib-1.13.6-1-core2.1-20261012055555/libwim15_1.13.6-1%2Bcore2.1.20261012055555_amd64.deb)
- [wimtools_1.13.6-1+core2.1.20261012055555_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-wimlib-1.13.6-1-core2.1-20261012055555/wimtools_1.13.6-1%2Bcore2.1.20261012055555_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-wimlib-1.13.6-1-core2.1-20261012055555)

### evince (optimized)
Version: `43.1-2+deb12u1+core2.1~20261012055507` · Published: 2026-10-12 05:56:52 UTC
**Description:** Document (PostScript, PDF) viewer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - evince`

**Binary downloads:**
- [evince-common_43.1-2+deb12u1+core2.1.20261012055507_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-evince-43.1-2-deb12u1-core2.1-20261012055507/evince-common_43.1-2%2Bdeb12u1%2Bcore2.1.20261012055507_all.deb)
- [evince_43.1-2+deb12u1+core2.1.20261012055507_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-evince-43.1-2-deb12u1-core2.1-20261012055507/evince_43.1-2%2Bdeb12u1%2Bcore2.1.20261012055507_amd64.deb)
- [gir1.2-evince-3.0_43.1-2+deb12u1+core2.1.20261012055507_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-evince-43.1-2-deb12u1-core2.1-20261012055507/gir1.2-evince-3.0_43.1-2%2Bdeb12u1%2Bcore2.1.20261012055507_amd64.deb)
- [libevdocument3-4_43.1-2+deb12u1+core2.1.20261012055507_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-evince-43.1-2-deb12u1-core2.1-20261012055507/libevdocument3-4_43.1-2%2Bdeb12u1%2Bcore2.1.20261012055507_amd64.deb)
- [libevince-dev_43.1-2+deb12u1+core2.1.20261012055507_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-evince-43.1-2-deb12u1-core2.1-20261012055507/libevince-dev_43.1-2%2Bdeb12u1%2Bcore2.1.20261012055507_amd64.deb)
- [libevview3-3_43.1-2+deb12u1+core2.1.20261012055507_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-evince-43.1-2-deb12u1-core2.1-20261012055507/libevview3-3_43.1-2%2Bdeb12u1%2Bcore2.1.20261012055507_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-evince-43.1-2-deb12u1-core2.1-20261012055507)

### qpdfview (optimized)
Version: `0.5.0+ds-2+core2.1~20261012055504` · Published: 2026-10-12 05:56:50 UTC
**Description:** tabbed document viewer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - qpdfview`

**Binary downloads:**
- [qpdfview-djvu-plugin_0.5.0+ds-2+core2.1.20261012055504_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-qpdfview-0.5.0-ds-2-core2.1-20261012055504/qpdfview-djvu-plugin_0.5.0%2Bds-2%2Bcore2.1.20261012055504_amd64.deb)
- [qpdfview-pdf-poppler-plugin_0.5.0+ds-2+core2.1.20261012055504_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-qpdfview-0.5.0-ds-2-core2.1-20261012055504/qpdfview-pdf-poppler-plugin_0.5.0%2Bds-2%2Bcore2.1.20261012055504_amd64.deb)
- [qpdfview-ps-plugin_0.5.0+ds-2+core2.1.20261012055504_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-qpdfview-0.5.0-ds-2-core2.1-20261012055504/qpdfview-ps-plugin_0.5.0%2Bds-2%2Bcore2.1.20261012055504_amd64.deb)
- [qpdfview-translations_0.5.0+ds-2+core2.1.20261012055504_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-qpdfview-0.5.0-ds-2-core2.1-20261012055504/qpdfview-translations_0.5.0%2Bds-2%2Bcore2.1.20261012055504_all.deb)
- [qpdfview_0.5.0+ds-2+core2.1.20261012055504_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-qpdfview-0.5.0-ds-2-core2.1-20261012055504/qpdfview_0.5.0%2Bds-2%2Bcore2.1.20261012055504_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-qpdfview-0.5.0-ds-2-core2.1-20261012055504)

### apvlv (optimized)
Version: `0.4.0+repack-1+core2.1~20261012055524` · Published: 2026-10-12 05:56:17 UTC
**Description:** PDF viewer with Vim-like behaviour
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - apvlv`

**Binary downloads:**
- [apvlv_0.4.0+repack-1+core2.1.20261012055524_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-apvlv-0.4.0-repack-1-core2.1-20261012055524/apvlv_0.4.0%2Brepack-1%2Bcore2.1.20261012055524_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-apvlv-0.4.0-repack-1-core2.1-20261012055524)

### unar (optimized)
Version: `1.10.7+ds1+really1.10.1-2+core2.1~20261012055403` · Published: 2026-10-12 05:55:51 UTC
**Description:** Unarchiver for a variety of file formats
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - unar`

**Binary downloads:**
- [unar_1.10.7+ds1+really1.10.1-2+core2.1.20261012055403_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-unar-1.10.7-ds1-really1.10.1-2-core2.1-20261012055403/unar_1.10.7%2Bds1%2Breally1.10.1-2%2Bcore2.1.20261012055403_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-unar-1.10.7-ds1-really1.10.1-2-core2.1-20261012055403)

### zathura-pdf-poppler (optimized)
Version: `0.3.1-1+core2.1~20261012055457` · Published: 2026-10-12 05:55:48 UTC
**Description:** PDF support for zathura
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - zathura-pdf-poppler`

**Binary downloads:**
- [zathura-pdf-poppler_0.3.1-1+core2.1.20261012055457_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zathura-pdf-poppler-0.3.1-1-core2.1-20261012055457/zathura-pdf-poppler_0.3.1-1%2Bcore2.1.20261012055457_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-zathura-pdf-poppler-0.3.1-1-core2.1-20261012055457)

### xpdf (optimized)
Version: `3.04+git20220601-1+core2.1~20261012055410` · Published: 2026-10-12 05:55:34 UTC
**Description:** Motif-based PDF reader using the Poppler library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xpdf`

**Binary downloads:**
- [xpdf_3.04+git20220601-1+core2.1.20261012055410_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xpdf-3.04-git20220601-1-core2.1-20261012055410/xpdf_3.04%2Bgit20220601-1%2Bcore2.1.20261012055410_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xpdf-3.04-git20220601-1-core2.1-20261012055410)

### links2 (optimized)
Version: `2.28-1+core2.1~20261012055305` · Published: 2026-10-12 05:55:31 UTC
**Description:** Web browser running in both graphics and text mode
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - links2`

**Binary downloads:**
- [links2_2.28-1+core2.1.20261012055305_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-links2-2.28-1-core2.1-20261012055305/links2_2.28-1%2Bcore2.1.20261012055305_amd64.deb)
- [links_2.28-1+core2.1.20261012055305_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-links2-2.28-1-core2.1-20261012055305/links_2.28-1%2Bcore2.1.20261012055305_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-links2-2.28-1-core2.1-20261012055305)

### python-boto (optimized)
Version: `2.49.0-4.1+core2.1~20261012055353` · Published: 2026-10-12 05:55:27 UTC
**Description:** Python interface to Amazon's Web Services - Python 3.x
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - python-boto`

**Binary downloads:**
- [python3-boto_2.49.0-4.1+core2.1.20261012055353_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python-boto-2.49.0-4.1-core2.1-20261012055353/python3-boto_2.49.0-4.1%2Bcore2.1.20261012055353_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-python-boto-2.49.0-4.1-core2.1-20261012055353)

### djvulibre (optimized)
Version: `3.5.28-2.2~deb12u1+core2.1~20261012055223` · Published: 2026-10-12 05:55:20 UTC
**Description:** Transition package, djview3 to djview4
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - djvulibre`

**Binary downloads:**
- [djview3_3.5.28-2.2.deb12u1+core2.1.20261012055223_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223/djview3_3.5.28-2.2.deb12u1%2Bcore2.1.20261012055223_all.deb)
- [djview_3.5.28-2.2.deb12u1+core2.1.20261012055223_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223/djview_3.5.28-2.2.deb12u1%2Bcore2.1.20261012055223_all.deb)
- [djvulibre-bin_3.5.28-2.2.deb12u1+core2.1.20261012055223_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223/djvulibre-bin_3.5.28-2.2.deb12u1%2Bcore2.1.20261012055223_amd64.deb)
- [djvulibre-desktop_3.5.28-2.2.deb12u1+core2.1.20261012055223_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223/djvulibre-desktop_3.5.28-2.2.deb12u1%2Bcore2.1.20261012055223_all.deb)
- [djvuserve_3.5.28-2.2.deb12u1+core2.1.20261012055223_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223/djvuserve_3.5.28-2.2.deb12u1%2Bcore2.1.20261012055223_amd64.deb)
- [libdjvulibre-dev_3.5.28-2.2.deb12u1+core2.1.20261012055223_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223/libdjvulibre-dev_3.5.28-2.2.deb12u1%2Bcore2.1.20261012055223_amd64.deb)
- [libdjvulibre-text_3.5.28-2.2.deb12u1+core2.1.20261012055223_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223/libdjvulibre-text_3.5.28-2.2.deb12u1%2Bcore2.1.20261012055223_all.deb)
- [libdjvulibre21_3.5.28-2.2.deb12u1+core2.1.20261012055223_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223/libdjvulibre21_3.5.28-2.2.deb12u1%2Bcore2.1.20261012055223_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-djvulibre-3.5.28-2.2-deb12u1-core2.1-20261012055223)

### w3m (optimized)
Version: `0.5.3+git20230121-2+core2.1~20261012055311` · Published: 2026-10-12 05:55:17 UTC
**Description:** WWW browsable pager with excellent tables/frames support
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - w3m`

**Binary downloads:**
- [w3m-img_0.5.3+git20230121-2+core2.1.20261012055311_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-w3m-0.5.3-git20230121-2-core2.1-20261012055311/w3m-img_0.5.3%2Bgit20230121-2%2Bcore2.1.20261012055311_amd64.deb)
- [w3m_0.5.3+git20230121-2+core2.1.20261012055311_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-w3m-0.5.3-git20230121-2-core2.1-20261012055311/w3m_0.5.3%2Bgit20230121-2%2Bcore2.1.20261012055311_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-w3m-0.5.3-git20230121-2-core2.1-20261012055311)

### aspell (optimized)
Version: `0.60.8-4+core2.1~20261012055250` · Published: 2026-10-12 05:55:13 UTC
**Description:** GNU Aspell spell-checker
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - aspell`

**Binary downloads:**
- [aspell-doc_0.60.8-4+core2.1.20261012055250_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-aspell-0.60.8-4-core2.1-20261012055250/aspell-doc_0.60.8-4%2Bcore2.1.20261012055250_all.deb)
- [aspell_0.60.8-4+core2.1.20261012055250_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-aspell-0.60.8-4-core2.1-20261012055250/aspell_0.60.8-4%2Bcore2.1.20261012055250_amd64.deb)
- [libaspell-dev_0.60.8-4+core2.1.20261012055250_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-aspell-0.60.8-4-core2.1-20261012055250/libaspell-dev_0.60.8-4%2Bcore2.1.20261012055250_amd64.deb)
- [libaspell15_0.60.8-4+core2.1.20261012055250_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-aspell-0.60.8-4-core2.1-20261012055250/libaspell15_0.60.8-4%2Bcore2.1.20261012055250_amd64.deb)
- [libpspell-dev_0.60.8-4+core2.1.20261012055250_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-aspell-0.60.8-4-core2.1-20261012055250/libpspell-dev_0.60.8-4%2Bcore2.1.20261012055250_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-aspell-0.60.8-4-core2.1-20261012055250)

### python-tz (optimized)
Version: `2022.7.1-4+core2.1~20261012055311` · Published: 2026-10-12 05:55:02 UTC
**Description:** Python3 version of the Olson timezone database
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - python-tz`

**Binary downloads:**
- [python3-tz_2022.7.1-4+core2.1.20261012055311_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python-tz-2022.7.1-4-core2.1-20261012055311/python3-tz_2022.7.1-4%2Bcore2.1.20261012055311_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-python-tz-2022.7.1-4-core2.1-20261012055311)

### cdrkit (optimized)
Version: `9:1.1.11-3.4+core2.1~20261012055245` · Published: 2026-10-12 05:55:01 UTC
**Description:** Creates WAV files from audio CDs
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - cdrkit`

**Binary downloads:**
- [cdrkit-doc_1.1.11-3.4+core2.1.20261012055245_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cdrkit-9-1.1.11-3.4-core2.1-20261012055245/cdrkit-doc_1.1.11-3.4%2Bcore2.1.20261012055245_all.deb)
- [genisoimage_1.1.11-3.4+core2.1.20261012055245_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cdrkit-9-1.1.11-3.4-core2.1-20261012055245/genisoimage_1.1.11-3.4%2Bcore2.1.20261012055245_amd64.deb)
- [icedax_1.1.11-3.4+core2.1.20261012055245_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cdrkit-9-1.1.11-3.4-core2.1-20261012055245/icedax_1.1.11-3.4%2Bcore2.1.20261012055245_amd64.deb)
- [wodim_1.1.11-3.4+core2.1.20261012055245_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-cdrkit-9-1.1.11-3.4-core2.1-20261012055245/wodim_1.1.11-3.4%2Bcore2.1.20261012055245_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-cdrkit-9-1.1.11-3.4-core2.1-20261012055245)

### lynx (optimized)
Version: `2.9.0dev.12-1+core2.1~20261012055253` · Published: 2026-10-12 05:54:59 UTC
**Description:** classic non-graphical (text-mode) web browser
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - lynx`

**Binary downloads:**
- [lynx-common_2.9.0dev.12-1+core2.1.20261012055253_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lynx-2.9.0dev.12-1-core2.1-20261012055253/lynx-common_2.9.0dev.12-1%2Bcore2.1.20261012055253_all.deb)
- [lynx_2.9.0dev.12-1+core2.1.20261012055253_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lynx-2.9.0dev.12-1-core2.1-20261012055253/lynx_2.9.0dev.12-1%2Bcore2.1.20261012055253_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-lynx-2.9.0dev.12-1-core2.1-20261012055253)

### gv (optimized)
Version: `1:3.7.4-2+core2.1~20261012055256` · Published: 2026-10-12 05:54:41 UTC
**Description:** PostScript and PDF viewer for X
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gv`

**Binary downloads:**
- [gv_3.7.4-2+core2.1.20261012055256_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gv-1-3.7.4-2-core2.1-20261012055256/gv_3.7.4-2%2Bcore2.1.20261012055256_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gv-1-3.7.4-2-core2.1-20261012055256)

### mc (optimized)
Version: `3:4.8.29-2+core2.1~20261012055147` · Published: 2026-10-12 05:54:40 UTC
**Description:** Midnight Commander - a powerful file manager
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - mc`

**Binary downloads:**
- [mc-data_4.8.29-2+core2.1.20261012055147_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mc-3-4.8.29-2-core2.1-20261012055147/mc-data_4.8.29-2%2Bcore2.1.20261012055147_all.deb)
- [mc_4.8.29-2+core2.1.20261012055147_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mc-3-4.8.29-2-core2.1-20261012055147/mc_4.8.29-2%2Bcore2.1.20261012055147_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-mc-3-4.8.29-2-core2.1-20261012055147)

### slang2 (optimized)
Version: `2.3.3-3+core2.1~20261012055155` · Published: 2026-10-12 05:54:26 UTC
**Description:** Shared modules for S-Lang language
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - slang2`

**Binary downloads:**
- [libslang2-dev_2.3.3-3+core2.1.20261012055155_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-slang2-2.3.3-3-core2.1-20261012055155/libslang2-dev_2.3.3-3%2Bcore2.1.20261012055155_amd64.deb)
- [libslang2-modules_2.3.3-3+core2.1.20261012055155_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-slang2-2.3.3-3-core2.1-20261012055155/libslang2-modules_2.3.3-3%2Bcore2.1.20261012055155_amd64.deb)
- [libslang2-pic_2.3.3-3+core2.1.20261012055155_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-slang2-2.3.3-3-core2.1-20261012055155/libslang2-pic_2.3.3-3%2Bcore2.1.20261012055155_amd64.deb)
- [libslang2_2.3.3-3+core2.1.20261012055155_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-slang2-2.3.3-3-core2.1-20261012055155/libslang2_2.3.3-3%2Bcore2.1.20261012055155_amd64.deb)
- [slsh_2.3.3-3+core2.1.20261012055155_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-slang2-2.3.3-3-core2.1-20261012055155/slsh_2.3.3-3%2Bcore2.1.20261012055155_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-slang2-2.3.3-3-core2.1-20261012055155)

### file (optimized)
Version: `1:5.44-3+core2.1~20261012055237` · Published: 2026-10-12 05:54:25 UTC
**Description:** Recognize the type of data in a file using "magic" numbers
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - file`

**Binary downloads:**
- [file_5.44-3+core2.1.20261012055237_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-file-1-5.44-3-core2.1-20261012055237/file_5.44-3%2Bcore2.1.20261012055237_amd64.deb)
- [libmagic-dev_5.44-3+core2.1.20261012055237_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-file-1-5.44-3-core2.1-20261012055237/libmagic-dev_5.44-3%2Bcore2.1.20261012055237_amd64.deb)
- [libmagic-mgc_5.44-3+core2.1.20261012055237_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-file-1-5.44-3-core2.1-20261012055237/libmagic-mgc_5.44-3%2Bcore2.1.20261012055237_amd64.deb)
- [libmagic1_5.44-3+core2.1.20261012055237_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-file-1-5.44-3-core2.1-20261012055237/libmagic1_5.44-3%2Bcore2.1.20261012055237_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-file-1-5.44-3-core2.1-20261012055237)

### odt2txt (optimized)
Version: `0.5-7+core2.1~20261012055305` · Published: 2026-10-12 05:54:23 UTC
**Description:** simple converter from OpenDocument Text to plain text
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - odt2txt`

**Binary downloads:**
- [odt2txt_0.5-7+core2.1.20261012055305_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-odt2txt-0.5-7-core2.1-20261012055305/odt2txt_0.5-7%2Bcore2.1.20261012055305_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-odt2txt-0.5-7-core2.1-20261012055305)

### libssh2 (optimized)
Version: `1.10.0-3+deb12u1+core2.1~20261012055158` · Published: 2026-10-12 05:54:14 UTC
**Description:** SSH2 client-side library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libssh2`

**Binary downloads:**
- [libssh2-1-dev_1.10.0-3+deb12u1+core2.1.20261012055158_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libssh2-1.10.0-3-deb12u1-core2.1-20261012055158/libssh2-1-dev_1.10.0-3%2Bdeb12u1%2Bcore2.1.20261012055158_amd64.deb)
- [libssh2-1_1.10.0-3+deb12u1+core2.1.20261012055158_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libssh2-1.10.0-3-deb12u1-core2.1-20261012055158/libssh2-1_1.10.0-3%2Bdeb12u1%2Bcore2.1.20261012055158_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libssh2-1.10.0-3-deb12u1-core2.1-20261012055158)

### ebook-tools (optimized)
Version: `0.2.2-6+core2.1~20261012055224` · Published: 2026-10-12 05:54:13 UTC
**Description:** tools to work with the EPUB file format
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - ebook-tools`

**Binary downloads:**
- [epub-utils_0.2.2-6+core2.1.20261012055224_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ebook-tools-0.2.2-6-core2.1-20261012055224/epub-utils_0.2.2-6%2Bcore2.1.20261012055224_amd64.deb)
- [libepub-dev_0.2.2-6+core2.1.20261012055224_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ebook-tools-0.2.2-6-core2.1-20261012055224/libepub-dev_0.2.2-6%2Bcore2.1.20261012055224_amd64.deb)
- [libepub0_0.2.2-6+core2.1.20261012055224_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ebook-tools-0.2.2-6-core2.1-20261012055224/libepub0_0.2.2-6%2Bcore2.1.20261012055224_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-ebook-tools-0.2.2-6-core2.1-20261012055224)

### bzip2 (optimized)
Version: `1.0.8-5+core2.1~20261012055218` · Published: 2026-10-12 05:53:52 UTC
**Description:** high-quality block-sorting file compressor - utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - bzip2`

**Binary downloads:**
- [bzip2-doc_1.0.8-5+core2.1.20261012055218_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-bzip2-1.0.8-5-core2.1-20261012055218/bzip2-doc_1.0.8-5%2Bcore2.1.20261012055218_all.deb)
- [bzip2_1.0.8-5+core2.1.20261012055218_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-bzip2-1.0.8-5-core2.1-20261012055218/bzip2_1.0.8-5%2Bcore2.1.20261012055218_amd64.deb)
- [libbz2-1.0_1.0.8-5+core2.1.20261012055218_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-bzip2-1.0.8-5-core2.1-20261012055218/libbz2-1.0_1.0.8-5%2Bcore2.1.20261012055218_amd64.deb)
- [libbz2-dev_1.0.8-5+core2.1.20261012055218_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-bzip2-1.0.8-5-core2.1-20261012055218/libbz2-dev_1.0.8-5%2Bcore2.1.20261012055218_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-bzip2-1.0.8-5-core2.1-20261012055218)

### catdvi (optimized)
Version: `0.14-14+core2.1~20261012055215` · Published: 2026-10-12 05:53:50 UTC
**Description:** DVI to plain text translator
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - catdvi`

**Binary downloads:**
- [catdvi_0.14-14+core2.1.20261012055215_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-catdvi-0.14-14-core2.1-20261012055215/catdvi_0.14-14%2Bcore2.1.20261012055215_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-catdvi-0.14-14-core2.1-20261012055215)

### arj (optimized)
Version: `3.10.22-26+core2.1~20261012055158` · Published: 2026-10-12 05:53:49 UTC
**Description:** archiver for .arj files
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - arj`

**Binary downloads:**
- [arj_3.10.22-26+core2.1.20261012055158_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-arj-3.10.22-26-core2.1-20261012055158/arj_3.10.22-26%2Bcore2.1.20261012055158_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-arj-3.10.22-26-core2.1-20261012055158)

### unzip (optimized)
Version: `6.0-28+deb12u1+core2.1~20261012055157` · Published: 2026-10-12 05:53:44 UTC
**Description:** De-archiver for .zip files
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - unzip`

**Binary downloads:**
- [unzip_6.0-28+deb12u1+core2.1.20261012055157_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-unzip-6.0-28-deb12u1-core2.1-20261012055157/unzip_6.0-28%2Bdeb12u1%2Bcore2.1.20261012055157_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-unzip-6.0-28-deb12u1-core2.1-20261012055157)

### dbview (optimized)
Version: `1.0.4-5+core2.1~20261012055207` · Published: 2026-10-12 05:53:42 UTC
**Description:** view dBase III files
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - dbview`

**Binary downloads:**
- [dbview_1.0.4-5+core2.1.20261012055207_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-dbview-1.0.4-5-core2.1-20261012055207/dbview_1.0.4-5%2Bcore2.1.20261012055207_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-dbview-1.0.4-5-core2.1-20261012055207)

### gpm (optimized)
Version: `1.20.7-10+core2.1~20261012055149` · Published: 2026-10-12 05:53:41 UTC
**Description:** General Purpose Mouse interface
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gpm`

**Binary downloads:**
- [gpm_1.20.7-10+core2.1.20261012055149_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gpm-1.20.7-10-core2.1-20261012055149/gpm_1.20.7-10%2Bcore2.1.20261012055149_amd64.deb)
- [libgpm-dev_1.20.7-10+core2.1.20261012055149_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gpm-1.20.7-10-core2.1-20261012055149/libgpm-dev_1.20.7-10%2Bcore2.1.20261012055149_amd64.deb)
- [libgpm2_1.20.7-10+core2.1.20261012055149_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gpm-1.20.7-10-core2.1-20261012055149/libgpm2_1.20.7-10%2Bcore2.1.20261012055149_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gpm-1.20.7-10-core2.1-20261012055149)

### tigervnc (optimized)
Version: `1.12.0+dfsg-8+core2.1~20261011154436` · Published: 2026-10-11 15:47:36 UTC
**Description:** Virtual network computing; Tools for both clients and servers
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - tigervnc`

**Binary downloads:**
- [tigervnc-common_1.12.0+dfsg-8+core2.1.20261011154436_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436/tigervnc-common_1.12.0%2Bdfsg-8%2Bcore2.1.20261011154436_amd64.deb)
- [tigervnc-scraping-server_1.12.0+dfsg-8+core2.1.20261011154436_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436/tigervnc-scraping-server_1.12.0%2Bdfsg-8%2Bcore2.1.20261011154436_amd64.deb)
- [tigervnc-standalone-server_1.12.0+dfsg-8+core2.1.20261011154436_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436/tigervnc-standalone-server_1.12.0%2Bdfsg-8%2Bcore2.1.20261011154436_amd64.deb)
- [tigervnc-tools_1.12.0+dfsg-8+core2.1.20261011154436_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436/tigervnc-tools_1.12.0%2Bdfsg-8%2Bcore2.1.20261011154436_amd64.deb)
- [tigervnc-viewer_1.12.0+dfsg-8+core2.1.20261011154436_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436/tigervnc-viewer_1.12.0%2Bdfsg-8%2Bcore2.1.20261011154436_amd64.deb)
- [tigervnc-xorg-extension_1.12.0+dfsg-8+core2.1.20261011154436_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436/tigervnc-xorg-extension_1.12.0%2Bdfsg-8%2Bcore2.1.20261011154436_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-tigervnc-1.12.0-dfsg-8-core2.1-20261011154436)

### pixman (optimized)
Version: `0.42.2-1+core2.1~20261011154041` · Published: 2026-10-11 15:43:07 UTC
**Description:** pixel-manipulation library for X and cairo
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - pixman`

**Binary downloads:**
- [libpixman-1-0_0.42.2-1+core2.1.20261011154041_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pixman-0.42.2-1-core2.1-20261011154041/libpixman-1-0_0.42.2-1%2Bcore2.1.20261011154041_amd64.deb)
- [libpixman-1-dev_0.42.2-1+core2.1.20261011154041_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-pixman-0.42.2-1-core2.1-20261011154041/libpixman-1-dev_0.42.2-1%2Bcore2.1.20261011154041_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-pixman-0.42.2-1-core2.1-20261011154041)

### libjpeg-turbo (optimized)
Version: `1:2.1.5-2+core2.1~20261011153748` · Published: 2026-10-11 15:39:39 UTC
**Description:** Java bindings for the TurboJPEG library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libjpeg-turbo`

**Binary downloads:**
- [libjpeg-dev_2.1.5-2+core2.1.20261011153748_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748/libjpeg-dev_2.1.5-2%2Bcore2.1.20261011153748_amd64.deb)
- [libjpeg-turbo-progs_2.1.5-2+core2.1.20261011153748_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748/libjpeg-turbo-progs_2.1.5-2%2Bcore2.1.20261011153748_amd64.deb)
- [libjpeg62-turbo-dev_2.1.5-2+core2.1.20261011153748_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748/libjpeg62-turbo-dev_2.1.5-2%2Bcore2.1.20261011153748_amd64.deb)
- [libjpeg62-turbo_2.1.5-2+core2.1.20261011153748_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748/libjpeg62-turbo_2.1.5-2%2Bcore2.1.20261011153748_amd64.deb)
- [libturbojpeg-java_2.1.5-2+core2.1.20261011153748_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748/libturbojpeg-java_2.1.5-2%2Bcore2.1.20261011153748_all.deb)
- [libturbojpeg0-dev_2.1.5-2+core2.1.20261011153748_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748/libturbojpeg0-dev_2.1.5-2%2Bcore2.1.20261011153748_amd64.deb)
- [libturbojpeg0_2.1.5-2+core2.1.20261011153748_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748/libturbojpeg0_2.1.5-2%2Bcore2.1.20261011153748_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libjpeg-turbo-1-2.1.5-2-core2.1-20261011153748)

### imagemagick (optimized)
Version: `8:6.9.11.60+dfsg-1.6+deb12u13+core2.1~20261011064530` · Published: 2026-10-11 07:09:57 UTC
**Description:** image manipulation programs -- binaries
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - imagemagick`

**Binary downloads:**
- [imagemagick-6-common_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/imagemagick-6-common_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
- [imagemagick-6-doc_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/imagemagick-6-doc_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
- [imagemagick-6.q16_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/imagemagick-6.q16_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [imagemagick-6.q16hdri_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/imagemagick-6.q16hdri_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [imagemagick-common_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/imagemagick-common_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
- [imagemagick-doc_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/imagemagick-doc_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
- [imagemagick_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/imagemagick_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libimage-magick-perl_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libimage-magick-perl_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
- [libimage-magick-q16-perl_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libimage-magick-q16-perl_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libimage-magick-q16hdri-perl_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libimage-magick-q16hdri-perl_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagick++-6-headers_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagick%2B%2B-6-headers_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
- [libmagick++-6.q16-8_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagick%2B%2B-6.q16-8_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagick++-6.q16-dev_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagick%2B%2B-6.q16-dev_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagick++-6.q16hdri-8_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagick%2B%2B-6.q16hdri-8_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagick++-6.q16hdri-dev_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagick%2B%2B-6.q16hdri-dev_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagick++-dev_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagick%2B%2B-dev_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
- [libmagickcore-6-arch-config_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickcore-6-arch-config_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagickcore-6-headers_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickcore-6-headers_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
- [libmagickcore-6.q16-6-extra_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickcore-6.q16-6-extra_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagickcore-6.q16-6_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickcore-6.q16-6_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagickcore-6.q16-dev_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickcore-6.q16-dev_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagickcore-6.q16hdri-6-extra_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickcore-6.q16hdri-6-extra_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagickcore-6.q16hdri-6_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickcore-6.q16hdri-6_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagickcore-6.q16hdri-dev_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickcore-6.q16hdri-dev_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagickcore-dev_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickcore-dev_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
- [libmagickwand-6-headers_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickwand-6-headers_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
- [libmagickwand-6.q16-6_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickwand-6.q16-6_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagickwand-6.q16-dev_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickwand-6.q16-dev_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagickwand-6.q16hdri-6_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickwand-6.q16hdri-6_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagickwand-6.q16hdri-dev_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickwand-6.q16hdri-dev_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_amd64.deb)
- [libmagickwand-dev_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/libmagickwand-dev_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
- [perlmagick_6.9.11.60+dfsg-1.6+deb12u13+core2.1.20261011064530_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530/perlmagick_6.9.11.60%2Bdfsg-1.6%2Bdeb12u13%2Bcore2.1.20261011064530_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-imagemagick-8-6.9.11.60-dfsg-1.6-deb12u13-core2.1-20261011064530)

### gstreamer1.0 (optimized)
Version: `1.22.0-2+deb12u1+core2.1~20261011064624` · Published: 2026-10-11 06:48:32 UTC
**Description:** Tools for use with GStreamer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gstreamer1.0`

**Binary downloads:**
- [gir1.2-gstreamer-1.0_1.22.0-2+deb12u1+core2.1.20261011064624_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gstreamer1.0-1.22.0-2-deb12u1-core2.1-20261011064624/gir1.2-gstreamer-1.0_1.22.0-2%2Bdeb12u1%2Bcore2.1.20261011064624_amd64.deb)
- [gstreamer1.0-tools_1.22.0-2+deb12u1+core2.1.20261011064624_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gstreamer1.0-1.22.0-2-deb12u1-core2.1-20261011064624/gstreamer1.0-tools_1.22.0-2%2Bdeb12u1%2Bcore2.1.20261011064624_amd64.deb)
- [libgstreamer1.0-0_1.22.0-2+deb12u1+core2.1.20261011064624_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gstreamer1.0-1.22.0-2-deb12u1-core2.1-20261011064624/libgstreamer1.0-0_1.22.0-2%2Bdeb12u1%2Bcore2.1.20261011064624_amd64.deb)
- [libgstreamer1.0-dev_1.22.0-2+deb12u1+core2.1.20261011064624_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-gstreamer1.0-1.22.0-2-deb12u1-core2.1-20261011064624/libgstreamer1.0-dev_1.22.0-2%2Bdeb12u1%2Bcore2.1.20261011064624_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-gstreamer1.0-1.22.0-2-deb12u1-core2.1-20261011064624)

### libwebp (optimized)
Version: `1.2.4-0.2+deb12u1+core2.1~20261011064208` · Published: 2026-10-11 06:43:39 UTC
**Description:** Lossy compression of digital photographic images.
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libwebp`

**Binary downloads:**
- [libwebp-dev_1.2.4-0.2+deb12u1+core2.1.20261011064208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libwebp-1.2.4-0.2-deb12u1-core2.1-20261011064208/libwebp-dev_1.2.4-0.2%2Bdeb12u1%2Bcore2.1.20261011064208_amd64.deb)
- [libwebp7_1.2.4-0.2+deb12u1+core2.1.20261011064208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libwebp-1.2.4-0.2-deb12u1-core2.1-20261011064208/libwebp7_1.2.4-0.2%2Bdeb12u1%2Bcore2.1.20261011064208_amd64.deb)
- [libwebpdemux2_1.2.4-0.2+deb12u1+core2.1.20261011064208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libwebp-1.2.4-0.2-deb12u1-core2.1-20261011064208/libwebpdemux2_1.2.4-0.2%2Bdeb12u1%2Bcore2.1.20261011064208_amd64.deb)
- [libwebpmux3_1.2.4-0.2+deb12u1+core2.1.20261011064208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libwebp-1.2.4-0.2-deb12u1-core2.1-20261011064208/libwebpmux3_1.2.4-0.2%2Bdeb12u1%2Bcore2.1.20261011064208_amd64.deb)
- [webp_1.2.4-0.2+deb12u1+core2.1.20261011064208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libwebp-1.2.4-0.2-deb12u1-core2.1-20261011064208/webp_1.2.4-0.2%2Bdeb12u1%2Bcore2.1.20261011064208_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libwebp-1.2.4-0.2-deb12u1-core2.1-20261011064208)

### perl (optimized)
Version: `5.36.0-7+deb12u4+core2.1~20261011040002` · Published: 2026-10-11 04:38:51 UTC
**Description:** Larry Wall's Practical Extraction and Report Language
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - perl`

**Binary downloads:**
- [libperl-dev_5.36.0-7+deb12u4+core2.1.20261011040002_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002/libperl-dev_5.36.0-7%2Bdeb12u4%2Bcore2.1.20261011040002_amd64.deb)
- [libperl5.36_5.36.0-7+deb12u4+core2.1.20261011040002_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002/libperl5.36_5.36.0-7%2Bdeb12u4%2Bcore2.1.20261011040002_amd64.deb)
- [perl-base_5.36.0-7+deb12u4+core2.1.20261011040002_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002/perl-base_5.36.0-7%2Bdeb12u4%2Bcore2.1.20261011040002_amd64.deb)
- [perl-debug_5.36.0-7+deb12u4+core2.1.20261011040002_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002/perl-debug_5.36.0-7%2Bdeb12u4%2Bcore2.1.20261011040002_amd64.deb)
- [perl-doc_5.36.0-7+deb12u4+core2.1.20261011040002_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002/perl-doc_5.36.0-7%2Bdeb12u4%2Bcore2.1.20261011040002_all.deb)
- [perl-modules-5.36_5.36.0-7+deb12u4+core2.1.20261011040002_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002/perl-modules-5.36_5.36.0-7%2Bdeb12u4%2Bcore2.1.20261011040002_all.deb)
- [perl_5.36.0-7+deb12u4+core2.1.20261011040002_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002/perl_5.36.0-7%2Bdeb12u4%2Bcore2.1.20261011040002_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-perl-5.36.0-7-deb12u4-core2.1-20261011040002)

### openssl (optimized)
Version: `3.0.22-1~deb12u1+core2.1~20261011040326` · Published: 2026-10-11 04:21:38 UTC
**Description:** Secure Sockets Layer toolkit - cryptographic utility
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - openssl`

**Binary downloads:**
- [libssl-dev_3.0.22-1.deb12u1+core2.1.20261011040326_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openssl-3.0.22-1-deb12u1-core2.1-20261011040326/libssl-dev_3.0.22-1.deb12u1%2Bcore2.1.20261011040326_amd64.deb)
- [libssl-doc_3.0.22-1.deb12u1+core2.1.20261011040326_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openssl-3.0.22-1-deb12u1-core2.1-20261011040326/libssl-doc_3.0.22-1.deb12u1%2Bcore2.1.20261011040326_all.deb)
- [libssl3_3.0.22-1.deb12u1+core2.1.20261011040326_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openssl-3.0.22-1-deb12u1-core2.1-20261011040326/libssl3_3.0.22-1.deb12u1%2Bcore2.1.20261011040326_amd64.deb)
- [openssl_3.0.22-1.deb12u1+core2.1.20261011040326_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-openssl-3.0.22-1-deb12u1-core2.1-20261011040326/openssl_3.0.22-1.deb12u1%2Bcore2.1.20261011040326_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-openssl-3.0.22-1-deb12u1-core2.1-20261011040326)

### zip (optimized)
Version: `3.0-13+deb12u1+core2.1~20261011040024` · Published: 2026-10-11 04:01:15 UTC
**Description:** Archiver for .zip files
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - zip`

**Binary downloads:**
- [zip_3.0-13+deb12u1+core2.1.20261011040024_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zip-3.0-13-deb12u1-core2.1-20261011040024/zip_3.0-13%2Bdeb12u1%2Bcore2.1.20261011040024_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-zip-3.0-13-deb12u1-core2.1-20261011040024)

### GNU C Library (glibc) (system)
Version: `2.36-9+deb12u14+core2.1~20261010052854` · Published: 2026-10-10 05:56:13 UTC
**Description:** GNU C Library: Shared libraries
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - glibc`

**Binary downloads:**
- [glibc-doc_2.36-9+deb12u14+core2.1.20261010052854_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/glibc-doc_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_all.deb)
- [glibc-source_2.36-9+deb12u14+core2.1.20261010052854_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/glibc-source_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_all.deb)
- [libc-bin_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc-bin_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc-dev-bin_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc-dev-bin_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc-devtools_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc-devtools_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc-l10n_2.36-9+deb12u14+core2.1.20261010052854_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc-l10n_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_all.deb)
- [libc6-dev-i386_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6-dev-i386_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc6-dev-x32_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6-dev-x32_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc6-dev_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6-dev_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc6-i386_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6-i386_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc6-x32_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6-x32_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [libc6_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/libc6_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [locales-all_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/locales-all_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
- [locales_2.36-9+deb12u14+core2.1.20261010052854_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/locales_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_all.deb)
- [nscd_2.36-9+deb12u14+core2.1.20261010052854_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854/nscd_2.36-9%2Bdeb12u14%2Bcore2.1.20261010052854_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-glibc-2.36-9-deb12u14-core2.1-20261010052854)

### thunar (optimized)
Version: `4.18.4-1+core2.1~20261010054751` · Published: 2026-10-10 05:50:00 UTC
**Description:** File Manager for Xfce
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - thunar`

**Binary downloads:**
- [gir1.2-thunarx-3.0_4.18.4-1+core2.1.20261010054751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/gir1.2-thunarx-3.0_4.18.4-1%2Bcore2.1.20261010054751_amd64.deb)
- [libthunarx-3-0_4.18.4-1+core2.1.20261010054751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/libthunarx-3-0_4.18.4-1%2Bcore2.1.20261010054751_amd64.deb)
- [libthunarx-3-dev_4.18.4-1+core2.1.20261010054751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/libthunarx-3-dev_4.18.4-1%2Bcore2.1.20261010054751_amd64.deb)
- [thunar-data_4.18.4-1+core2.1.20261010054751_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/thunar-data_4.18.4-1%2Bcore2.1.20261010054751_all.deb)
- [thunar_4.18.4-1+core2.1.20261010054751_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-thunar-4.18.4-1-core2.1-20261010054751/thunar_4.18.4-1%2Bcore2.1.20261010054751_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-thunar-4.18.4-1-core2.1-20261010054751)

### tumbler (optimized)
Version: `4.18.0-1+core2.1~20261010054511` · Published: 2026-10-10 05:46:25 UTC
**Description:** D-Bus thumbnailing service
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - tumbler`

**Binary downloads:**
- [libtumbler-1-0_4.18.0-1+core2.1.20261010054511_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/libtumbler-1-0_4.18.0-1%2Bcore2.1.20261010054511_amd64.deb)
- [libtumbler-1-dev_4.18.0-1+core2.1.20261010054511_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/libtumbler-1-dev_4.18.0-1%2Bcore2.1.20261010054511_amd64.deb)
- [tumbler-common_4.18.0-1+core2.1.20261010054511_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/tumbler-common_4.18.0-1%2Bcore2.1.20261010054511_all.deb)
- [tumbler-plugins-extra_4.18.0-1+core2.1.20261010054511_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/tumbler-plugins-extra_4.18.0-1%2Bcore2.1.20261010054511_amd64.deb)
- [tumbler_4.18.0-1+core2.1.20261010054511_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-tumbler-4.18.0-1-core2.1-20261010054511/tumbler_4.18.0-1%2Bcore2.1.20261010054511_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-tumbler-4.18.0-1-core2.1-20261010054511)

### garcon (optimized)
Version: `4.18.0-1+core2.1~20261010054213` · Published: 2026-10-10 05:43:19 UTC
**Description:** Typelib file for garcon GTK
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - garcon`

**Binary downloads:**
- [gir1.2-garcon-1.0_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/gir1.2-garcon-1.0_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [gir1.2-garcongtk-1.0_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/gir1.2-garcongtk-1.0_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [libgarcon-1-0-dev_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-1-0-dev_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [libgarcon-1-0_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-1-0_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [libgarcon-1-dev_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-1-dev_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [libgarcon-common_4.18.0-1+core2.1.20261010054213_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-common_4.18.0-1%2Bcore2.1.20261010054213_all.deb)
- [libgarcon-gtk3-1-0_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-gtk3-1-0_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
- [libgarcon-gtk3-1-dev_4.18.0-1+core2.1.20261010054213_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-garcon-4.18.0-1-core2.1-20261010054213/libgarcon-gtk3-1-dev_4.18.0-1%2Bcore2.1.20261010054213_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-garcon-4.18.0-1-core2.1-20261010054213)

### exo (optimized)
Version: `4.18.0-1+core2.1~20261010053936` · Published: 2026-10-10 05:40:53 UTC
**Description:** libexo common files
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - exo`

**Binary downloads:**
- [exo-utils_4.18.0-1+core2.1.20261010053936_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-exo-4.18.0-1-core2.1-20261010053936/exo-utils_4.18.0-1%2Bcore2.1.20261010053936_amd64.deb)
- [libexo-2-0_4.18.0-1+core2.1.20261010053936_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-exo-4.18.0-1-core2.1-20261010053936/libexo-2-0_4.18.0-1%2Bcore2.1.20261010053936_amd64.deb)
- [libexo-2-dev_4.18.0-1+core2.1.20261010053936_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-exo-4.18.0-1-core2.1-20261010053936/libexo-2-dev_4.18.0-1%2Bcore2.1.20261010053936_amd64.deb)
- [libexo-common_4.18.0-1+core2.1.20261010053936_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-exo-4.18.0-1-core2.1-20261010053936/libexo-common_4.18.0-1%2Bcore2.1.20261010053936_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-exo-4.18.0-1-core2.1-20261010053936)

### libxfce4ui (optimized)
Version: `4.18.2-2+core2.1~20261010053651` · Published: 2026-10-10 05:38:11 UTC
**Description:** glade API for libxfce4ui
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxfce4ui`

**Binary downloads:**
- [gir1.2-libxfce4ui-2.0_4.18.2-2+core2.1.20261010053651_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/gir1.2-libxfce4ui-2.0_4.18.2-2%2Bcore2.1.20261010053651_amd64.deb)
- [libxfce4ui-2-0_4.18.2-2+core2.1.20261010053651_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/libxfce4ui-2-0_4.18.2-2%2Bcore2.1.20261010053651_amd64.deb)
- [libxfce4ui-2-dev_4.18.2-2+core2.1.20261010053651_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/libxfce4ui-2-dev_4.18.2-2%2Bcore2.1.20261010053651_amd64.deb)
- [libxfce4ui-common_4.18.2-2+core2.1.20261010053651_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/libxfce4ui-common_4.18.2-2%2Bcore2.1.20261010053651_all.deb)
- [libxfce4ui-glade_4.18.2-2+core2.1.20261010053651_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/libxfce4ui-glade_4.18.2-2%2Bcore2.1.20261010053651_amd64.deb)
- [libxfce4ui-utils_4.18.2-2+core2.1.20261010053651_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651/libxfce4ui-utils_4.18.2-2%2Bcore2.1.20261010053651_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4ui-4.18.2-2-core2.1-20261010053651)

### xfconf (optimized)
Version: `4.18.0-2+core2.1~20261010053410` · Published: 2026-10-10 05:35:14 UTC
**Description:** utilities for managing settings in Xfce
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xfconf`

**Binary downloads:**
- [gir1.2-xfconf-0_4.18.0-2+core2.1.20261010053410_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xfconf-4.18.0-2-core2.1-20261010053410/gir1.2-xfconf-0_4.18.0-2%2Bcore2.1.20261010053410_amd64.deb)
- [libxfconf-0-3_4.18.0-2+core2.1.20261010053410_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xfconf-4.18.0-2-core2.1-20261010053410/libxfconf-0-3_4.18.0-2%2Bcore2.1.20261010053410_amd64.deb)
- [libxfconf-0-dev_4.18.0-2+core2.1.20261010053410_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xfconf-4.18.0-2-core2.1-20261010053410/libxfconf-0-dev_4.18.0-2%2Bcore2.1.20261010053410_amd64.deb)
- [xfconf_4.18.0-2+core2.1.20261010053410_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xfconf-4.18.0-2-core2.1-20261010053410/xfconf_4.18.0-2%2Bcore2.1.20261010053410_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xfconf-4.18.0-2-core2.1-20261010053410)

### libxfce4util (optimized)
Version: `4.18.1-2+core2.1~20261010053208` · Published: 2026-10-10 05:33:07 UTC
**Description:** Typelib file for libxfce4util
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxfce4util`

**Binary downloads:**
- [gir1.2-libxfce4util-1.0_4.18.1-2+core2.1.20261010053208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/gir1.2-libxfce4util-1.0_4.18.1-2%2Bcore2.1.20261010053208_amd64.deb)
- [libxfce4util-bin_4.18.1-2+core2.1.20261010053208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/libxfce4util-bin_4.18.1-2%2Bcore2.1.20261010053208_amd64.deb)
- [libxfce4util-common_4.18.1-2+core2.1.20261010053208_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/libxfce4util-common_4.18.1-2%2Bcore2.1.20261010053208_all.deb)
- [libxfce4util-dev_4.18.1-2+core2.1.20261010053208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/libxfce4util-dev_4.18.1-2%2Bcore2.1.20261010053208_amd64.deb)
- [libxfce4util7_4.18.1-2+core2.1.20261010053208_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-libxfce4util-4.18.1-2-core2.1-20261010053208/libxfce4util7_4.18.1-2%2Bcore2.1.20261010053208_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-libxfce4util-4.18.1-2-core2.1-20261010053208)

### systemd (system)
Version: `252.39-1~deb12u2+core2.1~20261010025144` · Published: 2026-10-10 02:59:56 UTC
**Description:** system and service manager
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - systemd`

**Binary downloads:**
- [libnss-myhostname_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libnss-myhostname_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libnss-mymachines_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libnss-mymachines_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libnss-resolve_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libnss-resolve_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libnss-systemd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libnss-systemd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libpam-systemd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libpam-systemd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libsystemd-shared_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libsystemd-shared_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libsystemd0_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libsystemd0_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [libudev1_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/libudev1_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-boot-efi_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-boot-efi_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-boot_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-boot_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-container_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-container_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-coredump_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-coredump_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-homed_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-homed_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-journal-remote_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-journal-remote_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-oomd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-oomd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-resolved_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-resolved_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-standalone-sysusers_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-standalone-sysusers_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-standalone-tmpfiles_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-standalone-tmpfiles_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-sysv_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-sysv_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-tests_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-tests_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-timesyncd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-timesyncd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd-userdbd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd-userdbd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [systemd_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/systemd_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
- [udev_252.39-1.deb12u2+core2.1.20261010025144_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144/udev_252.39-1.deb12u2%2Bcore2.1.20261010025144_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-systemd-252.39-1-deb12u2-core2.1-20261010025144)

### GNU Binutils (system)
Version: `2.40-2+core2.1~20261009173258` · Published: 2026-10-09 20:39:48 UTC
**Description:** GNU assembler, linker and binary utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - binutils`

**Binary downloads:**
- [binutils-aarch64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-aarch64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-alpha-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-alpha-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-arc-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-arc-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-arm-linux-gnueabi_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-arm-linux-gnueabi_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-arm-linux-gnueabihf_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-arm-linux-gnueabihf_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-common_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-common_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-doc_2.40-2+core2.1.20261009173258_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-doc_2.40-2%2Bcore2.1.20261009173258_all.deb)
- [binutils-for-build_2.40-2+core2.1.20261009173258_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-for-build_2.40-2%2Bcore2.1.20261009173258_all.deb)
- [binutils-for-host_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-for-host_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-hppa-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-hppa-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-hppa64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-hppa64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-i686-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-i686-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-i686-kfreebsd-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-i686-kfreebsd-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-i686-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-i686-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-ia64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-ia64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-m68k-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-m68k-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-multiarch_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-multiarch_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-powerpc-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-powerpc-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-powerpc64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-powerpc64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-powerpc64le-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-powerpc64le-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-riscv64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-riscv64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-s390x-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-s390x-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-sh4-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-sh4-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-source_2.40-2+core2.1.20261009173258_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-source_2.40-2%2Bcore2.1.20261009173258_all.deb)
- [binutils-sparc64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-sparc64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-x86-64-kfreebsd-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-x86-64-kfreebsd-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-x86-64-linux-gnu_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-x86-64-linux-gnu_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils-x86-64-linux-gnux32_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils-x86-64-linux-gnux32_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [binutils_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/binutils_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [libbinutils_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/libbinutils_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [libctf-nobfd0_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/libctf-nobfd0_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [libctf0_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/libctf0_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
- [libgprofng0_2.40-2+core2.1.20261009173258_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-binutils-2.40-2-core2.1-20261009173258/libgprofng0_2.40-2%2Bcore2.1.20261009173258_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-binutils-2.40-2-core2.1-20261009173258)

### libtirpc (system)
Version: `1.3.3+ds-1+core2.1~20261009195337` · Published: 2026-10-09 19:54:21 UTC
**Description:** transport-independent RPC library - common files
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libtirpc`

**Binary downloads:**
- [libtirpc-common_1.3.3+ds-1+core2.1.20261009195337_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libtirpc-1.3.3-ds-1-core2.1-20261009195337/libtirpc-common_1.3.3%2Bds-1%2Bcore2.1.20261009195337_all.deb)
- [libtirpc3_1.3.3+ds-1+core2.1.20261009195337_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libtirpc-1.3.3-ds-1-core2.1-20261009195337/libtirpc3_1.3.3%2Bds-1%2Bcore2.1.20261009195337_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libtirpc-1.3.3-ds-1-core2.1-20261009195337)

### libffi (system)
Version: `3.4.4-1+core2.1~20261009194707` · Published: 2026-10-09 19:51:15 UTC
**Description:** Foreign Function Interface library runtime
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libffi`

**Binary downloads:**
- [libffi8_3.4.4-1+core2.1.20261009194707_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libffi-3.4.4-1-core2.1-20261009194707/libffi8_3.4.4-1%2Bcore2.1.20261009194707_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libffi-3.4.4-1-core2.1-20261009194707)

### gmp (system)
Version: `2:6.2.1+dfsg1-1.1+core2.1~20261009194412` · Published: 2026-10-09 19:46:09 UTC
**Description:** Multiprecision arithmetic library (C++ bindings)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gmp`

**Binary downloads:**
- [libgmp10-doc_6.2.1+dfsg1-1.1+core2.1.20261009194412_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412/libgmp10-doc_6.2.1%2Bdfsg1-1.1%2Bcore2.1.20261009194412_all.deb)
- [libgmp10_6.2.1+dfsg1-1.1+core2.1.20261009194412_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412/libgmp10_6.2.1%2Bdfsg1-1.1%2Bcore2.1.20261009194412_amd64.deb)
- [libgmpxx4ldbl_6.2.1+dfsg1-1.1+core2.1.20261009194412_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412/libgmpxx4ldbl_6.2.1%2Bdfsg1-1.1%2Bcore2.1.20261009194412_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-gmp-2-6.2.1-dfsg1-1.1-core2.1-20261009194412)

### mpfr4 (system)
Version: `4.2.0-1+core2.1~20261009194039` · Published: 2026-10-09 19:43:32 UTC
**Description:** multiple precision floating-point computation
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - mpfr4`

**Binary downloads:**
- [libmpfr-doc_4.2.0-1+core2.1.20261009194039_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-mpfr4-4.2.0-1-core2.1-20261009194039/libmpfr-doc_4.2.0-1%2Bcore2.1.20261009194039_all.deb)
- [libmpfr6_4.2.0-1+core2.1.20261009194039_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-mpfr4-4.2.0-1-core2.1-20261009194039/libmpfr6_4.2.0-1%2Bcore2.1.20261009194039_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-mpfr4-4.2.0-1-core2.1-20261009194039)

### curl (optimized)
Version: `7.88.1-10+deb12u15+core2.1~20261009190528` · Published: 2026-10-09 19:41:11 UTC
**Description:** command line tool for transferring data with URL syntax
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - curl`

**Binary downloads:**
- [curl_7.88.1-10+deb12u15+core2.1.20261009190528_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/curl_7.88.1-10%2Bdeb12u15%2Bcore2.1.20261009190528_amd64.deb)
- [libcurl3-gnutls_7.88.1-10+deb12u15+core2.1.20261009190528_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/libcurl3-gnutls_7.88.1-10%2Bdeb12u15%2Bcore2.1.20261009190528_amd64.deb)
- [libcurl3-nss_7.88.1-10+deb12u15+core2.1.20261009190528_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/libcurl3-nss_7.88.1-10%2Bdeb12u15%2Bcore2.1.20261009190528_amd64.deb)
- [libcurl4-doc_7.88.1-10+deb12u15+core2.1.20261009190528_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/libcurl4-doc_7.88.1-10%2Bdeb12u15%2Bcore2.1.20261009190528_all.deb)
- [libcurl4_7.88.1-10+deb12u15+core2.1.20261009190528_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528/libcurl4_7.88.1-10%2Bdeb12u15%2Bcore2.1.20261009190528_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-curl-7.88.1-10-deb12u15-core2.1-20261009190528)

### XZ Utils (system)
Version: `5.4.1-1+deb12u2+core2.1~20261009193709` · Published: 2026-10-09 19:38:34 UTC
**Description:** XZ-format compression utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xz-utils`

**Binary downloads:**
- [liblzma-doc_5.4.1-1+deb12u2+core2.1.20261009193709_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709/liblzma-doc_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009193709_all.deb)
- [liblzma5_5.4.1-1+deb12u2+core2.1.20261009193709_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709/liblzma5_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009193709_amd64.deb)
- [xz-utils_5.4.1-1+deb12u2+core2.1.20261009193709_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709/xz-utils_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009193709_amd64.deb)
- [xzdec_5.4.1-1+deb12u2+core2.1.20261009193709_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709/xzdec_5.4.1-1%2Bdeb12u2%2Bcore2.1.20261009193709_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-xz-utils-5.4.1-1-deb12u2-core2.1-20261009193709)

### kmod (system)
Version: `30+20221128-1+core2.1~20261009193535` · Published: 2026-10-09 19:36:20 UTC
**Description:** tools for managing Linux kernel modules
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - kmod`

**Binary downloads:**
- [kmod_30+20221128-1+core2.1.20261009193535_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-kmod-30-20221128-1-core2.1-20261009193535/kmod_30%2B20221128-1%2Bcore2.1.20261009193535_amd64.deb)
- [libkmod2_30+20221128-1+core2.1.20261009193535_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-kmod-30-20221128-1-core2.1-20261009193535/libkmod2_30%2B20221128-1%2Bcore2.1.20261009193535_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-kmod-30-20221128-1-core2.1-20261009193535)

### iproute2 (system)
Version: `6.1.0-3+core2.1~20261009193351` · Published: 2026-10-09 19:34:38 UTC
**Description:** networking and traffic control tools
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - iproute2`

**Binary downloads:**
- [iproute2-doc_6.1.0-3+core2.1.20261009193351_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-iproute2-6.1.0-3-core2.1-20261009193351/iproute2-doc_6.1.0-3%2Bcore2.1.20261009193351_all.deb)
- [iproute2_6.1.0-3+core2.1.20261009193351_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-iproute2-6.1.0-3-core2.1-20261009193351/iproute2_6.1.0-3%2Bcore2.1.20261009193351_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-iproute2-6.1.0-3-core2.1-20261009193351)

### pam (system)
Version: `1.5.2-6+deb12u2+core2.1~20261009193111` · Published: 2026-10-09 19:32:56 UTC
**Description:** Pluggable Authentication Modules for PAM - helper binaries
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - pam`

**Binary downloads:**
- [libpam-doc_1.5.2-6+deb12u2+core2.1.20261009193111_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/libpam-doc_1.5.2-6%2Bdeb12u2%2Bcore2.1.20261009193111_all.deb)
- [libpam-modules-bin_1.5.2-6+deb12u2+core2.1.20261009193111_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/libpam-modules-bin_1.5.2-6%2Bdeb12u2%2Bcore2.1.20261009193111_amd64.deb)
- [libpam-modules_1.5.2-6+deb12u2+core2.1.20261009193111_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/libpam-modules_1.5.2-6%2Bdeb12u2%2Bcore2.1.20261009193111_amd64.deb)
- [libpam-runtime_1.5.2-6+deb12u2+core2.1.20261009193111_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/libpam-runtime_1.5.2-6%2Bdeb12u2%2Bcore2.1.20261009193111_all.deb)
- [libpam0g_1.5.2-6+deb12u2+core2.1.20261009193111_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111/libpam0g_1.5.2-6%2Bdeb12u2%2Bcore2.1.20261009193111_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-pam-1.5.2-6-deb12u2-core2.1-20261009193111)

### shadow (system)
Version: `1:4.13+dfsg1-1+deb12u2+core2.1~20261009192822` · Published: 2026-10-09 19:30:23 UTC
**Description:** programs to help use subuids
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - shadow`

**Binary downloads:**
- [libsubid4_4.13+dfsg1-1+deb12u2+core2.1.20261009192822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822/libsubid4_4.13%2Bdfsg1-1%2Bdeb12u2%2Bcore2.1.20261009192822_amd64.deb)
- [login_4.13+dfsg1-1+deb12u2+core2.1.20261009192822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822/login_4.13%2Bdfsg1-1%2Bdeb12u2%2Bcore2.1.20261009192822_amd64.deb)
- [passwd_4.13+dfsg1-1+deb12u2+core2.1.20261009192822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822/passwd_4.13%2Bdfsg1-1%2Bdeb12u2%2Bcore2.1.20261009192822_amd64.deb)
- [uidmap_4.13+dfsg1-1+deb12u2+core2.1.20261009192822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822/uidmap_4.13%2Bdfsg1-1%2Bdeb12u2%2Bcore2.1.20261009192822_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-shadow-1-4.13-dfsg1-1-deb12u2-core2.1-20261009192822)

### psmisc (system)
Version: `23.6-1+core2.1~20261009192718` · Published: 2026-10-09 19:27:48 UTC
**Description:** utilities that use the proc file system
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - psmisc`

**Binary downloads:**
- [psmisc_23.6-1+core2.1.20261009192718_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-psmisc-23.6-1-core2.1-20261009192718/psmisc_23.6-1%2Bcore2.1.20261009192718_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-psmisc-23.6-1-core2.1-20261009192718)

### e2fsprogs (system)
Version: `1.47.0-2+core2.1~20261009192320` · Published: 2026-10-09 19:26:35 UTC
**Description:** ext2/ext3/ext4 file system utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - e2fsprogs`

**Binary downloads:**
- [e2fsck-static_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/e2fsck-static_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [e2fsprogs-l10n_1.47.0-2+core2.1.20261009192320_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/e2fsprogs-l10n_1.47.0-2%2Bcore2.1.20261009192320_all.deb)
- [e2fsprogs_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/e2fsprogs_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [fuse2fs_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/fuse2fs_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [libcom-err2_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/libcom-err2_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [libext2fs2_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/libext2fs2_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [libss2_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/libss2_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
- [logsave_1.47.0-2+core2.1.20261009192320_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320/logsave_1.47.0-2%2Bcore2.1.20261009192320_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-e2fsprogs-1.47.0-2-core2.1-20261009192320)

### gzip (system)
Version: `1.12-1+core2.1~20261009191817` · Published: 2026-10-09 19:19:50 UTC
**Description:** GNU compression utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gzip`

**Binary downloads:**
- [gzip-win32_1.12-1+core2.1.20261009191817_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gzip-1.12-1-core2.1-20261009191817/gzip-win32_1.12-1%2Bcore2.1.20261009191817_all.deb)
- [gzip_1.12-1+core2.1.20261009191817_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gzip-1.12-1-core2.1-20261009191817/gzip_1.12-1%2Bcore2.1.20261009191817_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-gzip-1.12-1-core2.1-20261009191817)

### diffutils (system)
Version: `1:3.8-4+core2.1~20261009191615` · Published: 2026-10-09 19:17:10 UTC
**Description:** File comparison utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - diffutils`

**Binary downloads:**
- [diffutils-doc_3.8-4+core2.1.20261009191615_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-diffutils-1-3.8-4-core2.1-20261009191615/diffutils-doc_3.8-4%2Bcore2.1.20261009191615_all.deb)
- [diffutils_3.8-4+core2.1.20261009191615_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-diffutils-1-3.8-4-core2.1-20261009191615/diffutils_3.8-4%2Bcore2.1.20261009191615_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-diffutils-1-3.8-4-core2.1-20261009191615)

### sed (system)
Version: `4.9-1+deb12u1+core2.1~20261009191427` · Published: 2026-10-09 19:15:32 UTC
**Description:** GNU stream editor for filtering/transforming text
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - sed`

**Binary downloads:**
- [sed_4.9-1+deb12u1+core2.1.20261009191427_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-sed-4.9-1-deb12u1-core2.1-20261009191427/sed_4.9-1%2Bdeb12u1%2Bcore2.1.20261009191427_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-sed-4.9-1-deb12u1-core2.1-20261009191427)

### grep (system)
Version: `3.8-5+core2.1~20261009191150` · Published: 2026-10-09 19:13:45 UTC
**Description:** GNU grep, egrep and fgrep
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - grep`

**Binary downloads:**
- [grep_3.8-5+core2.1.20261009191150_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-grep-3.8-5-core2.1-20261009191150/grep_3.8-5%2Bcore2.1.20261009191150_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-grep-3.8-5-core2.1-20261009191150)

### attr (system)
Version: `1:2.5.1-4+core2.1~20261009191027` · Published: 2026-10-09 19:10:56 UTC
**Description:** utilities for manipulating filesystem extended attributes
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - attr`

**Binary downloads:**
- [attr_2.5.1-4+core2.1.20261009191027_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-attr-1-2.5.1-4-core2.1-20261009191027/attr_2.5.1-4%2Bcore2.1.20261009191027_amd64.deb)
- [libattr1_2.5.1-4+core2.1.20261009191027_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-attr-1-2.5.1-4-core2.1-20261009191027/libattr1_2.5.1-4%2Bcore2.1.20261009191027_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-attr-1-2.5.1-4-core2.1-20261009191027)

### acl (system)
Version: `2.3.1-3+core2.1~20261009190907` · Published: 2026-10-09 19:09:41 UTC
**Description:** access control list - utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - acl`

**Binary downloads:**
- [acl_2.3.1-3+core2.1.20261009190907_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-acl-2.3.1-3-core2.1-20261009190907/acl_2.3.1-3%2Bcore2.1.20261009190907_amd64.deb)
- [libacl1_2.3.1-3+core2.1.20261009190907_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-acl-2.3.1-3-core2.1-20261009190907/libacl1_2.3.1-3%2Bcore2.1.20261009190907_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-acl-2.3.1-3-core2.1-20261009190907)

### libselinux (system)
Version: `3.4-1+core2.1~20261009190433` · Published: 2026-10-09 19:05:10 UTC
**Description:** Ruby bindings to SELinux shared libraries
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libselinux`

**Binary downloads:**
- [libselinux1_3.4-1+core2.1.20261009190433_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libselinux-3.4-1-core2.1-20261009190433/libselinux1_3.4-1%2Bcore2.1.20261009190433_amd64.deb)
- [python3-selinux_3.4-1+core2.1.20261009190433_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libselinux-3.4-1-core2.1-20261009190433/python3-selinux_3.4-1%2Bcore2.1.20261009190433_amd64.deb)
- [ruby-selinux_3.4-1+core2.1.20261009190433_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libselinux-3.4-1-core2.1-20261009190433/ruby-selinux_3.4-1%2Bcore2.1.20261009190433_amd64.deb)
- [selinux-utils_3.4-1+core2.1.20261009190433_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libselinux-3.4-1-core2.1-20261009190433/selinux-utils_3.4-1%2Bcore2.1.20261009190433_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libselinux-3.4-1-core2.1-20261009190433)

### mpv (optimized)
Version: `0.35.1-4+core2.1~20261009190224` · Published: 2026-10-09 19:04:20 UTC
**Description:** video player based on MPlayer/mplayer2
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - mpv`

**Binary downloads:**
- [libmpv2_0.35.1-4+core2.1.20261009190224_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mpv-0.35.1-4-core2.1-20261009190224/libmpv2_0.35.1-4%2Bcore2.1.20261009190224_amd64.deb)
- [mpv_0.35.1-4+core2.1.20261009190224_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mpv-0.35.1-4-core2.1-20261009190224/mpv_0.35.1-4%2Bcore2.1.20261009190224_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-mpv-0.35.1-4-core2.1-20261009190224)

### libcap2 (system)
Version: `1:2.66-4+deb12u3+core2.1~20261009190327` · Published: 2026-10-09 19:03:51 UTC
**Description:** POSIX 1003.1e capabilities (library)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libcap2`

**Binary downloads:**
- [libcap2-bin_2.66-4+deb12u3+core2.1.20261009190327_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327/libcap2-bin_2.66-4%2Bdeb12u3%2Bcore2.1.20261009190327_amd64.deb)
- [libcap2_2.66-4+deb12u3+core2.1.20261009190327_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327/libcap2_2.66-4%2Bdeb12u3%2Bcore2.1.20261009190327_amd64.deb)
- [libpam-cap_2.66-4+deb12u3+core2.1.20261009190327_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327/libpam-cap_2.66-4%2Bdeb12u3%2Bcore2.1.20261009190327_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libcap2-1-2.66-4-deb12u3-core2.1-20261009190327)

### ncurses (system)
Version: `6.4-4+core2.1~20261009185822` · Published: 2026-10-09 19:02:36 UTC
**Description:** shared libraries for terminal handling (legacy version)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - ncurses`

**Binary downloads:**
- [lib32ncurses6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/lib32ncurses6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [lib32ncursesw6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/lib32ncursesw6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [lib32tinfo6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/lib32tinfo6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libncurses5_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libncurses5_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libncurses6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libncurses6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libncursesw5_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libncursesw5_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libncursesw6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libncursesw6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libtinfo5_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libtinfo5_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [libtinfo6_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/libtinfo6_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [ncurses-base_6.4-4+core2.1.20261009185822_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/ncurses-base_6.4-4%2Bcore2.1.20261009185822_all.deb)
- [ncurses-bin_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/ncurses-bin_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [ncurses-doc_6.4-4+core2.1.20261009185822_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/ncurses-doc_6.4-4%2Bcore2.1.20261009185822_all.deb)
- [ncurses-examples_6.4-4+core2.1.20261009185822_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/ncurses-examples_6.4-4%2Bcore2.1.20261009185822_amd64.deb)
- [ncurses-term_6.4-4+core2.1.20261009185822_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-ncurses-6.4-4-core2.1-20261009185822/ncurses-term_6.4-4%2Bcore2.1.20261009185822_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-ncurses-6.4-4-core2.1-20261009185822)

### FFmpeg (optimized)
Version: `7:5.1.9-0+deb12u1+core2.1~20261009183944` · Published: 2026-10-09 19:00:59 UTC
**Description:** Tools for transcoding, streaming and playing of multimedia files
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - ffmpeg`

**Binary downloads:**
- [ffmpeg-doc_5.1.9-0+deb12u1+core2.1.20261009183944_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/ffmpeg-doc_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_all.deb)
- [ffmpeg_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/ffmpeg_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavcodec-extra59_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavcodec-extra59_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavcodec-extra_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavcodec-extra_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavcodec59_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavcodec59_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavdevice59_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavdevice59_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavfilter-extra8_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavfilter-extra8_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavfilter-extra_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavfilter-extra_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavfilter8_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavfilter8_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavformat-extra59_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavformat-extra59_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavformat-extra_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavformat-extra_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavformat59_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavformat59_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libavutil57_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libavutil57_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libpostproc56_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libpostproc56_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libswresample4_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libswresample4_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
- [libswscale6_5.1.9-0+deb12u1+core2.1.20261009183944_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944/libswscale6_5.1.9-0%2Bdeb12u1%2Bcore2.1.20261009183944_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-ffmpeg-7-5.1.9-0-deb12u1-core2.1-20261009183944)

### libxcrypt (system)
Version: `1:4.4.33-2+core2.1~20261009185630` · Published: 2026-10-09 18:57:31 UTC
**Description:** libcrypt shared library
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - libxcrypt`

**Binary downloads:**
- [libcrypt1_4.4.33-2+core2.1.20261009185630_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libxcrypt-1-4.4.33-2-core2.1-20261009185630/libcrypt1_4.4.33-2%2Bcore2.1.20261009185630_amd64.deb)
- [libxcrypt-source_4.4.33-2+core2.1.20261009185630_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-libxcrypt-1-4.4.33-2-core2.1-20261009185630/libxcrypt-source_4.4.33-2%2Bcore2.1.20261009185630_all.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-libxcrypt-1-4.4.33-2-core2.1-20261009185630)

### 7-Zip (optimized)
Version: `22.01+really26.02+dfsg-0+deb12u1+core2.1~20261009183500` · Published: 2026-10-09 18:37:34 UTC
**Description:** 7-Zip file archiver with a high compression ratio
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - 7zip`

**Binary downloads:**
- [7zip_22.01+really26.02+dfsg-0+deb12u1+core2.1.20261009183500_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-7zip-22.01-really26.02-dfsg-0-deb12u1-core2.1-20261009183500/7zip_22.01%2Breally26.02%2Bdfsg-0%2Bdeb12u1%2Bcore2.1.20261009183500_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-7zip-22.01-really26.02-dfsg-0-deb12u1-core2.1-20261009183500)

### fftw3 (optimized)
Version: `3.3.10-1+core2.1~20261009181939` · Published: 2026-10-09 18:29:31 UTC
**Description:** Library for computing Fast Fourier Transforms - Tools
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - fftw3`

**Binary downloads:**
- [libfftw3-bin_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-bin_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
- [libfftw3-doc_3.3.10-1+core2.1.20261009181939_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-doc_3.3.10-1%2Bcore2.1.20261009181939_all.deb)
- [libfftw3-double3_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-double3_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
- [libfftw3-long3_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-long3_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
- [libfftw3-mpi3_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-mpi3_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
- [libfftw3-quad3_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-quad3_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
- [libfftw3-single3_3.3.10-1+core2.1.20261009181939_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-fftw3-3.3.10-1-core2.1-20261009181939/libfftw3-single3_3.3.10-1%2Bcore2.1.20261009181939_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-fftw3-3.3.10-1-core2.1-20261009181939)

### python3.11 (optimized)
Version: `3.11.2-6+deb12u9+core2.1~20261009153835` · Published: 2026-10-09 18:18:32 UTC
**Description:** Interactive high-level object-oriented language (version 3.11)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - python3.11`

**Binary downloads:**
- [idle-python3.11_3.11.2-6+deb12u9+core2.1.20261009153835_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/idle-python3.11_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_all.deb)
- [libpython3.11-minimal_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/libpython3.11-minimal_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [libpython3.11-stdlib_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/libpython3.11-stdlib_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [libpython3.11-testsuite_3.11.2-6+deb12u9+core2.1.20261009153835_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/libpython3.11-testsuite_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_all.deb)
- [libpython3.11_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/libpython3.11_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [python3.11-doc_3.11.2-6+deb12u9+core2.1.20261009153835_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-doc_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_all.deb)
- [python3.11-examples_3.11.2-6+deb12u9+core2.1.20261009153835_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-examples_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_all.deb)
- [python3.11-full_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-full_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [python3.11-minimal_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-minimal_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [python3.11-nopie_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-nopie_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [python3.11-venv_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11-venv_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
- [python3.11_3.11.2-6+deb12u9+core2.1.20261009153835_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835/python3.11_3.11.2-6%2Bdeb12u9%2Bcore2.1.20261009153835_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-python3.11-3.11.2-6-deb12u9-core2.1-20261009153835)

### findutils (system)
Version: `4.9.0-4+core2.1~20261009164357` · Published: 2026-10-09 16:45:15 UTC
**Description:** utilities for finding files--find, xargs
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - findutils`

**Binary downloads:**
- [findutils_4.9.0-4+core2.1.20261009164357_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-findutils-4.9.0-4-core2.1-20261009164357/findutils_4.9.0-4%2Bcore2.1.20261009164357_amd64.deb)
- [locate_4.9.0-4+core2.1.20261009164357_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-findutils-4.9.0-4-core2.1-20261009164357/locate_4.9.0-4%2Bcore2.1.20261009164357_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-findutils-4.9.0-4-core2.1-20261009164357)

### rust-sd (optimized)
Version: `0.7.6-1+deb12u1+core2.1~20261009163957` · Published: 2026-10-09 16:42:51 UTC
**Description:** intuitive find and replace CLI
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - rust-sd`

**Binary downloads:**
- [sd_0.80.really.0.7.6-1+deb12u1+core2.1.20261009163957_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-rust-sd-0.7.6-1-deb12u1-core2.1-20261009163957/sd_0.80.really.0.7.6-1%2Bdeb12u1%2Bcore2.1.20261009163957_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-rust-sd-0.7.6-1-deb12u1-core2.1-20261009163957)

### nano (optimized)
Version: `7.2-1+deb12u1+core2.1~20261009163909` · Published: 2026-10-09 16:40:55 UTC
**Description:** small, friendly text editor inspired by Pico
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - nano`

**Binary downloads:**
- [nano-tiny_7.2-1+deb12u1+core2.1.20261009163909_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-nano-7.2-1-deb12u1-core2.1-20261009163909/nano-tiny_7.2-1%2Bdeb12u1%2Bcore2.1.20261009163909_amd64.deb)
- [nano_7.2-1+deb12u1+core2.1.20261009163909_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-nano-7.2-1-deb12u1-core2.1-20261009163909/nano_7.2-1%2Bdeb12u1%2Bcore2.1.20261009163909_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-nano-7.2-1-deb12u1-core2.1-20261009163909)

### readline (system)
Version: `8.2-1.3+core2.1~20261009161033` · Published: 2026-10-09 16:11:55 UTC
**Description:** Front-end using readline to "cook" input lines for other programs
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - readline`

**Binary downloads:**
- [lib32readline8_8.2-1.3+core2.1.20261009161033_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/lib32readline8_8.2-1.3%2Bcore2.1.20261009161033_amd64.deb)
- [libreadline8_8.2-1.3+core2.1.20261009161033_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/libreadline8_8.2-1.3%2Bcore2.1.20261009161033_amd64.deb)
- [readline-common_8.2-1.3+core2.1.20261009161033_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/readline-common_8.2-1.3%2Bcore2.1.20261009161033_all.deb)
- [readline-doc_8.2-1.3+core2.1.20261009161033_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/readline-doc_8.2-1.3%2Bcore2.1.20261009161033_all.deb)
- [rlfe_8.2-1.3+core2.1.20261009161033_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-readline-8.2-1.3-core2.1-20261009161033/rlfe_8.2-1.3%2Bcore2.1.20261009161033_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-readline-8.2-1.3-core2.1-20261009161033)

### gawk (system)
Version: `1:5.2.1-2+core2.1~20261009154053` · Published: 2026-10-09 15:42:14 UTC
**Description:** GNU awk, a pattern scanning and processing language
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - gawk`

**Binary downloads:**
- [gawk_5.2.1-2+core2.1.20261009154053_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-gawk-1-5.2.1-2-core2.1-20261009154053/gawk_5.2.1-2%2Bcore2.1.20261009154053_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-gawk-1-5.2.1-2-core2.1-20261009154053)

### tar (system)
Version: `1.34+dfsg-1.2+deb12u1+core2.1~20261009152714` · Published: 2026-10-09 15:31:27 UTC
**Description:** GNU version of the tar archiving utility
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - tar`

**Binary downloads:**
- [tar-scripts_1.34+dfsg-1.2+deb12u1+core2.1.20261009152714_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-tar-1.34-dfsg-1.2-deb12u1-core2.1-20261009152714/tar-scripts_1.34%2Bdfsg-1.2%2Bdeb12u1%2Bcore2.1.20261009152714_amd64.deb)
- [tar_1.34+dfsg-1.2+deb12u1+core2.1.20261009152714_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-tar-1.34-dfsg-1.2-deb12u1-core2.1-20261009152714/tar_1.34%2Bdfsg-1.2%2Bdeb12u1%2Bcore2.1.20261009152714_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-tar-1.34-dfsg-1.2-deb12u1-core2.1-20261009152714)

### pcre2 (system)
Version: `10.42-1+deb12u2+core2.1~20261009152649` · Published: 2026-10-09 15:28:14 UTC
**Description:** New Perl Compatible Regular Expression Library - posix-compatible runtime files
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - pcre2`

**Binary downloads:**
- [libpcre2-16-0_10.42-1+deb12u2+core2.1.20261009152649_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/libpcre2-16-0_10.42-1%2Bdeb12u2%2Bcore2.1.20261009152649_amd64.deb)
- [libpcre2-32-0_10.42-1+deb12u2+core2.1.20261009152649_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/libpcre2-32-0_10.42-1%2Bdeb12u2%2Bcore2.1.20261009152649_amd64.deb)
- [libpcre2-8-0_10.42-1+deb12u2+core2.1.20261009152649_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/libpcre2-8-0_10.42-1%2Bdeb12u2%2Bcore2.1.20261009152649_amd64.deb)
- [libpcre2-posix3_10.42-1+deb12u2+core2.1.20261009152649_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/libpcre2-posix3_10.42-1%2Bdeb12u2%2Bcore2.1.20261009152649_amd64.deb)
- [pcre2-utils_10.42-1+deb12u2+core2.1.20261009152649_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649/pcre2-utils_10.42-1%2Bdeb12u2%2Bcore2.1.20261009152649_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-pcre2-10.42-1-deb12u2-core2.1-20261009152649)

### xorg-server (optimized)
Version: `2:21.1.7-3+deb12u13+core2.1~20261009120435` · Published: 2026-10-09 12:08:59 UTC
**Description:** Xorg X server - core server
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - xorg-server`

**Binary downloads:**
- [xnest_21.1.7-3+deb12u13+core2.1.20261009120435_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xnest_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_amd64.deb)
- [xorg-server-source_21.1.7-3+deb12u13+core2.1.20261009120435_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xorg-server-source_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_all.deb)
- [xserver-common_21.1.7-3+deb12u13+core2.1.20261009120435_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xserver-common_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_all.deb)
- [xserver-xephyr_21.1.7-3+deb12u13+core2.1.20261009120435_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xserver-xephyr_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_amd64.deb)
- [xserver-xorg-core_21.1.7-3+deb12u13+core2.1.20261009120435_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xserver-xorg-core_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_amd64.deb)
- [xserver-xorg-legacy_21.1.7-3+deb12u13+core2.1.20261009120435_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xserver-xorg-legacy_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_amd64.deb)
- [xvfb_21.1.7-3+deb12u13+core2.1.20261009120435_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435/xvfb_21.1.7-3%2Bdeb12u13%2Bcore2.1.20261009120435_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-xorg-server-2-21.1.7-3-deb12u13-core2.1-20261009120435)

### htop (optimized)
Version: `3.2.2-2+core2.1~20261009120215` · Published: 2026-10-09 12:03:09 UTC
**Description:** interactive processes viewer
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - htop`

**Binary downloads:**
- [htop_3.2.2-2+core2.1.20261009120215_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-htop-3.2.2-2-core2.1-20261009120215/htop_3.2.2-2%2Bcore2.1.20261009120215_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-htop-3.2.2-2-core2.1-20261009120215)

### btop (optimized)
Version: `1.2.13-1+core2.1~20261009120005` · Published: 2026-10-09 12:01:31 UTC
**Description:** Modern and colorful command line resource monitor that shows usage and stats
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - btop`

**Binary downloads:**
- [btop_1.2.13-1+core2.1.20261009120005_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-btop-1.2.13-1-core2.1-20261009120005/btop_1.2.13-1%2Bcore2.1.20261009120005_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-btop-1.2.13-1-core2.1-20261009120005)

### rust-ripgrep (optimized)
Version: `13.0.0-4+core2.1~20261009115443` · Published: 2026-10-09 11:58:49 UTC
**Description:** Recursively searches directories for a regex pattern
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - rust-ripgrep`

**Binary downloads:**
- [ripgrep_13.0.0-4+core2.1.20261009115443_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-rust-ripgrep-13.0.0-4-core2.1-20261009115443/ripgrep_13.0.0-4%2Bcore2.1.20261009115443_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-rust-ripgrep-13.0.0-4-core2.1-20261009115443)

### rust-fd-find (optimized)
Version: `8.6.0-3+core2.1~20261009114655` · Published: 2026-10-09 11:50:19 UTC
**Description:** Simple, fast and user-friendly alternative to find
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - rust-fd-find`

**Binary downloads:**
- [fd-find_8.6.0-3+core2.1.20261009114655_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-rust-fd-find-8.6.0-3-core2.1-20261009114655/fd-find_8.6.0-3%2Bcore2.1.20261009114655_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-rust-fd-find-8.6.0-3-core2.1-20261009114655)

### mpd (optimized)
Version: `0.23.12-1+core2.1~20261009114100` · Published: 2026-10-09 11:45:54 UTC
**Description:** Music Player Daemon
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - mpd`

**Binary downloads:**
- [mpd_0.23.12-1+core2.1.20261009114100_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-mpd-0.23.12-1-core2.1-20261009114100/mpd_0.23.12-1%2Bcore2.1.20261009114100_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-mpd-0.23.12-1-core2.1-20261009114100)

### ncmpcpp (optimized)
Version: `0.9.2-2+core2.1~20261009113534` · Published: 2026-10-09 11:39:35 UTC
**Description:** ncurses-based client for the Music Player Daemon (MPD)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - ncmpcpp`

**Binary downloads:**
- [ncmpcpp_0.9.2-2+core2.1.20261009113534_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-ncmpcpp-0.9.2-2-core2.1-20261009113534/ncmpcpp_0.9.2-2%2Bcore2.1.20261009113534_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-ncmpcpp-0.9.2-2-core2.1-20261009113534)

### dash (system)
Version: `0.5.12-2+core2.1~20261009104558` · Published: 2026-10-09 10:46:26 UTC
**Description:** POSIX-compliant shell
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - dash`

**Binary downloads:**
- [ash_0.5.12-2+core2.1.20261009104558_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-dash-0.5.12-2-core2.1-20261009104558/ash_0.5.12-2%2Bcore2.1.20261009104558_all.deb)
- [dash_0.5.12-2+core2.1.20261009104558_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-dash-0.5.12-2-core2.1-20261009104558/dash_0.5.12-2%2Bcore2.1.20261009104558_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-dash-0.5.12-2-core2.1-20261009104558)

### Bash (system)
Version: `5.2.15-2+core2.1~20261009104102` · Published: 2026-10-09 10:45:21 UTC
**Description:** GNU Bourne Again SHell
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - bash`

**Binary downloads:**
- [bash-builtins_5.2.15-2+core2.1.20261009104102_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-bash-5.2.15-2-core2.1-20261009104102/bash-builtins_5.2.15-2%2Bcore2.1.20261009104102_amd64.deb)
- [bash-doc_5.2.15-2+core2.1.20261009104102_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-bash-5.2.15-2-core2.1-20261009104102/bash-doc_5.2.15-2%2Bcore2.1.20261009104102_all.deb)
- [bash-static_5.2.15-2+core2.1.20261009104102_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-bash-5.2.15-2-core2.1-20261009104102/bash-static_5.2.15-2%2Bcore2.1.20261009104102_amd64.deb)
- [bash_5.2.15-2+core2.1.20261009104102_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-bash-5.2.15-2-core2.1-20261009104102/bash_5.2.15-2%2Bcore2.1.20261009104102_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-bash-5.2.15-2-core2.1-20261009104102)

### GNU Core Utilities (system)
Version: `9.1-1+core2.1~20261009103756` · Published: 2026-10-09 10:40:01 UTC
**Description:** GNU core utilities
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - coreutils`

**Binary downloads:**
- [coreutils_9.1-1+core2.1.20261009103756_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-system-coreutils-9.1-1-core2.1-20261009103756/coreutils_9.1-1%2Bcore2.1.20261009103756_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-system-coreutils-9.1-1-core2.1-20261009103756)

### Neovim (optimized)
Version: `0.7.2-7+core2.1~20261009082328` · Published: 2026-10-09 08:30:27 UTC
**Description:** heavily refactored vim fork
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - neovim`

**Binary downloads:**
- [neovim-runtime_0.7.2-7+core2.1.20261009082328_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009082328/neovim-runtime_0.7.2-7%2Bcore2.1.20261009082328_all.deb)
- [neovim_0.7.2-7+core2.1.20261009082328_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-neovim-0.7.2-7-core2.1-20261009082328/neovim_0.7.2-7%2Bcore2.1.20261009082328_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-neovim-0.7.2-7-core2.1-20261009082328)

### zsh (optimized)
Version: `5.9-4+core2.1~20261009061847` · Published: 2026-10-09 06:24:36 UTC
**Description:** shell with lots of features
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - zsh`

**Binary downloads:**
- [zsh-common_5.9-4+core2.1.20261009061847_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zsh-5.9-4-core2.1-20261009061847/zsh-common_5.9-4%2Bcore2.1.20261009061847_all.deb)
- [zsh-doc_5.9-4+core2.1.20261009061847_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zsh-5.9-4-core2.1-20261009061847/zsh-doc_5.9-4%2Bcore2.1.20261009061847_all.deb)
- [zsh-static_5.9-4+core2.1.20261009061847_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zsh-5.9-4-core2.1-20261009061847/zsh-static_5.9-4%2Bcore2.1.20261009061847_amd64.deb)
- [zsh_5.9-4+core2.1.20261009061847_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-zsh-5.9-4-core2.1-20261009061847/zsh_5.9-4%2Bcore2.1.20261009061847_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-zsh-5.9-4-core2.1-20261009061847)

### LAME (optimized)
Version: `3.100-6+core2.1~20261009061017` · Published: 2026-10-09 06:11:33 UTC
**Description:** MP3 encoding library (frontend)
Install/update latest: `curl -fsSL https://raw.githubusercontent.com/AmrUser-48/linux/master/core2-packages/install.py | python3 - lame`

**Binary downloads:**
- [lame-doc_3.100-6+core2.1.20261009061017_all.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lame-3.100-6-core2.1-20261009061017/lame-doc_3.100-6%2Bcore2.1.20261009061017_all.deb)
- [lame_3.100-6+core2.1.20261009061017_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lame-3.100-6-core2.1-20261009061017/lame_3.100-6%2Bcore2.1.20261009061017_amd64.deb)
- [libmp3lame0_3.100-6+core2.1.20261009061017_amd64.deb](https://github.com/AmrUser-48/linux/releases/download/core2-lame-3.100-6-core2.1-20261009061017/libmp3lame0_3.100-6%2Bcore2.1.20261009061017_amd64.deb)
**Details and historical versions:** [release page](https://github.com/AmrUser-48/linux/releases/tag/core2-lame-3.100-6-core2.1-20261009061017)
<!-- CORE2-PACKAGE-RELEASE-INDEX:END -->

</details>

## Start a build

In GitHub, open **Actions → Core 2 optimized Debian package train → Run workflow**. Select a series. To refresh all release links in this README manually, use [**Refresh Core 2 package release index → Run workflow**](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-update-release-index.yml); the index also refreshes automatically when a release is published:

- all: the existing package train, then Python, FFTW, MPD/client utilities, Rust command-line tools, process monitors and the X.Org server.
- shell-editors: Bash, Zsh, Nano and Neovim.
- media: LAME, zstd, xz-utils, 7-Zip, FFmpeg, mpv and curl.
- graphics: Mesa only.
- new-tools: Python 3.11, FFTW, ncmpcpp, MPD, fd-find, sd, ripgrep, btop, htop and X.Org server.

The train is sequential (one package build at a time). Before dispatching each package, it checks for a matching `core2-<source-package>-*` release containing a .deb and skips it when one already exists. Failures collect the actual GitHub Actions failure log and the train continues to the next package. The final summary lists published, skipped and failed packages. After fixing a failed package, rerun the series: releases already published by the previous pass will be skipped. To build one package directly, start **Core 2 optimized Debian package** and select its Debian source package name.

## Build policy

The workflows fetch official Debian Bookworm and Bookworm-security source packages, retain Debian's packaging and patches, and append a unique +core2.1~timestamp revision so each rebuild can upgrade the previous custom package. Compilation and tests run as an unprivileged build user (with fakeroot only for package steps that need it), so filesystem permission tests do not accidentally pass or fail because CI runs as root. The default profile is `-O2 -march=core2 -mtune=core2`; LAME, FFTW, FFmpeg, mpv, 7-Zip, zstd and xz-utils use `-O3 -march=core2 -mtune=core2`. Rust targets (`rust-fd-find`, `rust-sd`, `rust-ripgrep`) use a compiler wrapper to add `-C target-cpu=core2` while retaining Debian's Cargo/linker flags. Debian's package-specific hardening flags are retained. The build verifies the Core 2 C/C++ flags and checks the Rust wrapper for Rust targets. Binary package selection excludes explicit `*-dev` and `*-dbg` stanzas, and `noautodbgsym` disables automatic debug-symbol packages. The workflow fails if any `-dev`, `-dbg`, or `-dbgsym` package appears in the output. Releases contain normal installable packages, the Debian source descriptor and matching source archives, build metadata, and checksums covering the uploaded binary/source files.

The artifacts target Intel Core 2-class systems (such as the D630 CPUs) and are not intended as generic amd64 replacements. They use Debian's standard ABI, but compiler-generated instructions can require Core 2 or a later CPU. Keep the stock Debian packages available for rollback.

The new-tools train uses Debian source package names where they differ from the binary packages or commands users want: `glibc` (in the system-package workflow) produces `libc6`; `fftw3` builds FFTW and produces runtime libraries including `libfftw3-double3`; `rust-fd-find` provides `fd` as Debian's `fdfind`; `rust-ripgrep` produces `rg` as `ripgrep`; `rust-sd` produces `sd`; and `xorg-server` is the code-bearing X.Org server source (the `xorg` package is only a metapackage). The package builder lets Debian's packaging rules run normally, then excludes `*-dev`, `*-dbg`, and `*-dbgsym` artifacts from publication. Python and X.Org produce several binary packages; only dev/debug packages are filtered, so review the release asset list before installation.

Mesa is the highest-risk target because it supplies graphics libraries and driver modules used by the desktop. Its release can contain multiple runtime and architecture-specific .deb packages; `-dev`, `-dbg`, and `-dbgsym` packages are excluded. Inspect the remaining package list, install only the related runtime packages required by this machine, keep a known-working kernel/Mesa combination as fallback, and test the GMA X3100 driver locally. CI compilation alone does not prove hardware rendering works.


## Core system packages (manual, higher risk)

For Debian core utilities, libraries and boot/runtime components, open [**Core 2 optimized Debian system package**](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-package.yml) and choose one source package per run. The menu includes:

- Runtime and toolchain foundations: `glibc` (produces packages including `libc6` and `libc-bin`), `gcc-12`, `binutils`, `dpkg`, `apt`.
- Init, shell and system tools: `systemd`, `bash`, `dash`, `coreutils`, `util-linux`, `iproute2`, `kmod`, `procps`, `e2fsprogs`, `psmisc`, `shadow`, `pam`.
- Core libraries and compression: `openssl`, `zlib`, `libxcrypt`, `ncurses`, `readline`, `libcap2`, `libselinux`, `libseccomp`, `acl`, `attr`, `pcre2`, `gmp`, `mpfr4`, `libffi`, `expat`, `libtirpc`.
- Basic text/file utilities: `findutils`, `grep`, `sed`, `gawk`, `diffutils`, `tar`, `gzip`, `bzip2`, `xz-utils`, `zstd`.

This workflow uses the conservative `-O2 -march=core2 -mtune=core2` profile for all listed packages. GCC and glibc builds are particularly large and may run for hours; the workflow timeout is six hours. Each successful build publishes its normal installable binary packages, build metadata and SHA-256 sums in a separate `core2-system-*` GitHub Release. Explicit `*-dev` and `*-dbg` package stanzas are excluded during debhelper processing, automatic `*-dbgsym` generation is disabled, and a validation guard stops release if any such package remains. Compilation is not the same as runtime validation.

**Critical warning:** do not install every generated `.deb` blindly. A glibc build may publish multiple runtime, locale and multiarch packages, even though development and debug packages are excluded. Inspect the asset list and dependencies first. Replacing `libc6` or `systemd` can make the installed system unusable; do this only with a verified backup, known-good kernel, and a tested rescue/rollback path. Keep the stock Debian packages and recovery media available. These builds target the D630 / Intel Core 2 system, not generic amd64 computers.



### Recover a failed release without rebuilding

If the compile/package job succeeded but release publishing failed, its workflow artifact may still be available for seven days. Use [**Recover Core 2 package release**](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-recover-release.yml), leave the default values for the Mesa run (`apps`, `mesa`, run ID `37892602737`), and run it. The workflow downloads the saved artifact, verifies its SHA-256 sums, and publishes the release without recompiling. Change the package kind and run ID to recover another app/system artifact.

### Run the system package train

Use [**Core 2 optimized Debian system package train**](https://github.com/AmrUser-48/linux/actions/workflows/d630-core2-system-packages-series.yml) to build batches or all 43 allowlisted system packages. The train reuses the single-package builder, publishes a separate release for each successful package, and runs at most **two package builds concurrently**. It does not stop all remaining builds just because one package fails; inspect the run summary and individual package jobs for failures.

Select `all` for the complete set, or a narrower group: `core-foundation`, `toolchain`, `runtime-libraries`, `system-utilities`, or `text-compression`. GCC and glibc can be long builds; the overall train can take many hours, while each individual package build has its own six-hour timeout. The single-package workflow remains available when you want to retry one failed target.

## Brave Browser

Brave is intentionally not in the normal Debian-source train. It is not a standard Bookworm source-package rebuild; Brave's Linux build uses a Chromium-sized checkout. Upstream's current instructions recommend more than 16 GB RAM and expect about 100 GB of free disk for Chromium. That does not fit the standard GitHub-hosted runner reliably. Treat Brave as a separate project requiring a larger or self-hosted runner, and test it as a separate browser install rather than replacing the held vendor package automatically.
