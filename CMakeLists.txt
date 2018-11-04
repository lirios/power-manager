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

## Find Qt 5:
find_package(Qt5 "${QT_MIN_VERSION}"
    CONFIG REQUIRED
    COMPONENTS
        Core
        DBus
        Gui
        Qml
        Quick
)

## Add subdirectories:
add_subdirectory(data/settings)
add_subdirectory(src/imports/power)
add_subdirectory(src/daemon)
add_subdirectory(src/indicators/power)
add_subdirectory(src/settings/power)
