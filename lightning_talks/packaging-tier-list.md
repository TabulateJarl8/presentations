---
marp: true
theme: default
class: invert
---

# Linux Packaging Tier List

Connor Sample - <https://tabulate.tech>

<style>
/* General Table Styles */
.tier-list {
  width: 100%;
  border-collapse: collapse;
  margin: 20px 0;
}

.tier-list td {
  padding: 15px;
  text-align: left;
  border: 1px solid grey;
}

/* Highlighted Tier Cells */
.tier-list tr.s-tier td:first-child {
  background-color: #FF7E7B; /* S Tier */
  color: black;
  font-weight: bold;
}

.tier-list tr.a-tier td:first-child {
  background-color: #FEBE7D; /* A Tier */
  color: black;
  font-weight: bold;
}

.tier-list tr.b-tier td:first-child {
  background-color: #FDFE7C; /* B Tier */
  color: black;
  font-weight: bold;
}

.tier-list tr.c-tier td:first-child {
  background-color: #7EFF7C; /* C Tier */
  color: black;
  font-weight: bold;
}

.tier-list tr.d-tier td:first-child {
  background-color: #7EFEFE; /* D Tier */
  color: black;
  font-weight: bold;
}

.tier-list tr.f-tier td:first-child {
  background-color: #FE7EFE; /* F Tier */
  color: black;
  font-weight: bold;
}
</style>

---

## This is about building the packages, not using them.

- Ease of Learning
- Complexity of build system
- CI/CD Automation

---

## Deb

- Way too many files
- Not intuitive at all
  - 9 chapter manual
- Lot of different things can be done at installation (maybe good maybe bad)

---

### `rules`

```make
#!/usr/bin/make -f
%:
	dh $@

override_dh_auto_build:
	@cargo --version >/dev/null 2>&1 || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

	cat $$HOME/.cargo/env

	python3 -m pip install scikit-build
	PIP_ONLY_BINARY=cmake python3 -m pip install cmake

	PATH="$$PATH:$$HOME/.cargo/bin" make build

override_dh_auto_test:
	PATH="$$PATH:$$HOME/.cargo/bin" dh_auto_test

override_dh_auto_install:
	PATH="$$PATH:$$HOME/.cargo/bin" dh_auto_install -- BINARY_PATH=target/release/squiid ELEVATE='' EXECUTABLE_PERMISSION='' NORMAL_PERMISSION=''
```

---

### `changelog`

```
squiid (0.1.0-1-0ubuntu1~bionicppa1) bionic; urgency=medium

  * Initial release

 -- Connor Sample <something@nothing.com>  Sun, 30 Apr 2023 17:27:06 -0400
```

---

### `control`

```
Source: squiid
Section: math
Priority: optional
Maintainer: Connor Sample <something@nothing.com>
Build-Depends: debhelper-compat (= 11), python3-pip, curl
Standards-Version: 4.6.0
Homepage: https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid
Rules-Requires-Root: no

Package: squiid
Architecture: any
Depends: ${shlibs:Depends}, ${misc:Depends}
Description: Do advanced algebraic and RPN calculations.
 Advanced calculator written in Rust, featuring a terminal user interface supporting both RPN and algebraic input.
```

---

### `copyright`

```
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: squiid
Upstream-Contact: Connor Sample <something@nothing.com>
Source: https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid

Files: *
...
```

### `source/format`

```
3.0 (quilt)
```

### `docs`

```
README.md
```

---

## Building

```bash
dpkg-buildpackage -b -d -us -uc $(DEBUILD_OPTIONS)
```

---

<table class="tier-list">
  <tbody>
    <tr class="s-tier">
      <td>S</td>
    </tr>
    <tr class="a-tier">
      <td>A</td>
    </tr>
    <tr class="b-tier">
      <td>B</td>
    </tr>
    <tr class="c-tier">
      <td>C</td>
    </tr>
    <tr class="d-tier">
      <td>D</td>
      <td>deb</td>
    </tr>
    <tr class="f-tier">
      <td>F</td>
    </tr>
  </tbody>
</table>

---

## PPA?

- Good luck if you need up to date build tools
- Launchpad is terrible to submit to

---

<table class="tier-list">
  <tbody>
    <tr class="s-tier">
      <td>S</td>
    </tr>
    <tr class="a-tier">
      <td>A</td>
    </tr>
    <tr class="b-tier">
      <td>B</td>
    </tr>
    <tr class="c-tier">
      <td>C</td>
    </tr>
    <tr class="d-tier">
      <td>D</td>
      <td>deb</td>
    </tr>
    <tr class="f-tier">
      <td>F</td>
      <td>PPA</td>
    </tr>
  </tbody>
