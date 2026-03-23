//
//  Switchable.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//

protocol Switchable {
    var isOn: Bool { get set }
    func turnOn() async throws -> Void
    func turnOff() async throws -> Void
}

extension Switchable {
    func toggle() async throws {
        isOn ? try await turnOff() : try await turnOn()
    }
}
