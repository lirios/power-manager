if(NOT TARGET Liri::Qt6GSettings)
    find_package(Qt6GSettings REQUIRED)
endif()
if(NOT TARGET Liri::Core)
    find_package(Liri1Core REQUIRED)
endif()
if(NOT TARGET Liri::LocalDevice)
    find_package(Liri1LocalDevice REQUIRED)
endif()
if(NOT TARGET Liri::Notifications)
    find_package(Liri1Notifications REQUIRED)
endif()
if(NOT TARGET Liri::Daemon)
    find_package(Liri1Daemon REQUIRED)
endif()

qt_add_plugin(LiriDaemonPowerPlugin
    CLASS_NAME PowerPlugin
    MANUAL_FINALIZATION
    batterywatcher.cpp batterywatcher.h
    idlewatcher.cpp idlewatcher.h
    lidwatcher.cpp lidwatcher.h
    plugin.cpp plugin.h
    powermanager.cpp powermanager.h
    translation.cpp translation.h
)

set_target_properties(LiriDaemonPowerPlugin PROPERTIES
    OUTPUT_NAME power
)

target_compile_definitions(LiriDaemonPowerPlugin
    PRIVATE
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
)

target_link_libraries(LiriDaemonPowerPlugin
    PRIVATE
        Qt6::Core
        Qt6::DBus
        Liri::Daemon
        Liri::Qt6GSettings
        Liri::Core
        Liri::LocalDevice
        Liri::Notifications
        KF6::Solid
)

qt_finalize_target(LiriDaemonPowerPlugin)

file(GLOB ts_files "${CMAKE_CURRENT_SOURCE_DIR}/../../translations/daemon/liri-power-manager_*.ts")
qt_add_translations(LiriDaemonPowerPlugin
    TS_FILES ${ts_files}
)

install(
    TARGETS LiriDaemonPowerPlugin
    DESTINATION ${KDE_INSTALL_PLUGINDIR}/liri/daemon
)
