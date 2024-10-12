# SPDX-FileCopyrightText: 2024 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause

## Enable feature summary at the end of the configure run:
include(FeatureSummary)

## Set minimum versions required:
set(QT_MIN_VERSION "6.7.0")
set(KF6_MIN_VERSION "6.1.0")

## Find Qt:
find_package(Qt6 "${QT_MIN_VERSION}"
    REQUIRED
    COMPONENTS
        Core
        DBus
        Gui
        Qml
        Quick
        LinguistTools
)

# Find Solid:
find_package(KF6Solid "${KF6_MIN_VERSION}" REQUIRED)

#### Features

option(LIRI_ENABLE_SYSTEMD "Enable systemd support" ON)
add_feature_info("Liri::Systemd" LIRI_ENABLE_SYSTEMD "Enable systemd support")

## Features summary:
if(NOT LIRI_SUPERBUILD)
    feature_summary(WHAT ENABLED_FEATURES DISABLED_FEATURES)
endif()
