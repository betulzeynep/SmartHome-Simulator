//
//  Fan.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//
import Foundation
import Observation

@Observable
class Fan: Switchable, SpeedControllable {
    var device: DeviceIdentifier
    var isOn: Bool
    var speed: Int = 0
    var autoOffTimer: TimeInterval?
    
    // SpeedControllable default implementation
    var minSpeed: Int { 0 }
    var maxSpeed: Int { 100 }
    
    // track usage for eco-awareness
    var energyConsumption: Double {
        guard isOn else { return 0.0 }
        return Double(speed) * 0.5 // watts based on speed
    }
    
    var isOscillating: Bool = false
    
    init(device: DeviceIdentifier, isOn: Bool, speed: Int, autoOffTimer: TimeInterval? = nil, isOscillating: Bool) {
        self.device = device
        self.isOn = isOn
        self.speed = speed
        self.autoOffTimer = autoOffTimer
        self.isOscillating = isOscillating
    }
    
    func turnOn() async throws {
        self.isOn = true
        // Set to a moderate speed when turning on, or keep previous speed if it was set
        if speed == 0 {
            speed = 50 // Default to 50% speed
        }
    }
    
    func turnOn(autoOffAfter duration: TimeInterval) async throws {
        try await turnOn()
        autoOffTimer = duration
        // Schedule auto-off
    }
    
    /// Convenience method to turn on and set speed in one action
    func turnOn(withSpeed newSpeed: Int) async throws {
        try setSpeed(newSpeed)
        try await turnOn()
    }
    
    func turnOff() async throws {
        self.isOn = false
        // Keep the speed setting so when turned back on, it remembers
        // Alternatively, you could reset to 0 if preferred
    }
    
    func toggleOscillation() {
        isOscillating.toggle()
    }
    
    // Implement setSpeed for class (non-mutating)
    func setSpeed(_ speed: Int) throws {
        guard speed >= minSpeed && speed <= maxSpeed else {
            throw DeviceError.invalidSpeed(speed)
        }
        self.speed = speed
    }
}

extension Fan {
    enum SpeedPreset: Int {
        case low = 33
        case medium = 66
        case high = 100
    }
    
    func setSpeed(preset: SpeedPreset) async throws {
        try setSpeed(preset.rawValue)
    }
}