</table>

---

## RPM

- Easier than deb
- Sometimes finicky
- Bad documentation
- Weird build folder structure
- Wants dependencies to be packaged in the repos, and even they even are, they're outdated a lot of the time

---

### `squiid.spec`

```bash
Name:     squiid
Version:  ${VERSION}
Release:  %autorelease
Summary:  Do advanced algebraic and RPN calculations.
License:  GPL-3.0
URL:      https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid
Source:   https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid/-/archive/%{version}/squiid-%{version}.tar.gz
BuildRequires:   make
BuildRequires:   rust

%description
Squiid is a modular calculator written in Rust. It is currently very early in
development but it is intended to be the successor to
ImaginaryInfinity Calculator

%prep
%autosetup

%build
%configure
%make_build

%install
%make_install

%files
%{_bindir}/squiid
%license LICENSE

%changelog
%autochangelog
```

---

## Building

```bash
rpmbuild -ba SPECS/squiid.spec
```

---

<table class="tier-list">
  <tbody>
    <tr class="s-tier">
      <td>S</td>
    </tr>
    <tr class="a-tier">
      <td>A</td>
    </tr>
    <tr class="b-tier">
      <td>B</td>
    </tr>
    <tr class="c-tier">
      <td>C</td>
      <td>RPM</td>
    </tr>
    <tr class="d-tier">
      <td>D</td>
      <td>deb</td>
    </tr>
    <tr class="f-tier">
      <td>F</td>
      <td>PPA</td>
    </tr>
  </tbody>
</table>

---

## `PKGBUILD` (Arch)

- Very concise (just a bash script)
- Great documentation

---

### `PKGBUILD`

```bash
# Maintainer: Connor Sample <someone at nothing.com>
pkgname=squiid
pkgver=1.3.0
pkgrel=1
pkgdesc="Advanced calculator written in Rust, featuring a terminal user interface supporting both RPN and algebraic input."
arch=('any')
url="https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid"
license=('GPLv3')
makedepends=('cargo')
source=("https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid/-/archive/$pkgver/$pkgname-$pkgver.tar.gz")
sha512sums=('1849aa9f609e4bfcafb5dee24962cbefe91ce3987cf8ea5014b8ca9789d16747ff44d7428f61693102808227bfdb12dc840fee44917d5fdde26f6b2c7e65a96b')
options=(strip !debug)

prepare() {
	cd "$pkgname-$pkgver"
	export RUSTUP_TOOLCHAIN=stable
	cargo fetch --locked --target "$CARCH-unknown-linux-gnu"
}

build() {
	cd "$pkgname-$pkgver"
	export RUSTUP_TOOLCHAIN=stable
	export CARGO_TARGET_DIR=target
	cargo build --frozen --release
}

check() {
	cd "$pkgname-$pkgver"
	export RUSTUP_TOOLCHAIN=stable
	cargo test --frozen -p squiid -p squiid-engine -p squiid-parser
}

package() {
	cd "$pkgname-$pkgver"
	install -Dm755 "target/release/$pkgname" "$pkgdir/usr/bin/$pkgname"
	install -Dm644 "branding/squiidsquare.svg" "$pkgdir/usr/share/icons/hicolor/scalable/apps/squiid.svg"
	install -Dm644 "branding/icons/squiid512.png" "$pkgdir/usr/share/icons/hicolor/512x512/apps/squiid.png"
	install -Dm644 "branding/icons/squiid256.png" "$pkgdir/usr/share/icons/hicolor/256x256/apps/squiid.png"
	install -Dm644 "branding/icons/squiid128.png" "$pkgdir/usr/share/icons/hicolor/128x128/apps/squiid.png"
	install -Dm644 "branding/icons/squiid64.png" "$pkgdir/usr/share/icons/hicolor/64x64/apps/squiid.png"
	install -Dm644 "branding/icons/squiid32.png" "$pkgdir/usr/share/icons/hicolor/32x32/apps/squiid.png"
	install -Dm644 "branding/icons/squiid16.png" "$pkgdir/usr/share/icons/hicolor/16x16/apps/squiid.png"
	install -Dm644 "packages/squiid.desktop" "$pkgdir/usr/share/applications/squiid.desktop"
}
```

---

## Building

```bash
makepkg -s
```

