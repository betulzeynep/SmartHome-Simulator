//
//  HeaterTests.swift
//  SmartHome SimulatorTests
//
//  Created by Zeynep Turnalı on 25.03.2026.
//

import XCTest
@testable import SmartHome_Simulator

//// MARK: - Heater Tests
//@Suite("Heater Device Tests")
//struct HeaterTests {
//
//    @Test("Heater should start with correct initial state")
//    func initialState() async throws {
//        let heater = Heater(isOn: false, heat: 0)
//
//        #expect(heater.isOn == false)
//        #expect(heater.temperature == 0)
//    }
//
//    @Test("Turning on heater sets heat to maximum")
//    func turnOn() async throws {
//        let heater = Heater(isOn: false, heat: 0)
//
//        try await heater.turnOn()
//
//        #expect(heater.isOn == true)
//        #expect(heater.temperature == 100, "Heater should go to full heat when turned on")
//    }
//
//    @Test("Turning off heater resets heat")
//    func turnOff() async throws {
//        let heater = Heater(isOn: true, heat: 100)
//
//        try await heater.turnOff()
//
//        #expect(heater.isOn == false)
//        #expect(heater.temperature == 0)
//    }
//}

@MainActor
final class HeaterTests: XCTestCase {
    
    func testInitialState() async throws {
        // given
        let heater = Heater(isOn: false, temperature: 0.0, targetTemperature: 0.0, currentTemperature: 0.0)
        // when
        heater.isOn = true
        // then
        XCTAssertTrue(heater.isOn)
        XCTAssertEqual(heater.temperature, heater.minTemperature)
        XCTAssertEqual(heater.targetTemperature, 0.0)
        XCTAssertEqual(heater.currentTemperature, 0.0)
    }
}
