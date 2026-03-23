//
//  DeviceIdentifier.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//

import Foundation

struct DeviceIdentifier {
    var deviceID: UUID
    var deviceType: DeviceType
}

enum DeviceType {
    case home
    case office
}
