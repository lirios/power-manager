// SPDX-FileCopyrightText: 2021 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Fluid.Controls 1.0 as FluidControls
import Liri.Shell 1.0 as Shell
import Liri.Power 1.0 as Power

Shell.StatusAreaExtension {
    property string powerIconName: batteriesModel.primaryBattery ? batteriesModel.primaryBattery.chargeIconName : "device/battery_unknown"

    Power.BatteriesModel {
        id: batteriesModel
    }

    Component {
        id: pageComponent

        Page {
            padding: 0
            header: RowLayout {
                ToolButton {
                    icon.source: FluidControls.Utils.iconUrl("navigation/arrow_back")
                    onClicked: {
                        popFromMenu();
                    }
                }

                FluidControls.TitleLabel {
                    text: qsTr("Power")

                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
            }

            ScrollView {
                anchors.fill: parent
                clip: true

                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

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
        iconSource: FluidControls.Utils.iconUrl(powerIconName)
        visible: batteriesModel.count > 0
    }

    menu: FluidControls.ListItem {
        icon.source: FluidControls.Utils.iconUrl(powerIconName)
        text: qsTr("Power")
        visible: batteriesModel.count > 0
        onClicked: {
            pushToMenu(pageComponent);
        }
    }
}
