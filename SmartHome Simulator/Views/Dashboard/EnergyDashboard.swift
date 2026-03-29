//
//  EnergyDashboard.swift
//  SmartHome Simulator
//
//  Created by Zeynep Turnalı on 23.03.2026.
//

import SwiftUI

/// Dashboard showing real-time energy consumption and cost estimates
struct EnergyDashboard: View {
    let devices: [any EnergyTracking]
    
    private var totalConsumption: Double {
        devices.reduce(0) { $0 + $1.energyConsumption }
    }
    
    private var totalCostPerHour: Double {
        devices.reduce(0) { $0 + $1.estimatedCostPerHour }
    }
    
    private var dailyCost: Double {
        totalCostPerHour * 24
    }
    
    private var monthlyCost: Double {
        dailyCost * 30
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Image(systemName: "bolt.fill")
                    .font(.title2)
                    .foregroundColor(.yellow)
                Text("Energy Monitor")
                    .font(.headline)
                Spacer()
            }
            
            // Current Power Usage
            VStack(alignment: .leading, spacing: 8) {
                Text("Current Power Usage")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(String(format: "%.1f", totalConsumption))
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text("W")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
            
            Divider()
            
            // Cost Estimates
            VStack(spacing: 12) {
                CostRow(
                    label: "Hourly Cost",
                    value: totalCostPerHour,
                    icon: "clock"
                )
                
                CostRow(
                    label: "Daily Estimate",
                    value: dailyCost,
                    icon: "sun.max"
                )
                
                CostRow(
                    label: "Monthly Estimate",
                    value: monthlyCost,
                    icon: "calendar"
                )
            }
            
            // Device Breakdown
            if !devices.isEmpty {
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Active Devices")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    ForEach(Array(devices.enumerated()), id: \.offset) { _, device in
                        if device.energyConsumption > 0 {
                            DeviceEnergyRow(device: device)
                        }
                    }
                }
            }
            
            // Energy Saving Tips
            if totalConsumption > 1000 {
                EnergyTipCard(
                    message: "Your devices are consuming significant power. Consider turning off unused devices to save energy."
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
        )
    }
}

// MARK: - Supporting Views

struct CostRow: View {
    let label: String
    let value: Double
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.secondary)
                .frame(width: 20)
            
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(String(format: "$%.2f", value))
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
    }
}

struct DeviceEnergyRow: View {
    let device: any EnergyTracking
    
    private var deviceName: String {
        let typeName = String(describing: type(of: device))
        return typeName.replacingOccurrences(of: "__lldb_expr_", with: "")
    }
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.green)
                .frame(width: 8, height: 8)
            
            Text(deviceName)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text("\(Int(device.energyConsumption))W")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
    }
}

struct EnergyTipCard: View {
    let message: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "lightbulb.fill")
                .foregroundColor(.yellow)
            
            Text(message)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.yellow.opacity(0.1))
        )
    }
}

// MARK: - Preview
#Preview("Energy Dashboard - Active Devices") {
    VStack {
        EnergyDashboard(devices: [
            Fan(device: DeviceIdentifier(deviceID: UUID(), deviceType: .home), isOn: true, speed: 75, isOscillating: true),
            Heater(isOn: true, temperature: 100, targetTemperature: 22, currentTemperature: 20)
        ])
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Energy Dashboard - Low Usage") {
    VStack {
        EnergyDashboard(devices: [
            Fan(device: DeviceIdentifier(deviceID: UUID(), deviceType: .home), isOn: true, speed: 30, isOscillating: false)
        ])
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Energy Dashboard - No Devices") {
    VStack {
        EnergyDashboard(devices: [])
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
