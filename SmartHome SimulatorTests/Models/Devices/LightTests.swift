//
//  LightTests.swift
//  SmartHome SimulatorTests
//
//  Created by Zeynep Turnalı on 25.03.2026.
//

//// MARK: - Light Tests
//@Suite("Light Device Tests")
//struct LightTests {
//
//    @Test("Light should start with correct initial state")
//    func initialState() async throws {
//        let light = Light(intensity: 0.0, isOn: false)
//
//        #expect(light.isOn == false)
//        #expect(light.intensity == 0.0)
//    }
//
//    @Test("Turning on light sets default intensity for home device")
//    func turnOnHomeDevice() async throws {
//        let device = DeviceIdentifier(deviceID: UUID(), deviceType: .home)
//        let light = Light(device: device, intensity: 0.0, isOn: false)
//
//        try await light.turnOn()
//
//        #expect(light.isOn == true)
//        #expect(light.intensity == 0.5, "Home device should default to 50% intensity")
//    }
//
//    @Test("Turning off light resets intensity")
//    func turnOff() async throws {
//        let light = Light(intensity: 0.8, isOn: true)
//
//        try await light.turnOff()
//
//        #expect(light.isOn == false)
//        #expect(light.intensity == 0.0)
//    }
//}

import XCTest
@testable import SmartHome_Simulator

@MainActor
final class LightTests: XCTestCase {

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

}
