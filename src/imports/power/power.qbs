import qbs 1.0

LiriQmlPlugin {
    name: "powerplugin"
    pluginPath: "Liri/Power"

    Depends { name: "KF5.Solid" }
    Depends { name: "LiriCore" }

    files: [
        "batteriesmodel.cpp",
        "batteriesmodel.h",
        "battery.cpp",
        "battery.h",
        "plugin.cpp",
        "plugins.qmltypes",
        "qmldir",
    ]
}
