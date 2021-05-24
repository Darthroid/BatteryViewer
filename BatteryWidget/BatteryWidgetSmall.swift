//
//  BatteryWidgetSmall.swift
//  BatteryWidgetExtension
//
//  Created by Oleg Komaristy on 20.05.2021.
//

import Foundation
import SwiftUI
import WidgetKit

struct BatteryWidgetSmall: View {
	@State var batteries: [InternalBattery]
	
	var columnGrid: [GridItem] = [GridItem](repeating: .init(.flexible()), count: 2)

	func elements() -> [InternalBattery] {
		var elements = batteries
		if elements.count < 4 {
			var arr = [InternalBattery]()
			for _ in 0...(4 - elements.count) {
				arr.append(InternalBattery())
			}
			elements.append(contentsOf: arr)
		}
		
		return Array(elements.prefix(4))
	}
	
	var body: some View {
		if batteries.count > 1 {
			GeometryReader { geometry in
				LazyVGrid(columns: columnGrid, spacing: 8) {
					ForEach(elements()) { battery in
						CircularPercentageView(battery: battery)
							.frame(
								height: (geometry.frame(in: .local).height) / 2
							)
					}
				}
				.frame(
					maxWidth: geometry.frame(in: .local).width,
					maxHeight: geometry.frame(in: .local).height
				)
			}
			.padding(8)
		} else {
			if let battery = batteries.first {
				GeometryReader { geometry in
					VStack(alignment: .leading) {
						HStack(spacing: 8) {
							CircularPercentageView(battery: battery)
							Spacer()
						}
						.frame(height: geometry.frame(in: .local).height / 2)
						Spacer()
						Text(String(format: "%.0f %%", (battery.charge ?? 0)))
							.font(.system(size: 40))
							.fontWeight(.medium)
							.padding(.horizontal, 8)
					}
				}
				.padding(8)
			}
		}
	}
}

struct BatteryWidgetSmall_Previews: PreviewProvider {
	static func batteryPlaceHolder() -> InternalBattery {
		let battery = InternalBattery()
		battery.maxCapacity = 100
		battery.currentCapacity = Int.random(in: 0...(battery.maxCapacity ?? 0))
		battery.isCharging = true
		battery.acPowered = true
		return battery
	}
	
	static var previews: some View {
		BatteryWidgetSmall(batteries: [batteryPlaceHolder(), batteryPlaceHolder()])
			.previewContext(WidgetPreviewContext(family: .systemSmall))
	}
}
