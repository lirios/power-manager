// SPDX-FileCopyrightText: 2021 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQuick.Layouts
import Fluid as Fluid
import Liri.Shell as Shell
import Liri.Power as Power

Shell.StatusAreaExtension {
    property string powerIconName: batteriesModel.primaryBattery ? batteriesModel.primaryBattery.chargeIconName : "device/battery_unknown"

    Power.BatteriesModel {
        id: batteriesModel
    }

    Component {
        id: pageComponent

        Fluid.Page {
            padding: 0
            header: RowLayout {
                Fluid.ToolButton {
                    icon.source: Fluid.Utils.iconUrl("navigation/arrow_back")
                    onClicked: {
                        popFromMenu();
                    }
                }

                Fluid.TitleLabel {
                    text: qsTr("Power")

                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
            }

            Fluid.ScrollView {
                anchors.fill: parent
                clip: true

                Fluid.ScrollBar.horizontal.policy: Fluid.ScrollBar.AlwaysOff

                ListView {
                    model: batteriesModel

                    delegate: BatteryEntry {
                        battery: model.battery
                    }
                }
            }
        }
    }

    indicator: Shell.Indicator {
        title: qsTr("Power")
        iconSource: Fluid.Utils.iconUrl(powerIconName)
        visible: batteriesModel.count > 0
    }

    menu: Fluid.ListItem {
        icon.source: Fluid.Utils.iconUrl(powerIconName)
        text: qsTr("Power")
        visible: batteriesModel.count > 0
        onClicked: {
            pushToMenu(pageComponent);
        }
    }
}