---

<table class="tier-list">
  <tbody>
    <tr class="s-tier">
      <td>S</td>
      <td>PKGBUILD</td>
    </tr>
    <tr class="a-tier">
      <td>A</td>
    </tr>
    <tr class="b-tier">
      <td>B</td>
    </tr>
    <tr class="c-tier">
      <td>C</td>
      <td>RPM</td>
    </tr>
    <tr class="d-tier">
      <td>D</td>
      <td>deb</td>
    </tr>
    <tr class="f-tier">
      <td>F</td>
      <td>PPA</td>
    </tr>
  </tbody>
</table>

---

## XBPS

- Very simple and pleasant to work with
- Pretty good documentation
- Helper scripts like `vbin`, `vlicense`, `vdoc` to move your files automatically

---

### `template`

```bash
# Template file for 'squiid'
pkgname=squiid
version=1.3.0
revision=1
build_style=cargo
short_desc="Advanced algebraic and RPN calculator"
maintainer="Connor Sample <tabulatejarl8@gmail.com>"
license="GPL-3.0-only"
homepage="https://imaginaryinfinity.net/squiid"
distfiles="https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid/-/archive/$version/$pkgname-$version.tar.gz"
checksum="1849aa9f609e4bfcafb5dee24962cbefe91ce3987cf8ea5014b8ca9789d16747ff44d7428f61693102808227bfdb12dc840fee44917d5fdde26f6b2c7e65a96b"

do_check() {
	export RUSTUP_TOOLCHAIN=stable
	cargo test --frozen -p squiid -p squiid-engine -p squiid-parser
}

do_install() {
	vbin target/$RUST_TARGET/release/$pkgname

	vinstall branding/squiidsquare.svg 644 usr/share/icons/hicolor/scalable/apps squiid.svg
	vinstall branding/icons/squiid512.png 644 usr/share/icons/hicolor/512x512/apps squiid.png
	vinstall branding/icons/squiid256.png 644 usr/share/icons/hicolor/256x256/apps squiid.png
	vinstall branding/icons/squiid128.png 644 usr/share/icons/hicolor/128x128/apps squiid.png
	vinstall branding/icons/squiid64.png 644 usr/share/icons/hicolor/64x64/apps squiid.png
	vinstall branding/icons/squiid32.png 644 usr/share/icons/hicolor/32x32/apps squiid.png
	vinstall branding/icons/squiid16.png 644 usr/share/icons/hicolor/16x16/apps squiid.png

	vinstall packages/squiid.desktop 644 usr/share/applications
}
```

---

## Building

```bash
./xbps-src pkg squiid
```

---

<table class="tier-list">
  <tbody>
    <tr class="s-tier">
      <td>S</td>
      <td>PKGBUILD</td>
      <td>XBPS</td>
    </tr>
    <tr class="a-tier">
      <td>A</td>
    </tr>
    <tr class="b-tier">
      <td>B</td>
    </tr>
    <tr class="c-tier">
      <td>C</td>
      <td>RPM</td>
    </tr>
    <tr class="d-tier">
      <td>D</td>
      <td>deb</td>
    </tr>
    <tr class="f-tier">
      <td>F</td>
      <td>PPA</td>
    </tr>
  </tbody>
</table>

---

## Homebrew

- Decently easy
- Maintainer community is very nice
- QOL things like automatic extraction of version
- Some odd build practices like forcing unit tests for a TUI app
- Written in Ruby

---

### `squiid.rb`

```rb
class Squiid < Formula
  desc "Do advanced algebraic and RPN calculations"
  homepage "https://imaginaryinfinity.net/projects/squiid/"
  url "https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid/-/archive/1.3.0/squiid-1.3.0.tar.gz"
  sha256 "1849aa9f609e4bfcafb5dee24962cbefe91ce3987cf8ea5014b8ca9789d16747ff44d7428f61693102808227bfdb12dc840fee44917d5fdde26f6b2c7e65a96b"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # squiid is a TUI app
    assert_match version.to_s, shell_output("#{bin}/squiid --version")
  end
end
```

---

## Building

```bash
brew install --build-from-source squiid
brew audit --strict --new --online squiid
```

---

