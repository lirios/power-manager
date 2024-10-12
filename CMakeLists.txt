cmake_minimum_required(VERSION 3.19)

project("PowerManager"
    VERSION "0.9.0"
    DESCRIPTION "Power management support"
    LANGUAGES CXX C
)

## Only build on the appropriate platforms.
if(NOT UNIX OR ANDROID)
    message(NOTICE "Skipping the build as the condition \"UNIX OR ANDROID\" is not met.")
    return()
endif()

## ECM:
find_package(ECM 5.245.0 REQUIRED NO_MODULE)
list(APPEND CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

## Installation directories:
include(KDEInstallDirs)

## Compiler settings:
set(KDE_SKIP_NULLPTR_WARNINGS_SETTINGS TRUE)
include(KDECompilerSettings NO_POLICY_SCOPE)

## CMake settings:
include(KDECMakeSettings)

## QML module:
include(ECMQmlModule)

## Disable use of C++ API deprecated in Qt 5.15
add_compile_definitions(QT_DISABLE_DEPRECATED_UP_TO=0x050F00)

## Features:
include(features.cmake)

## Features:
option(LIRI_ENABLE_SYSTEMD "Enable systemd support" ON)
add_feature_info("Liri::Systemd" LIRI_ENABLE_SYSTEMD "Enable systemd support")

## Variables:
if(LIRI_ENABLE_SYSTEMD)
    set(INSTALL_SYSTEMDUSERUNITDIR "${KDE_INSTALL_LIBDIR}/systemd/user" CACHE PATH "systemd user unit directory [PREFIX/lib/systemd/user]")
endif()

## Add subdirectories:
add_subdirectory(data/settings)
if(LIRI_ENABLE_SYSTEMD)
    add_subdirectory(data/systemd)
endif()
add_subdirectory(src/imports/power)
add_subdirectory(src/daemon)
add_subdirectory(src/settings/power)
#add_subdirectory(src/statusarea/power)
