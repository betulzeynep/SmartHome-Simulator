//
//  Light.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//

import Observation

@Observable
final class Light: Switchable, Dimmable {
    var device: DeviceIdentifier?
    var intensity: Double = 0.0
    var isOn: Bool
    
    // Dimmable default implementation
    var minIntensity: Double { 0.0 }
    var maxIntensity: Double { 1.0 }
    
    init(device: DeviceIdentifier? = nil, intensity: Double, isOn: Bool) {
        self.device = device
        self.isOn = isOn
        // Validate intensity before setting
        self.intensity = max(minIntensity, min(intensity, maxIntensity))
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

extension Light: EnergyTracking {
    var energyConsumption: Double {
        guard isOn else { return 0.0 }
        return intensity * 60.0 // 60W max bulb
    }
}
