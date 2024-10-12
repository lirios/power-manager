/****************************************************************************
 * This file is part of Settings.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import Fluid as Fluid
import Liri.Settings
import Liri.Power
import Liri.Device
import QtGSettings

ModulePage {
    id: page

    GSettings {
        id: sessionSettings

        schema.id: "io.liri.session"
        schema.path: "/io/liri/session/"
    }

    GSettings {
        id: powerSettings

        schema.id: "io.liri.hardware.power"
        schema.path: "/io/liri/hardware/power/"
    }

    BatteriesModel {
        id: batteriesModel
    }

    AutomaticSuspendDialog {
        id: automaticSuspendDialog
    }

    Fluid.ScrollView {
        anchors.fill: parent
        clip: true

        Column {
            ModuleContainer {
                title: qsTr("Devices")
                width: page.width
                visible: repeater.count > 0

                Repeater {
                    id: repeater
                    model: batteriesModel
                    delegate: BatteryListItem { battery: model.battery }
                }
            }

            ModuleContainer {
                title: qsTr("Power Saving")
                width: page.width

                Fluid.ListItem {
                    text: qsTr("Screen brightness")
                    secondaryItem: Fluid.Slider {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        from: 0
                        to: 100
                        value: 50
                    }
                    visible: false
                }

                Fluid.ListItem {
                    text: qsTr("Keyboard brightness")
                    secondaryItem: Fluid.Slider {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        from: 0
                        to: 100
                        value: 50
                    }
                    visible: false
                }

                Fluid.ListItem {
                    text: qsTr("Dim screen when inactive")
                    rightItem: Fluid.Switch {
                        anchors.centerIn: parent
                        checked: powerSettings.idleDim
                        onCheckedChanged: powerSettings.idleDim = checked
                    }
                    visible: batteriesModel.count > 0
                }

                Fluid.ListItem {
                    text: qsTr("Blank screen")
                    rightItem: Fluid.ComboBox {
                        anchors.centerIn: parent
                        width: Fluid.Units.gu(6)
                        textRole: "text"
                        model: ListModel {
                            ListElement { text: QT_TR_NOOP("1 minute"); value: 60 }
                            ListElement { text: QT_TR_NOOP("2 minutes"); value: 120 }
                            ListElement { text: QT_TR_NOOP("3 minutes"); value: 180 }
                            ListElement { text: QT_TR_NOOP("4 minutes"); value: 240 }
                            ListElement { text: QT_TR_NOOP("5 minutes"); value: 300 }
                            ListElement { text: QT_TR_NOOP("8 minutes"); value: 480 }
                            ListElement { text: QT_TR_NOOP("10 minutes"); value: 600 }
                            ListElement { text: QT_TR_NOOP("12 minutes"); value: 720 }
                            ListElement { text: QT_TR_NOOP("15 minutes"); value: 900 }
                            ListElement { text: QT_TR_NOOP("Never"); value: 0 }
                        }
                        currentIndex: {
                            switch (sessionSettings.idleDelay) {
                            case 60:
                                return 0;
                            case 120:
                                return 1;
                            case 180:
                                return 2;
                            case 240:
                                return 3;
                            case 300:
                                return 4;
                            case 480:
                                return 5;
                            case 600:
                                return 6;
                            case 720:
                                return 7;
                            case 900:
                                return 8;
                            }

                            return 9;
                        }
                        onActivated: {
                            sessionSettings.idleDelay = model.get(index).value;
                        }
                    }
                }

                Fluid.ListItem {
                    text: qsTr("Wi-Fi")
                    subText: qsTr("Turn off Wi-Fi to save power")
                    rightItem: Fluid.Switch {
                        anchors.centerIn: parent
                        checked: true
                    }
                    visible: false
                }

                Fluid.ListItem {
                    text: qsTr("Bluetooth")
                    subText: qsTr("Turn off Bluetooth to save power")
                    rightItem: Fluid.Switch {
                        anchors.centerIn: parent
                        checked: true
                    }
                    visible: false
                }
            }

            ModuleContainer {
                title: qsTr("Suspend & Power Button")
                width: page.width

                Fluid.ListItem {
                    text: qsTr("Automatic suspend")
                    rightItem: Fluid.BodyLabel {
                        anchors.centerIn: parent
                        text: {
                            var batteryOn = powerSettings.sleepInactiveBatteryType === "suspend";
                            var acOn = powerSettings.sleepInactiveAcType === "suspend";

                            if (batteriesModel.count > 0) {
                                if (batteryOn && acOn)
                                    return qsTr("On");
                                else if (batteryOn)
                                    return qsTr("When on battery power");
                                else if (acOn)
                                    return qsTr("When plugged in");
                            } else if (acOn) {
                                return qsTr("On");
                            }

                            return qsTr("Off");
                        }
                        color: Material.secondaryTextColor
                    }
                    onClicked: automaticSuspendDialog.open()
                }

                Fluid.ListItem {
                    text: qsTr("When the Power Button is pressed")
                    rightItem: Fluid.ComboBox {
                        anchors.centerIn: parent
                        textRole: "text"
                        model: ListModel {
                            ListElement { text: QT_TR_NOOP("Ask"); value: "interactive" }
                            ListElement { text: QT_TR_NOOP("Suspend"); value: "suspend" }
                            ListElement { text: QT_TR_NOOP("Hibernate"); value: "hibernate" }
                            ListElement { text: QT_TR_NOOP("Hybrid Sleep"); value: "hybridsleep" }
                            ListElement { text: QT_TR_NOOP("Nothing"); value: "nothing" }
                        }
                        currentIndex: {
                            switch (powerSettings.powerButtonAction) {
                            case "interactive":
                                return 0;
                            case "suspend":
                                return 1;
                            case "hibernate":
                                return 2;
                            case "hybridsleep":
                                return 3;
                            }

                            return 4;
                        }
                        onActivated: {
                            powerSettings.powerButtonAction = model.get(index).value;
                        }
                    }
                }

                Fluid.ListItem {
                    text: qsTr("When the lid is closed")
                    rightItem: Fluid.ComboBox {
                        anchors.centerIn: parent
                        textRole: "text"
                        model: ListModel {
                            ListElement { text: QT_TR_NOOP("Suspend"); value: "suspend" }
                            ListElement { text: QT_TR_NOOP("Hibernate"); value: "hibernate" }
                            ListElement { text: QT_TR_NOOP("Hybrid Sleep"); value: "hybridsleep" }
                            ListElement { text: QT_TR_NOOP("Nothing"); value: "nothing" }
                        }
                        currentIndex: {
                            switch (powerSettings.lidClosedType) {
                            case "suspend":
                                return 0;
                            case "hibernate":
                                return 1;
                            case "hybridsleep":
                                return 2;
                            }

                            return 3;
                        }
                        visible: LocalDevice.lidPresent
                        onActivated: {
                            powerSettings.lidClosedType = model.get(index).value;
                        }
                    }
                }
            }
        }
    }
}
