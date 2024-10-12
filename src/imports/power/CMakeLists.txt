if(NOT TARGET Liri::Core)
    find_package(Liri1Core REQUIRED)
endif()

ecm_add_qml_module(PowerQmlPlugin
    URI Liri.Power
    VERSION 1.0
    CLASS_NAME PowerPlugin
    DEPENDENCIES QtQuick
)

target_sources(PowerQmlPlugin
    PRIVATE
        batteriesmodel.cpp batteriesmodel.h
        battery.cpp battery.h
)

target_compile_definitions(PowerQmlPlugin
    PRIVATE
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
)

target_link_libraries(PowerQmlPlugin
    PRIVATE
        Qt6::Core
        Qt6::Qml
        Liri::Core
        KF6::Solid
)

ecm_finalize_qml_module(PowerQmlPlugin)
