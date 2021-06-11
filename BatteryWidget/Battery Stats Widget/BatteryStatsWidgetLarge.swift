//
//  BatteryStatsWidgetLarge.swift
//  BatteryWidgetExtension
//
//  Created by Oleg Komaristy on 02.06.2021.
//


import Foundation
import SwiftUI
import WidgetKit

struct BatteryStatsWidgetLarge: View {
	@State var battery: Battery
	
	func stack(_ title: String, _ value: String) -> some View {
		HStack {
			Text(title)
				.font(.headline)
				.fontWeight(.medium)
			Spacer()
			Text(value)
		}
	}
	
	var body: some View {
		GeometryReader { geometry in
			VStack(spacing: 8) {
				if let charge = battery.charge {
					ProgressBar(value: charge, title: "Current charge")
						.frame(height: 32)
						.padding(.bottom, 8)
				}
				if let health = battery.health {
					ProgressBar(value: health, title: "Health")
						.frame(height: 32)
						.padding(.bottom, 8)
				}
				if let cycles = battery.cycleCount {
					stack(
						"Cycles count:",
						"\(cycles)" + (battery.designCycleCount != nil ? " / \(battery.designCycleCount ?? 0)" : "")
					)
				}
				if let currentCapacity = battery.currentCapacity {
					stack(
						"Current capacity:",
						"\(currentCapacity)" + (battery.maxCapacity != nil ? " / \(battery.maxCapacity ?? 0)" : "") + " " + "mAh"
					)
				}
				if let designCapacity = battery.designCapacity {
					stack("Designed capacity:", String(format: "%d mAh%", designCapacity))
				}
				if let watts = battery.watts {
					stack("Discharging wattage:", String(format: "%.1f W%", watts))
				}
				if let voltage = battery.voltage {
					stack("Voltage:", String(format: "%.1f V%", voltage))
				}
				if let temperature = battery.temperature {
					stack("Temperature:", String(format: "%.1f ℃%", temperature))
				}
			}
		}
		.padding(16)
	}
}

struct BatteryStatsWidgetLarge_Previews: PreviewProvider {
	static var previews: some View {
		BatteryStatsWidgetLarge(battery: MockData.batteryPlaceholder())
			.previewContext(WidgetPreviewContext(family: .systemLarge))
	}
}
