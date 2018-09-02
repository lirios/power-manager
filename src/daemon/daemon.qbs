import qbs 1.0

QtGuiApplication {
    name: "liri-power-manager"
    targetName: "liri-power-manager"

    Depends { name: "lirideployment" }
    Depends { name: "Qt"; submodules: ["core", "dbus"] }
    Depends { name: "Qt5GSettings" }
    Depends { name: "LiriCore" }
    Depends { name: "LiriNotifications" }
    Depends { name: "KF5.Solid" }
    Depends { name: "LiriTranslations" }

    cpp.defines: [
        'VERSION="' + project.version + '"',
        "QT_NO_CAST_FROM_ASCII",
        "QT_NO_CAST_TO_ASCII"
    ]

    files: [
        "batterywatcher.cpp",
        "batterywatcher.h",
        "idlewatcher.cpp",
        "idlewatcher.h",
        "main.cpp",
        "powermanager.cpp",
        "powermanager.h",
        "translation.cpp",
        "translation.h",
    ]

    Group {
        name: "Desktop File"
        files: ["io.liri.PowerManager.desktop.in"]
        fileTags: ["liri.desktop.template"]
    }

    Group {
        name: "Desktop File Translations"
        files: ["io.liri.PowerManager_*.desktop"]
        prefix: "translations/"
        fileTags: ["liri.desktop.translations"]
    }

    Group {
        name: "Translations"
        files: ["*_*.ts"]
        prefix: "translations/"
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.binDir
        fileTagsFilter: "application"
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.etcDir + "/xdg/autostart"
        qbs.installPrefix: ""
        fileTagsFilter: "liri.desktop.file"
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/liri-power-manager/translations"
        fileTagsFilter: "qm"
    }

}