<table class="tier-list">
  <tbody>
    <tr class="s-tier">
      <td>S</td>
      <td>PKGBUILD</td>
      <td>XBPS</td>
    </tr>
    <tr class="a-tier">
      <td>A</td>
      <td>Homebrew</td>
    </tr>
    <tr class="b-tier">
      <td>B</td>
    </tr>
    <tr class="c-tier">
      <td>C</td>
      <td>RPM</td>
    </tr>
    <tr class="d-tier">
      <td>D</td>
      <td>deb</td>
    </tr>
    <tr class="f-tier">
      <td>F</td>
      <td>PPA</td>
    </tr>
  </tbody>
</table>

---

## AppImage

- Not fun to write
- Manual setup of build directory
- Everything must be containerized manually

---

### `AppRun`

```bash
#!/bin/sh

# Just run directly if run from terminal
if [ -t 0 ]; then
  "$APPDIR/usr/bin/squiid"
# Open terminal if run without terminal
else
  KITTY_CONFIG_DIRECTORY=$APPDIR KITTY_DISABLE_WAYLAND=1 $APPDIR/usr/bin/kitty --title "Squiid Calculator" -e "$APPDIR/usr/bin/squiid"
fi
```

---

```
squiid.AppDir/
├── AppRun
├── kitty.app.png
├── kitty.conf
├── squiid.desktop
├── squiid.png
└── usr
    ├── bin
    │   ├── kitty
    │   └── squiid
    ├── lib
    │   ├── cacert.pem
    │   ├── kitty
    │   │   ├── fonts
    │   │   │   └── SymbolsNerdFontMono-Regular.ttf
    │   │   ├── logo
    │   │   │   ├── beam-cursor@2x.png
    │   │   │   ├── beam-cursor.png
    │   │   │   ├── kitty-128.png
    │   │   │   └── kitty.png
    │   │   ├── shell-integration
    │   │   │   ├── bash
    │   │   │   │   └── ...
    │   │   │   ├── fish
    │   │   │   │   └── ...
    │   │   │   ├── ssh
    │   │   │   │   ├── bootstrap.py
    │   │   │   │   ├── ...
    │   │   │   │   └── kitty
    │   │   │   └── zsh
    │   │   │       └── ...
    │   │   └── terminfo
    │   │       ├── kitty.termcap
    │   │       ├── kitty.terminfo
    │   │       └── x
    │   │           └── xterm-kitty
    │   ├── kitty-extensions
    │   │   ├── array.so
    │   │   ├── ...
    │   │   └── _zoneinfo.so
    │   ├── libbrotlicommon.so.1
    │   ├── ...
    │   └── libz.so.1
    └── share
        └── terminfo
            └── x
                └── xterm-kitty
```

---

## Building

```bash
appimagetool squiid.AppDir/ Squiid_Calculator.AppImage
```

---

<table class="tier-list">
  <tbody>
    <tr class="s-tier">
      <td>S</td>
      <td>PKGBUILD</td>
      <td>XBPS</td>
    </tr>
    <tr class="a-tier">
      <td>A</td>
      <td>Homebrew</td>
    </tr>
    <tr class="b-tier">
      <td>B</td>
      <td>AppImage</td>
    </tr>
    <tr class="c-tier">
      <td>C</td>
      <td>RPM</td>
    </tr>
    <tr class="d-tier">
      <td>D</td>
      <td>deb</td>
    </tr>
    <tr class="f-tier">
      <td>F</td>
      <td>PPA</td>
    </tr>
  </tbody>
</table>

---

## Flatpak

- Strange (but reproducible) way of specifying dependencies
- Terrible branding guidelines (flathub)
- Documentation is ok
- Complain if your app doesn't need any permissions (flathub)
- Config is done in JSON
- Weird cross-compiling issues (`ln -sf` on next slide)

---

### `net.imaginaryinfinity.Squiid.json`

