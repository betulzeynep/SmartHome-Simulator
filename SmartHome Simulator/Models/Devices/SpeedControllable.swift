//
//  SpeedControllable.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//

protocol SpeedControllable {
    var speed: Int { get set }
    var minSpeed: Int { get }
    var maxSpeed: Int { get }
    
    func setSpeed(_ speed: Int) throws
}

extension SpeedControllable {
    var minSpeed: Int { 0 }
    var maxSpeed: Int { 100 }
    
    mutating func setSpeed(_ speed: Int) throws {
        guard speed >= minSpeed && speed <= maxSpeed else {
            throw DeviceError.invalidSpeed(speed)
        }
        self.speed = speed
    }
}
