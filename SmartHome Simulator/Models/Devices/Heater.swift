//
//  Heater.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//

import Observation

@Observable
class Heater: Switchable, TemperatureControllable {
    var isOn: Bool
    var temperature: Int
    var targetTemperature: Double
    var currentTemperature: Double
    
    var minTemperature: Double { 15.0 }
    var maxTemperature: Double { 30.0 }
    
    init(isOn: Bool, temperature: Int, targetTemperature: Double, currentTemperature: Double) {
        self.isOn = isOn
        self.temperature = temperature
        self.targetTemperature = targetTemperature
        self.currentTemperature = currentTemperature
    }
    
    func setTemperature(_ temp: Double) throws {
        guard temp >= minTemperature && temp <= maxTemperature else {
            throw DeviceError.invalidTemperature(temp)
        }
        targetTemperature = temp
    }
    
    func turnOn() async throws {
        self.isOn = true
        self.temperature = 100
    }
    
    func turnOff() async throws {
        self.isOn = false
        self.temperature = 0
    }
}
