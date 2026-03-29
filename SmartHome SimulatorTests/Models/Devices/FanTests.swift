//
//  FanTests.swift
//  SmartHome SimulatorTests
//
//  Created by Zeynep Turnalı on 25.03.2026.
//

import XCTest
@testable import SmartHome_Simulator

@MainActor
final class FanTests: XCTestCase {
    
    func testTurningOnSetsDefaultSpeed() async throws {
        // given
        let fan = Fan(device: DeviceIdentifier(deviceID: UUID(), deviceType: .home), isOn: false, speed: 0, isOscillating: false)
        // when
        try await fan.turnOn()
        // then
        XCTAssertTrue(fan.isOn)
        XCTAssertEqual(fan.speed, 50)
    }
    
    func testSettingInvalidSpeed() async throws {
        // given
        let invalidSpeed = -1
        // when
        let fan = Fan(device: DeviceIdentifier(deviceID: UUID(), deviceType: .home), isOn: true, speed: invalidSpeed, isOscillating: false)
        // then
        XCTAssertNotEqual(fan.speed, -1)
    }
    
    func testTurningOffResetsSpeedToZero() async throws {
        // given
        let fan = Fan(device: DeviceIdentifier(deviceID: UUID(), deviceType: .home), isOn: true, speed: 60, isOscillating: false)
        // when
        try await fan.turnOff()
        // then
        XCTAssertFalse(fan.isOn)
        XCTAssertEqual(fan.speed, 0)
    }
    
    func testSetSpeedUpdatesSpeedProperty() async throws {
        // given
        let fan = Fan(device: DeviceIdentifier(deviceID: UUID(), deviceType: .home), isOn: true, speed: 60, isOscillating: false)
        // when
        let newSpeed = 40
        try fan.setSpeed(newSpeed)
        // then
        XCTAssertEqual(fan.speed, newSpeed)
    }
    
    func testChangeSpeedToMediumPresentProperly() async throws {
        // given
        let fan = Fan(device: DeviceIdentifier(deviceID: UUID(), deviceType: .home), isOn: true, speed: 0, isOscillating: false)
        // when
        try await fan.setSpeed(preset: .medium)
        // then
        XCTAssertEqual(fan.speed, Fan.SpeedPreset.medium.rawValue)
    }
    
    func testOscillationOnAndOff() async throws {
        // given
        let fan = Fan(device: DeviceIdentifier(deviceID: UUID(), deviceType: .home), isOn: true, speed: 0, isOscillating: false)
        // when
        fan.toggleOscillation()
        // then
        XCTAssertTrue(fan.isOscillating)
        // when
        fan.toggleOscillation()
        // then
        XCTAssertFalse(fan.isOscillating)
    }
}
