//
//  Heater.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//

import Observation

@Observable
final class Heater: Switchable {
    var isOn: Bool
    var temperature: Double = 0.0
    var targetTemperature: Double
    var currentTemperature: Double
    var minTemperature: Double { 15.0 }
    var maxTemperature: Double { 30.0 }
    
    init(isOn: Bool, temperature: Double, targetTemperature: Double, currentTemperature: Double) {
        self.isOn = isOn
        self.targetTemperature = targetTemperature
        self.currentTemperature = currentTemperature
        self.temperature = max(minTemperature, min(temperature, maxTemperature))
    }
    
    func setTemperature(_ temp: Double) throws {
        guard temp >= minTemperature && temp <= maxTemperature else {
            throw DeviceError.invalidTemperature(temp)
        }
        targetTemperature = temp
    }
    
    func turnOn() async throws {
        self.isOn = true
        self.temperature = self.maxTemperature
    }
    
    func turnOff() async throws {
        self.isOn = false
        self.temperature = self.minTemperature
    }
}

extension Heater: EnergyTracking {
    var energyConsumption: Double {
        guard isOn else { return 0.0 }
        return 1500.0 // 1.5kW heater
    }
}
