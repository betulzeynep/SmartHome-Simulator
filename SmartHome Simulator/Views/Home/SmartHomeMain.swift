//
//  SmartHomeMain.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 16.03.2026.
//

import SwiftUI

@MainActor
struct SmartHomeMain: View {
    @State private var light: Light = Light(
        device: DeviceIdentifier(deviceID: UUID(), deviceType: .home),
        intensity: 0.0,
        isOn: false
    )
    @State private var fan: Fan = Fan(device: DeviceIdentifier(deviceID: UUID(), deviceType: .home), isOn: false, speed: 0, isOscillating: false)
    @State private var heater: Heater = Heater(isOn: false, temperature: 0, targetTemperature: 0.0, currentTemperature: 0.0)
    
    // Error handling state
    @State private var errorMessage: String?
    @State private var showError = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                Text("Smart Home Control")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // Device Cards Grid
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ], spacing: 16) {
                    // Light Card
                    DeviceCardView(
                        icon: CardViewIcons.light.imageName,
                        title: "BRIGHTNESS",
                        value: "\(Int(light.intensity * 100))%",
                        isOn: $light.isOn,
                        action: {
                            await toggleLight()
                        }
                    )
                    
                    // Fan Card
                    DeviceCardView(
                        icon: CardViewIcons.fan.imageName,
                        title: "FAN SPEED",
                        value: "\(fan.speed)%",
                        isOn: $fan.isOn,
                        action: {
                            await toggleFan()
                        }
                    )
                    
                    // Heater Card
                    DeviceCardView(
                        icon: CardViewIcons.heater.imageName,
                        title: "HEATER",
                        value: heater.isOn ? "ON" : "OFF",
                        isOn: $heater.isOn,
                        action: {
                            await toggleHeater()
                        }
                    )
                }
                .padding(.horizontal)
                
                // Detailed Controls Section
                VStack(spacing: 20) {
                    if light.isOn {
                        LightControlCard(intensity: light.intensity) { newIntensity in
                            Task {
                                do {
                                    try light.setIntensity(newIntensity)
                                } catch {
                                    handleError(error)
                                }
                            }
                        }
                    }
                    
                    if fan.isOn {
                        FanControlCard(speed: fan.speed) { newSpeed in
                            Task {
                                do {
                                    try fan.setSpeed(newSpeed)
                                } catch {
                                    handleError(error)
                                }
                            }
                        }
                    }
                    
                    if heater.isOn {
                        HeaterControlCard(targetTemperature: heater.targetTemperature, currentTemperature: heater.currentTemperature) { newTemperature in
                            Task {
                                do {
                                    try heater.setTemperature(newTemperature)
                                } catch {
                                    handleError(error)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .alert("Device Error", isPresented: $showError) {
            Button("OK") {
                showError = false
            }
        } message: {
            if let errorMessage {
                Text(errorMessage)
            }
        }
    }
    
    // MARK: - Actions
    private func toggleLight() async {
        do {
            if light.isOn {
                try await light.turnOff()
            } else {
                try await light.turnOn()
            }
        } catch {
            handleError(error)
        }
    }
    
    private func toggleFan() async {
        do {
            if fan.isOn {
                try await fan.turnOff()
            } else {
                try await fan.turnOn()
            }
        } catch {
            handleError(error)
        }
    }
    
    private func toggleHeater() async {
        do {
            if heater.isOn {
                try await heater.turnOff()
            } else {
                try await heater.turnOn()
            }
        } catch {
            handleError(error)
        }
    }
    
    // MARK: - Error Handling
    private func handleError(_ error: Error) {
        if let deviceError = error as? DeviceError {
            errorMessage = deviceError.localizedDescription
        } else {
            errorMessage = error.localizedDescription
        }
        showError = true
    }
}

#Preview {
    SmartHomeMain()
}
