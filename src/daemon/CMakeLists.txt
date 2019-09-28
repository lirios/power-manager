find_package(KF5Solid "${KF5_MIN_VERSION}" REQUIRED)

if(NOT TARGET Liri::Qt5GSettings)
    find_package(Qt5GSettings REQUIRED)
endif()
if(NOT TARGET Liri::Core)
    find_package(Liri1Core REQUIRED)
endif()
if(NOT TARGET Liri::LocalDevice)
    find_package(Liri1LocalDevice REQUIRED)
endif()
if(NOT TARGET Liri::Logind)
    find_package(Liri1Logind REQUIRED)
endif()
if(NOT TARGET Liri::Notifications)
    find_package(Liri1Notifications REQUIRED)
endif()
if(NOT TARGET Liri::Daemon)
    find_package(Liri1Daemon REQUIRED)
endif()

# Translations
file(GLOB LiriPowerManager_TRANSLATIONS "${CMAKE_CURRENT_SOURCE_DIR}/translations/*_*.ts")
qt5_add_translation(LiriPowerManager_QM_FILES ${LiriPowerManager_TRANSLATIONS})
install(FILES ${LiriPowerManager_QM_FILES}
        DESTINATION "${INSTALL_DATADIR}/liri-power-manager/translations")

liri_add_plugin(power
    TYPE
        liri/daemon
    SOURCES
        batterywatcher.cpp
        batterywatcher.h
        idlewatcher.cpp
        idlewatcher.h
        lidwatcher.cpp
        lidwatcher.h
        plugin.cpp
        plugin.h
        powermanager.cpp
        powermanager.h
        translation.cpp
        translation.h
        ${LiriPowerManager_QM_FILES}
    DEFINES
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
    LIBRARIES
        Qt5::DBus
        Liri::Daemon
        Liri::Qt5GSettings
        Liri::Core
        Liri::LocalDevice
        Liri::Logind
        Liri::Notifications
        KF5::Solid
)
