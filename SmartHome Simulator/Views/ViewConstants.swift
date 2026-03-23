//
//  ViewConstants.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//

import Foundation

/// Constants for card view dimensions
enum CardViewDimensions {
    static let cardHeight: CGFloat = 160
    static let cardAndImageWidth: CGFloat = 160
    static let cornerRadius: CGFloat = 4
}

/// System icon names for different device types
enum CardViewIcons {
    case light
    case fan
    case heater
    case temperature
    
    var imageName: String {
        switch self {
        case .light:
            return "lamp.ceiling.inverse"
        case .fan:
            return "fan"
        case .heater:
            return "thermometer.medium"
        case .temperature:
            return "thermometer"
        }
    }
}
