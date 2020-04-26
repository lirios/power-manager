Power Manager
=============

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/lirios/power-manager.svg)](https://github.com/lirios/power-manager)
[![CI](https://github.com/lirios/power-manager/workflows/CI/badge.svg?branch=develop)](https://github.com/lirios/power-manager/actions?query=workflow%3ACI)
[![GitHub issues](https://img.shields.io/github/issues/lirios/power-manager.svg)](https://github.com/lirios/power-manager/issues)

Power management support for Liri.

## Dependencies

Qt >= 5.10.0 with at least the following modules is required:

 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
 * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
 * [qtwayland](http://code.qt.io/cgit/qt/qtwayland.git)
 * [qtgraphicaleffects](http://code.qt.io/cgit/qt/qtgraphicaleffects.git)
 * [qtquickcontrols2](http://code.qt.io/cgit/qt/qtquickcontrols2.git)
 * [qtsvg](http://code.qt.io/cgit/qt/qtsvg.git)

The following modules and their dependencies are required:

 * [cmake](https://gitlab.kitware.com/cmake/cmake) >= 3.10.0
 * [cmake-shared](https://github.com/lirios/cmake-shared.git) >= 1.0.0
 * [fluid](https://github.com/lirios/fluid) >= 1.0.0
 * [qtgsettings](https://github.com/lirios/qtgsettings) >= 1.1.0
 * [libliri](https://github.com/lirios/libliri.git)
 * [solid](http://quickgit.kde.org/?p=solid.git)

## Installation

```sh
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/path/to/prefix ..
make
make install # use sudo if necessary
```

Replace `/path/to/prefix` to your installation prefix.
Default is `/usr/local`.

You can also append the following options to the `cmake` command:

 * `-DLIRI_ENABLE_SYSTEMD:BOOL=OFF`: Disable systemd support.
 * `-DINSTALL_SYSTEMDUSERUNITDIR=/path/to/systemd/user`: Path to install systemd user units (default: `/usr/local/lib/systemd/user`).

## Licensing

Licensed under the terms of the GNU General Public License version 3 or,
at your option, any later version.
