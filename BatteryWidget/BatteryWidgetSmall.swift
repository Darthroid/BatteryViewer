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
	@State var batteries: [Battery]
	
	var columnGrid: [GridItem] = [GridItem](repeating: .init(.flexible()), count: 2)

	func elements() -> [Battery] {
		var elements = batteries
		if elements.count < 4 {
			var arr = [Battery]()
			for _ in 0...(4 - elements.count) {
				arr.append(Battery())
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
//						CircularPercentageView(battery: battery)
						CircularPercentageView(
							value: battery.charge ?? 0,
							iconName: battery.type.imageName,
							isCharging: battery.acPowered == true || battery.isCharging == true
						)
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
							CircularPercentageView(
								value: battery.charge ?? 0,
								iconName: battery.type.imageName,
								isCharging: battery.acPowered == true || battery.isCharging == true
							)
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
	static var previews: some View {
		BatteryWidgetSmall(batteries: [MockData.batteryPlaceholder()])
			.previewContext(WidgetPreviewContext(family: .systemSmall))
		
		BatteryWidgetSmall(batteries: MockData.batteries(count: Int.random(in: 2...4)))
			.previewContext(WidgetPreviewContext(family: .systemSmall))
	}
}
