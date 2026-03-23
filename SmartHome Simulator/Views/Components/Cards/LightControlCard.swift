//
//  LightControlCard.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 23.03.2026.
//

import SwiftUI

/// Detailed light control card with intensity slider
struct LightControlCard: View {
    let intensity: Double
    let onIntensityChange: (Double) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: CardViewIcons.light.imageName)
                    .font(.title2)
                Text("Light Intensity")
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Image(systemName: "sun.min")
                    .foregroundColor(.gray)
                Slider(
                    value: Binding(
                        get: { intensity },
                        set: { newValue in
                            onIntensityChange(newValue)
                        }
                    ),
                    in: 0...1
                )
                Image(systemName: "sun.max.fill")
                    .foregroundColor(.yellow)
                Text("\(Int(intensity * 100))%")
                    .frame(width: 45)
                    .fontWeight(.semibold)
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
#Preview("Light Control Card") {
    LightControlCard(
        intensity: 0.68,
        onIntensityChange: { _ in }
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
