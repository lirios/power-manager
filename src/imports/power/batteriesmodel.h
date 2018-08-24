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

#ifndef BATTERIESMODEL_H
#define BATTERIESMODEL_H

#include <QAbstractListModel>

class Battery;

class BatteriesModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(Battery *primaryBattery READ primaryBattery NOTIFY primaryBatteryChanged)
    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)
public:
    enum Roles {
        BatteryRole = Qt::UserRole + 1,
        UdiRole,
        NameRole,
        SummaryRole,
        IconNameRole,
        ChargeIconNameRole,
        TypeRole,
        IsMouseRole,
        TechnologyRole,
        ChargePercentRole,
        CapacityRole,
        IsRechargeableRole,
        IsPowerSupplyRole,
        ChargeStateRole,
        TimeToEmptyRole,
        TimeToFullRole,
        EnergyRole,
        EnergyRateRole,
        VoltageRole,
        TemperatureRole,
        IsRecalledRole,
        RecallVendorRole,
        RecallUrlRole,
        VendorRole,
        ProductRole,
        SerialRole
    };

    explicit BatteriesModel(QObject *parent = nullptr);

    Battery *primaryBattery() const;

    QHash<int, QByteArray> roleNames() const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

Q_SIGNALS:
    void primaryBatteryChanged();
    void countChanged();

private:
    QVector<Battery *> m_batteries;
    QMap<QString, Battery *> m_batteriesMap;
};

#endif // BATTERIESMODEL_H
