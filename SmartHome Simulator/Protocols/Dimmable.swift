//
//  Dimmable.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//

protocol Dimmable {
    var intensity: Double { get set }
    var minIntensity: Double { get }
    var maxIntensity: Double { get }
    
    func setIntensity(_ value: Double) throws
}

extension Dimmable {
    var minIntensity: Double { 0.0 }
    var maxIntensity: Double { 1.0 }
    
    mutating func setIntensity(_ value: Double) throws {
        guard value >= minIntensity && value <= maxIntensity else {
            throw DeviceError.invalidIntensity(value)
        }
        self.intensity = value
    }
}
