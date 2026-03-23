//
//  Light.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//

import Observation

@Observable
class Light: Switchable, Dimmable {
    var device: DeviceIdentifier?
    var intensity: Double
    var isOn: Bool
    
    // Dimmable default implementation
    var minIntensity: Double { 0.0 }
    var maxIntensity: Double { 1.0 }
    
    init(device: DeviceIdentifier? = nil, intensity: Double, isOn: Bool) {
        self.device = device
        self.intensity = intensity
        self.isOn = isOn
    }
    
    func turnOn() async throws {
        isOn = true
        intensity = device?.deviceType == .home ? 0.5 : 1.0
    }
    
    func turnOff() async throws {
        isOn = false
        intensity = 0.0
    }
    
    // Implement setIntensity for class (non-mutating)
    func setIntensity(_ value: Double) throws {
        guard value >= minIntensity && value <= maxIntensity else {
            throw DeviceError.invalidIntensity(value)
        }
        self.intensity = value
    }
}
