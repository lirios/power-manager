find_package(KF5Solid "${KF5_MIN_VERSION}" REQUIRED)

if(NOT TARGET Liri::Qt5GSettings)
    find_package(Qt5GSettings REQUIRED)
endif()
if(NOT TARGET Liri::Core)
    find_package(Liri1Core REQUIRED)
endif()
if(NOT TARGET Liri::Notifications)
    find_package(Liri1Notifications REQUIRED)
endif()

# Translations
file(GLOB LiriPowerManager_TRANSLATIONS "${CMAKE_CURRENT_SOURCE_DIR}/translations/*_*.ts")
qt5_add_translation(LiriPowerManager_QM_FILES ${LiriPowerManager_TRANSLATIONS})
install(FILES ${LiriPowerManager_QM_FILES}
        DESTINATION "${INSTALL_DATADIR}/liri-power-manager/translations")

liri_translate_desktop(_desktop_file SOURCES "io.liri.PowerManager.desktop.in")

liri_add_executable(LiriPowerManager
    OUTPUT_NAME
        "liri-power-manager"
    SOURCES
        batterywatcher.cpp
        batterywatcher.h
        idlewatcher.cpp
        idlewatcher.h
        main.cpp
        powermanager.cpp
        powermanager.h
        translation.cpp
        translation.h
        ${LiriPowerManager_QM_FILES}
    DEFINES
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
        VERSION="${PROJECT_VERSION}"
    DESKTOP
        "${_desktop_file}"
    DESKTOP_INSTALL_DIRECTORY
        "${INSTALL_SYSCONFDIR}/xdg/autostart"
    LIBRARIES
        Qt5::DBus
        Liri::Qt5GSettings
        Liri::Core
        Liri::Notifications
        KF5::Solid
    GUI
)
