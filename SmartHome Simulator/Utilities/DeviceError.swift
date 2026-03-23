//
//  DeviceError.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//

import Foundation

// Device-specific errors for connection, validation, and operational issues
enum DeviceError: Error {
    case doesnothaveinternet
    case unabletoconnect
    case unabletodisconnect
    case invalidSpeed(Int)
    case invalidTemperature(Double)
    case invalidIntensity(Double)
    case deviceNotResponding
    case operationTimeout
}

extension DeviceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .doesnothaveinternet:
            return "Device does not have internet connection"
        case .unabletoconnect:
            return "Unable to connect to device"
        case .unabletodisconnect:
            return "Unable to disconnect from device"
        case .invalidSpeed(let speed):
            return "Invalid speed value: \(speed). Must be between 0 and 100."
        case .invalidTemperature(let temp):
            return "Invalid temperature value: \(temp)°C. Must be between 15°C and 30°C."
        case .invalidIntensity(let intensity):
            return "Invalid intensity value: \(Int(intensity * 100))%. Must be between 0% and 100%."
        case .deviceNotResponding:
            return "Device is not responding. Please check the connection."
        case .operationTimeout:
            return "Operation timed out. Please try again."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .doesnothaveinternet:
            return "Check your internet connection and try again."
        case .unabletoconnect:
            return "Make sure the device is powered on and within range."
        case .unabletodisconnect:
            return "Force quit the app and try again."
        case .invalidSpeed, .invalidTemperature, .invalidIntensity:
            return "Please enter a valid value within the allowed range."
        case .deviceNotResponding:
            return "Try restarting the device or check if it's powered on."
        case .operationTimeout:
            return "Check your connection and try the operation again."
        }
    }
}
