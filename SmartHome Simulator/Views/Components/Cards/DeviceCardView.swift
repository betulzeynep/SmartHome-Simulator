//
//  DeviceCardView.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 18.03.2026.
//

import SwiftUI

/// A generic card view for displaying device status in a smart home interface
/// Matches the design shown in the mockup with icon, title, and value
struct DeviceCardView: View {
    let icon: String
    let title: String
    let value: String
    @Binding var isOn: Bool
    let action: () async -> Void
    
    var body: some View {
        Button {
            Task {
                await action()
            }
        } label: {
            VStack(spacing: 16) {
                // Icon with circular background
                ZStack {
                    Circle()
                        .fill(isOn ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: icon)
                        .font(.system(size: 28))
                        .foregroundColor(isOn ? .blue : .gray)
                }
                
                VStack(spacing: 4) {
                    // Title
                    Text(title)
                        .font(.custom("Avenir", size: 11))
                        .foregroundColor(.gray)
                        .textCase(.uppercase)
                        .tracking(0.5)
                    
                    // Value
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(value)
                            .font(.custom("Avenir", size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        // Optional indicator
                        if isOn {
                            Image(systemName: "power.circle.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            .frame(width: CardViewDimensions.cardAndImageWidth, height: CardViewDimensions.cardHeight)
            .background(
                RoundedRectangle(cornerRadius: CardViewDimensions.cornerRadius * 3)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview("Device Cards") {
    VStack(spacing: 20) {
        HStack(spacing: 16) {
            DeviceCardView(
                icon: "lamp.ceiling.inverse",
                title: "BRIGHTNESS",
                value: "68%",
                isOn: .constant(true),
                action: {}
            )
            
            DeviceCardView(
                icon: "thermometer.medium",
                title: "TEMPERATURE",
                value: "72°",
                isOn: .constant(true),
                action: {}
            )
        }
        
        DeviceCardView(
            icon: "fan",
            title: "FAN SPEED",
            value: "45%",
            isOn: .constant(false),
            action: {}
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
