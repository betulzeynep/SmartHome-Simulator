//
//  FanControlCard.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 23.03.2026.
//

import SwiftUI

/// Detailed fan control card with speed slider and presets
struct FanControlCard: View {
    let speed: Int
    let onSpeedChange: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: CardViewIcons.fan.imageName)
                    .font(.title2)
                Text("Fan Speed")
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Image(systemName: "tortoise")
                    .foregroundColor(.gray)
                Slider(
                    value: Binding(
                        get: { Double(speed) },
                        set: { newValue in
                            onSpeedChange(Int(newValue))
                        }
                    ),
                    in: 0...100,
                    step: 1
                )
                Image(systemName: "hare.fill")
                    .foregroundColor(.blue)
                Text("\(speed)%")
                    .frame(width: 45)
                    .fontWeight(.semibold)
            }
            
            // Speed presets
            HStack(spacing: 12) {
                Text("Presets:")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                ForEach([("Low", 33), ("Med", 66), ("High", 100)], id: \.0) { preset in
                    Button(preset.0) {
                        onSpeedChange(preset.1)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
        )
    }
}

// MARK: - Preview
#Preview("Fan Control Card") {
    FanControlCard(
        speed: 45,
        onSpeedChange: { _ in }
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
