# 7z-build-nsis
7-Zip build scripts with NSIS script decompilation for Windows and Linux.

This build can unpack nsis script, eg. `[NSIS].nsi` or `[LICENSE].txt` from nsis installer.
This feature is disable in official versions since `15.05`,
after which official versions are only able to unpack files from installer.

On Windows, only executables depending on `7z.dll` can unpack NSIS packages.
On Linux, use the full `7zz` binary built by this project. Reduced variants such
as `7za` and `7zr` do not include the NSIS archive handler.

## Badges
[![Build status](https://ci.appveyor.com/api/projects/status/6uusps0bn00akik9?svg=true)](https://ci.appveyor.com/project/myfreeer/7z-build-nsis)
[![Linux build](https://github.com/myfreeer/7z-build-nsis/actions/workflows/linux.yml/badge.svg)](https://github.com/myfreeer/7z-build-nsis/actions/workflows/linux.yml)
[![Downloads](https://img.shields.io/github/downloads/myfreeer/7z-build-nsis/total.svg)](https://github.com/myfreeer/7z-build-nsis/releases)
[![Latest Release](https://img.shields.io/github/downloads/myfreeer/7z-build-nsis/latest/total.svg)](https://github.com/myfreeer/7z-build-nsis/releases/latest)
[![Latest Release](https://img.shields.io/github/release/myfreeer/7z-build-nsis.svg)](https://github.com/myfreeer/7z-build-nsis/releases/latest)
[![GitHub license](https://img.shields.io/github/license/myfreeer/7z-build-nsis.svg)](LICENSE) 

## Linux

Install a C/C++ toolchain, GNU Make, `tar`, `curl` or `wget`, and either `7zz`
or `7z` to extract the upstream source archive. On Debian and Ubuntu:

```sh
sudo apt-get install build-essential p7zip-full curl
```

Build the native full-featured command-line executable:

```sh
./7-zip-build.sh
```

The executable and a release archive are written to `dist/`. A convenient copy
is available as `dist/7zz`; versioned outputs include, for example,
`dist/7z2603-linux-x86_64/7zz` and `dist/7z2603-linux-x86_64.tar.gz`.
The build is native, so the architecture in the output name follows `uname -m`.

The most useful optional environment variables are:

- `JOBS`: number of parallel compiler jobs.
- `SEVENZIP_VERSION`: upstream archive version, such as `7z2603`.
- `SEVENZIP_SOURCE_DIR`: build an already extracted, offline source tree.
- `BUILD_DIR` and `DIST_DIR`: override the intermediate and output directories.
- `CC` and `CXX`: select another C/C++ compiler, such as Clang.

To run the end-to-end decompilation test, install `nsis` and use:

```sh
./tests/smoke-test-linux.sh
```

To decompile an installer directly:

```sh
./dist/7zz x installer.exe '[NSIS].nsi' '[LICENSE].txt'
```

## Windows

### Prerequisites

- Visual Studio 2015, 2017, 2019, or 2022.
- `7z.exe` in `PATH` or the current folder.
- Internet access through PowerShell `Net.WebClient`.

### Usage

Clone this repository and run `7-zip-build.bat` in a Visual Studio Developer
Command Prompt.

## Credits
* <https://www.7-zip.org>
* <https://github.com/Chuyu-Team/VC-LTL>
* <https://sourceforge.net/p/sevenzip/discussion/45797/thread/5d10a376/>
