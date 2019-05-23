/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2019 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

#include <LiriLocalDevice/LocalDevice>
#include <LiriLogind/Logind>

#include "lidwatcher.h"

LidWatcher::LidWatcher(PowerManager *parent)
    : QObject(parent)
    , m_powerManager(parent)
    , m_localDevice(new Liri::LocalDevice(this))
{
    // We want to handle when the lid is closed, instead of letting systemd do it
    Liri::Logind::instance()->inhibit(QStringLiteral("liri-power-manager"),
                                      QStringLiteral("Liri wants to handle when the lid is closed"),
                                      Liri::Logind::InhibitLidSwitch,
                                      Liri::Logind::Block);

    // Perform an action when the lid is closed
    connect(m_localDevice, &Liri::LocalDevice::lidClosedChanged,
            this, &LidWatcher::handleLidClosed);
}

void LidWatcher::handleLidClosed()
{
    if (m_localDevice->lidClosed()) {
        switch (m_powerManager->lidClosedAction()) {
        case PowerManager::Suspend:
            if (m_localDevice->canSuspend())
                m_localDevice->suspend();
            break;
        case PowerManager::Hibernate:
            if (m_localDevice->canHibernate())
                m_localDevice->hibernate();
            break;
        case PowerManager::HybridSleep:
            if (m_localDevice->canHybridSleep())
                m_localDevice->hybridSleep();
            break;
        default:
            break;
        }
    }
}
