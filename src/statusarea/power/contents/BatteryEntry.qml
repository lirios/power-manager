// SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Fluid as Fluid
import Liri.Power

Fluid.ListItem {
    property var battery

    icon.source: Fluid.Utils.iconUrl(battery.iconName)
    text: battery.summary
    valueText: qsTr("%1%").arg(battery.chargePercent)

    secondaryItem: Fluid.ProgressBar {
        from: 0
        to: 100
        value: battery.chargePercent

        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
    }
}
