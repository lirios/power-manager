import qbs 1.0

Product {
    name: "liri-power-manager-gsettings"

    Depends { name: "lirideployment" }

    Group {
        name: "Schemas"
        files: [
            "io.liri.hardware.power.enums.xml",
            "io.liri.hardware.power.gschema.xml",
        ]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/glib-2.0/schemas"
    }
}