```json
{
  "app-id": "net.imaginaryinfinity.Squiid",
  "runtime": "org.freedesktop.Platform",
  "runtime-version": "24.08",
  "sdk": "org.freedesktop.Sdk",
  "sdk-extensions": ["org.freedesktop.Sdk.Extension.rust-stable"],
  "command": "squiid",
  "finish-args": [],
  "build-options": {
    "append-path": "/usr/lib/sdk/rust-stable/bin"
  },
  "modules": [
    {
      "name": "squiid",
      "buildsystem": "simple",
      "build-options": {
        "env": {
          "CARGO_HOME": "/run/build/squiid/cargo"
        }
      },
      "build-commands": [
        "mkdir -p /app/bin",
        "ln -sf /usr/bin/gcc /app/bin/aarch64-linux-gnu-gcc",
        "cargo --offline fetch --manifest-path Cargo.toml --verbose",
        "cargo --offline build --release --verbose",
        "install -Dm755 ./target/release/squiid -t /app/bin/",
        "install -Dm644 ./branding/squiidsquare.svg /app/share/icons/hicolor/scalable/apps/net.imaginaryinfinity.Squiid.svg",
        "install -Dm644 ./branding/icons/squiid512.png /app/share/icons/hicolor/512x512/apps/net.imaginaryinfinity.Squiid.png",
        "install -Dm644 ./branding/icons/squiid256.png /app/share/icons/hicolor/256x256/apps/net.imaginaryinfinity.Squiid.png",
        "install -Dm644 ./branding/icons/squiid128.png /app/share/icons/hicolor/128x128/apps/net.imaginaryinfinity.Squiid.png",
        "install -Dm644 ./branding/icons/squiid64.png /app/share/icons/hicolor/64x64/apps/net.imaginaryinfinity.Squiid.png",
        "install -Dm644 ./branding/icons/squiid32.png /app/share/icons/hicolor/32x32/apps/net.imaginaryinfinity.Squiid.png",
        "install -Dm644 ./branding/icons/squiid16.png /app/share/icons/hicolor/16x16/apps/net.imaginaryinfinity.Squiid.png",
        "install -Dm644 ./packages/flatpak/net.imaginaryinfinity.Squiid.metainfo.xml /app/share/metainfo/net.imaginaryinfinity.Squiid.metainfo.xml",
        "install -Dm644 ./packages/flatpak/net.imaginaryinfinity.Squiid.desktop /app/share/applications/net.imaginaryinfinity.Squiid.desktop"
      ],
      "sources": [
        {
          "type": "archive",
          "url": "https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid/-/archive/1.3.0/squiid-1.3.0.tar.gz",
          "sha256": "8ba7148325d74e51df0ec6fee72175cae869b567566771593613482e585b82c959dea704127b48b71c441956123da2ecdc1616f533625baed06d29680d27f086"
        },
        "generated-sources.json"
      ]
    }
  ]
}
```

---

### `net.imaginaryinfinity.Squiid.metainfo.xml`

```xml
<?xml version='1.0' encoding='utf-8'?>
<component type="console-application">
  <id>net.imaginaryinfinity.Squiid</id>
  <name>Squiid</name>
  <developer id="net.imaginaryinfinity">
    <name>ImaginaryInfinity</name>
  </developer>
  <summary>Advanced algebraic &amp; RPN calculator</summary>
  <url type="homepage">https://imaginaryinfinity.net/projects/squiid/</url>
  <url type="contribute">https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid</url>
  <url type="bugtracker">https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid/-/issues</url>
  <url type="help">https://imaginaryinfinity.net/docs/squiid</url>
  <content_rating type="oars-1.0" />
  <branding>
    <color type="primary" scheme_preference="light">#268bd2</color>
    <color type="primary" scheme_preference="dark">#134263</color>
  </branding>
  <icon type="stock">net.imaginaryinfinity.Squiid</icon>
  <screenshots>
    <screenshot type="default">
      <caption>Algebraic Mode</caption>
      <image type="source" width="1960" height="1120">https://imaginaryinfinity.net/img/showcase/squiid-1.png</image>
    </screenshot>
    ...
  </screenshots>
  <releases>
    <release version="1.3.0" date="2025-03-11">
      <url>https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid/-/releases/1.3.0</url>
    </release>
    <release version="1.2.2" date="2025-02-07">
      <url>https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid/-/releases/1.2.2</url>
    </release>
    ...
  </releases>
  <metadata_license>MIT</metadata_license>
  <project_license>GPL-3.0-or-later</project_license>
  <description>
    <p>
      Advanced calculator written in Rust, featuring a terminal user interface supporting both RPN and algebraic input.
    </p>
  </description>
  <categories>
    <category>Utility</category>
    <category>Calculator</category>
  </categories>
  <launchable type="desktop-id">net.imaginaryinfinity.Squiid.desktop</launchable>
  <provides>
    <binary>squiid</binary>
  </provides>
</component>
```

---

## Building

```bash
python3 flatpak-cargo-generator.py ./Cargo.lock -o generated-sources.json
flatpak-builder --install --user build-dir/ net.imaginaryinfinity.Squiid.json
```

---

