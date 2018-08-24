/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:LGPLv3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#include <Solid/DeviceNotifier>

#include "batteriesmodel.h"
#include "battery.h"

BatteriesModel::BatteriesModel(QObject *parent)
    : QAbstractListModel(parent)
{
    // Populate list as devices come and go
    Solid::DeviceNotifier *notifier = Solid::DeviceNotifier::instance();
    connect(notifier, &Solid::DeviceNotifier::deviceAdded, [this](const QString &udi) {
        Solid::Device device(udi);
        if (device.as<Solid::Battery>()) {
            Battery *primary = primaryBattery();

            beginInsertRows(QModelIndex(), m_batteries.size(), m_batteries.size());
            Battery *battery = new Battery(device.udi());
            m_batteries.append(battery);
            m_batteriesMap[udi] = battery;
            endInsertRows();
            Q_EMIT countChanged();

            if (primary != primaryBattery())
                Q_EMIT primaryBatteryChanged();
        }
    });
    connect(notifier, &Solid::DeviceNotifier::deviceRemoved, [this](const QString &udi) {
        Battery *battery = m_batteriesMap.value(udi, nullptr);
        if (battery) {
            Battery *primary = primaryBattery();

            beginRemoveRows(QModelIndex(), m_batteries.size(), m_batteries.size());
            m_batteries.removeOne(battery);
            m_batteriesMap.remove(udi);
            battery->deleteLater();
            endRemoveRows();
            Q_EMIT countChanged();

            if (primary != primaryBattery())
                Q_EMIT primaryBatteryChanged();
        }
    });

    // Add already existing devices
    Battery *primary = primaryBattery();
    for (const Solid::Device &device : Solid::Device::allDevices()) {
        if (device.as<Solid::Battery>()) {
            Battery *battery = new Battery(device.udi());

            beginInsertRows(QModelIndex(), m_batteries.size(), m_batteries.size());
            m_batteries.append(battery);
            m_batteriesMap[device.udi()] = battery;
            endInsertRows();
            Q_EMIT countChanged();

            if (primary != primaryBattery())
                Q_EMIT primaryBatteryChanged();
        }
    }
}

Battery *BatteriesModel::primaryBattery() const
{
    for (auto battery : qAsConst(m_batteries)) {
        if (battery->type() == Battery::PrimaryBattery)
            return battery;
    }

    return nullptr;
}

QHash<int, QByteArray> BatteriesModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(BatteryRole, QByteArrayLiteral("battery"));
    roles.insert(UdiRole, QByteArrayLiteral("udi"));
    roles.insert(NameRole, QByteArrayLiteral("name"));
    roles.insert(SummaryRole, QByteArrayLiteral("summary"));
    roles.insert(IconNameRole, QByteArrayLiteral("iconName"));
    roles.insert(ChargeIconNameRole, QByteArrayLiteral("chargeIconName"));
    roles.insert(TypeRole, QByteArrayLiteral("type"));
    roles.insert(IsMouseRole, QByteArrayLiteral("isMouse"));
    roles.insert(TechnologyRole, QByteArrayLiteral("technology"));
    roles.insert(ChargePercentRole, QByteArrayLiteral("chargePercent"));
    roles.insert(CapacityRole, QByteArrayLiteral("capacity"));
    roles.insert(IsRechargeableRole, QByteArrayLiteral("isRechargeable"));
    roles.insert(IsPowerSupplyRole, QByteArrayLiteral("isPowerSupply"));
    roles.insert(ChargeStateRole, QByteArrayLiteral("chargeState"));
    roles.insert(TimeToEmptyRole, QByteArrayLiteral("timeToEmpty"));
    roles.insert(TimeToFullRole, QByteArrayLiteral("timeToFull"));
    roles.insert(EnergyRole, QByteArrayLiteral("energy"));
    roles.insert(EnergyRateRole, QByteArrayLiteral("energyRate"));
    roles.insert(VoltageRole, QByteArrayLiteral("voltage"));
    roles.insert(TemperatureRole, QByteArrayLiteral("temperature"));
    roles.insert(IsRecalledRole, QByteArrayLiteral("isRecalled"));
    roles.insert(RecallVendorRole, QByteArrayLiteral("recallVendor"));
    roles.insert(RecallUrlRole, QByteArrayLiteral("recallUrl"));
    roles.insert(VendorRole, QByteArrayLiteral("vendor"));
    roles.insert(ProductRole, QByteArrayLiteral("product"));
    roles.insert(SerialRole, QByteArrayLiteral("serial"));
    return roles;
}

int BatteriesModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_batteries.size();
}

QVariant BatteriesModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() >= m_batteries.size())
        return QVariant();

    Battery *battery = m_batteries.at(index.row());

    switch (role) {
    case BatteryRole:
        return qVariantFromValue(battery);
    case UdiRole:
        return battery->udi();
    case NameRole:
        return battery->name();
    case Qt::DisplayRole:
    case SummaryRole:
        return battery->summary();
    case IconNameRole:
        return battery->iconName();
    case ChargeIconNameRole:
        return battery->chargeIconName();
    case TypeRole:
        return battery->type();
    case IsMouseRole:
        return battery->isMouse();
    case TechnologyRole:
        return battery->technology();
    case ChargePercentRole:
        return battery->chargePercent();
    case CapacityRole:
        return battery->capacity();
    case IsRechargeableRole:
        return battery->isRechargeable();
    case IsPowerSupplyRole:
        return battery->isPowerSupply();
    case ChargeStateRole:
        return battery->chargeState();
    case TimeToEmptyRole:
        return battery->timeToEmpty();
    case TimeToFullRole:
        return battery->timeToFull();
    case EnergyRole:
        return battery->energy();
    case EnergyRateRole:
        return battery->energyRate();
    case VoltageRole:
        return battery->voltage();
    case TemperatureRole:
        return battery->temperature();
    case IsRecalledRole:
        return battery->isRecalled();
    case RecallVendorRole:
        return battery->recallVendor();
    case RecallUrlRole:
        return battery->recallUrl();
    case VendorRole:
        return battery->recallVendor();
    case ProductRole:
        return battery->product();
    case SerialRole:
        return battery->serial();
    }

    return QVariant();
}
