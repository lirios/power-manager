/****************************************************************************
 * This file is part of Liri.
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

#include "batterywatcher.h"
#include "lidwatcher.h"
#include "powermanager.h"

PowerManager::PowerManager(QObject *parent)
    : QObject(parent)
{
    // Settings
    m_settings = new QtGSettings::QGSettings(QStringLiteral("io.liri.hardware.power"),
                                             QStringLiteral("/io/liri/hardware/power/"),
                                             this);
    m_lidClosedAction = convertPowerAction(m_settings->value(QStringLiteral("lid-closed-type")).toString());
    m_sleepAcTimeout = m_settings->value(QStringLiteral("sleep-inactive-ac-timeout")).toInt();
    m_sleepAcAction = m_settings->value(QStringLiteral("sleep-inactive-ac-type")).toString();
    m_sleepBatteryTimeout = m_settings->value(QStringLiteral("sleep-inactive-battery-timeout")).toInt();
    m_sleepBatteryAction = m_settings->value(QStringLiteral("sleep-inactive-battery-type")).toString();
    connect(m_settings, &QtGSettings::QGSettings::settingChanged, this, &PowerManager::settingChanged);

    // Watchers
    new BatteryWatcher(this);
    new LidWatcher(this);
}

PowerManager::PowerActionType PowerManager::lidClosedAction() const
{
    return m_lidClosedAction;
}

int PowerManager::sleepInactiveAcTimeout() const
{
    return m_sleepAcTimeout;
}

int PowerManager::sleepInactiveBatteryTimeout() const
{
    return m_sleepBatteryTimeout;
}

PowerManager::PowerActionType PowerManager::convertPowerAction(const QString &action)
{
    if (action == QStringLiteral("nothing"))
        return Nothing;
    else if (action == QStringLiteral("suspend"))
        return Suspend;
    else if (action == QStringLiteral("hibernate"))
        return Hibernate;
}

void PowerManager::settingChanged(const QString &key)
{
    if (key == QStringLiteral("lid-closed-type")) {
        m_lidClosedAction = convertPowerAction(m_settings->value(key).toString());
        Q_EMIT lidClosedActionChanged();
    } else if (key == QStringLiteral("sleep-inactive-ac-timeout")) {
        m_sleepAcTimeout = m_settings->value(key).toInt();
        Q_EMIT sleepInactiveAcTimeoutChanged();
    } else if (key == QStringLiteral("sleep-inactive-ac-type")) {
        m_sleepAcAction = m_settings->value(key).toString();
        Q_EMIT sleepInactiveAcTypeChanged();
    } else if (key == QStringLiteral("sleep-inactive-battery-timeout")) {
        m_sleepBatteryTimeout = m_settings->value(key).toInt();
        Q_EMIT sleepInactiveBatteryTimeoutChanged();
    } else if (key == QStringLiteral("sleep-inactive-battery-type")) {
        m_sleepBatteryAction = m_settings->value(key).toString();
        Q_EMIT sleepInactiveBatteryTypeChanged();
    }
}