<table class="tier-list">
  <tbody>
    <tr class="s-tier">
      <td>S</td>
      <td>PKGBUILD</td>
      <td>XBPS</td>
    </tr>
    <tr class="a-tier">
      <td>A</td>
      <td>Homebrew</td>
    </tr>
    <tr class="b-tier">
      <td>B</td>
      <td>Flatpak</td>
      <td>AppImage</td>
    </tr>
    <tr class="c-tier">
      <td>C</td>
      <td>RPM</td>
    </tr>
    <tr class="d-tier">
      <td>D</td>
      <td>deb</td>
    </tr>
    <tr class="f-tier">
      <td>F</td>
      <td>PPA</td>
    </tr>
  </tbody>
</table>

---

## Snap

- Incredible simple package configuration
- Absolutely terrible to build in CI (-1 tier)
- Weird issues when upgrading to `core22`

---

### `snapcraft.yml`

```yaml
name: squiid
version: "1.3.0"
summary: Do advanced algebraic and RPN calculations.
description: |
  Advanced calculator written in Rust, featuring a terminal user interface
  supporting both RPN and algebraic input.
website: https://imaginaryinfinity.net
contact: something@nothing.com

license: GPL-3.0

grade: stable
base: core20
confinement: strict

parts:
  squiid:
    plugin: rust
    source: .

apps:
  squiid:
    command: bin/squiid
```

---

## Building

```bash
snapcraft
```

---

<table class="tier-list">
  <tbody>
    <tr class="s-tier">
      <td>S</td>
      <td>PKGBUILD</td>
      <td>XBPS</td>
    </tr>
    <tr class="a-tier">
      <td>A</td>
      <td>Homebrew</td>
      <td>Snap</td>
    </tr>
    <tr class="b-tier">
      <td>B</td>
      <td>Flatpak</td>
      <td>AppImage</td>
    </tr>
    <tr class="c-tier">
      <td>C</td>
      <td>RPM</td>
    </tr>
    <tr class="d-tier">
      <td>D</td>
      <td>deb</td>
    </tr>
    <tr class="f-tier">
      <td>F</td>
      <td>PPA</td>
    </tr>
  </tbody>
</table>

---

## Bonus: Winget

- 3 redundant yaml files
- Automatic creation tool

---

### `ImaginaryInfinity.Squiid.installer.yaml`

```yaml
PackageIdentifier: ImaginaryInfinity.Squiid
PackageVersion: 1.3.0
InstallerType: inno
InstallerSwitches:
  Custom: /ALLUSERS
Installers:
  - Architecture: x64
    InstallerUrl: https://gitlab.com/ImaginaryInfinity/squiid-calculator/squiid/-/jobs/9382300888/artifacts/raw/squiid-installer.exe
    InstallerSha256: c5fd3a5d38cc396fb6d776835ed4bb31e0ff488afa6379e1065e6f327e66e4b9
ManifestType: installer
ManifestVersion: 1.9.0
```

---

### `ImaginaryInfinity.Squiid.locale.en-US.yaml`

```yaml
PackageIdentifier: ImaginaryInfinity.Squiid
PackageVersion: 1.3.0
PackageLocale: en-US
Publisher: ImaginaryInfinity
PackageName: Squiid
PackageUrl: https://imaginaryinfinity.net/projects/squiid/
License: GPLv3
ShortDescription: Do advanced algebraic and RPN calculations.
ManifestType: defaultLocale
ManifestVersion: 1.9.0
Description: Advanced calculator written in Rust, featuring a terminal user interface supporting both RPN and algebraic input.
```

---

### `ImaginaryInfinity.Squiid.yaml`

```yaml
PackageIdentifier: ImaginaryInfinity.Squiid
PackageVersion: 1.3.0
DefaultLocale: en-US
ManifestType: version
ManifestVersion: 1.9.0
```

---

## Building

```bash
winget install --manifest <path>
```

---

<table class="tier-list">
  <tbody>
    <tr class="s-tier">
      <td>S</td>
      <td>PKGBUILD</td>
      <td>XBPS</td>
    </tr>
    <tr class="a-tier">
      <td>A</td>
      <td>Homebrew</td>
      <td>Snap</td>
    </tr>
    <tr class="b-tier">
      <td>B</td>
      <td>Flatpak</td>
      <td>AppImage</td>
      <td>Winget</td>
    </tr>
    <tr class="c-tier">
      <td>C</td>
      <td>RPM</td>
    </tr>
    <tr class="d-tier">
      <td>D</td>
      <td>deb</td>
    </tr>
    <tr class="f-tier">
      <td>F</td>
      <td>PPA</td>
    </tr>
  </tbody>
</table>
