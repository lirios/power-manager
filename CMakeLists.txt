cmake_minimum_required(VERSION 3.10.0)

project("PowerManager"
    VERSION "0.9.0"
    DESCRIPTION "Power management support"
    LANGUAGES CXX C
)

## Shared macros and functions:
if(NOT LIRI_LOCAL_ECM)
    find_package(LiriCMakeShared "1.0.0" REQUIRED NO_MODULE)
    list(APPEND CMAKE_MODULE_PATH "${LCS_MODULE_PATH}")
endif()

## Set minimum versions required:
set(QT_MIN_VERSION "5.10.0")
set(KF5_MIN_VERSION "5.48.0")

## Liri specific setup common for all modules:
include(LiriSetup)

## Features:
option(LIRI_ENABLE_SYSTEMD "Enable systemd support" ON)
add_feature_info("Liri::Systemd" LIRI_ENABLE_SYSTEMD "Enable systemd support")

## Variables:
if(LIRI_ENABLE_SYSTEMD)
    set(INSTALL_SYSTEMDUSERUNITDIR "${INSTALL_LIBDIR}/systemd/user" CACHE PATH "systemd user unit directory [PREFIX/lib/systemd/user]")
endif()

## Find Qt 5:
find_package(Qt5 "${QT_MIN_VERSION}"
    CONFIG REQUIRED
    COMPONENTS
        Core
        DBus
        Gui
        Qml
        Quick
        LinguistTools
)

## Add subdirectories:
add_subdirectory(data/settings)
if(LIRI_ENABLE_SYSTEMD)
    add_subdirectory(data/systemd)
endif()
add_subdirectory(src/imports/power)
add_subdirectory(src/daemon)
add_subdirectory(src/indicators/power)
add_subdirectory(src/settings/power)
