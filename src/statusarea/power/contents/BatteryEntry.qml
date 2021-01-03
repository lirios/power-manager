// SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Fluid.Controls 1.0 as FluidControls
import Liri.Power 1.0

FluidControls.ListItem {
    property var battery

    icon.source: FluidControls.Utils.iconUrl(battery.iconName)
    text: battery.summary
    valueText: qsTr("%1%").arg(battery.chargePercent)

    secondaryItem: ProgressBar {
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
