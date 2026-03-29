//
//  EnergyTracking.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 23.03.2026.
//

protocol EnergyTracking {
    var energyConsumption: Double { get } // Watts
    var estimatedCostPerHour: Double { get } // Currency
}

extension EnergyTracking {
    var estimatedCostPerHour: Double {
        // Assuming $0.12 per kWh
        return (energyConsumption / 1000.0) * 0.12
    }
}
