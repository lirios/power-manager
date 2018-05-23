import qbs 1.0

Project {
    name: "PowerManager"

    readonly property string version: "0.9.0"

    readonly property string minimumQtVersion: "5.10.0"

    property bool useStaticAnalyzer: false

    condition: qbs.targetOS.contains("unix") && !qbs.targetOS.contains("darwin") && !qbs.targetOS.contains("android")

    minimumQbsVersion: "1.8.0"

    references: [
        "data/settings/settings.qbs",
        "src/daemon/daemon.qbs",
        "src/settings/power/power.qbs",
    ]
}
