//
//  HeaterControlCard.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 23.03.2026.
//

import SwiftUI

struct HeaterControlCard: View {
    let targetTemperature: Double
    let currentTemperature: Double
    let onTemperatureChange: (Double) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: CardViewIcons.heater.imageName)
                    .font(.title2)
                Text("Temperature Control")
                    .font(.headline)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Current:")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(Int(currentTemperature))°C")
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Text("Target:")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(Int(targetTemperature))°C")
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
            }
            
            HStack {
                Image(systemName: "snowflake")
                    .foregroundColor(.blue)
                Slider(
                    value: Binding(
                        get: { targetTemperature },
                        set: { onTemperatureChange($0) }
                    ),
                    in: 15...30,
                    step: 0.5
                )
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
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
