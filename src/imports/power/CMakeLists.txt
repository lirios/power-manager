find_package(KF5Solid "${KF5_MIN_VERSION}" REQUIRED)

if(NOT TARGET Liri::Core)
    find_package(Liri1Core REQUIRED)
endif()

liri_add_qml_plugin(power
    MODULE_PATH
        "Liri/Power"
    VERSION
        "1.0"
    SOURCES
        batteriesmodel.cpp
        batteriesmodel.h
        battery.cpp
        battery.h
        plugin.cpp
    QML_FILES
        qmldir
    DEFINES
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
    LIBRARIES
        Liri::Core
        KF5::Solid
)

liri_finalize_qml_plugin(power)
