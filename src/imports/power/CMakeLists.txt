find_package(KF5Solid "${KF5_MIN_VERSION}" REQUIRED)

if(NOT TARGET Liri::Core)
    find_package(Liri1Core REQUIRED)
endif()

liri_add_qml_plugin(power
    MODULE_PATH
        "Liri/Power"
    SOURCES
        batteriesmodel.cpp
        batteriesmodel.h
        battery.cpp
        battery.h
        plugin.cpp
    QML_FILES
        qmldir
        plugins.qmltypes
    DEFINES
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
    LIBRARIES
        Liri::Core
        KF5::Solid
)
