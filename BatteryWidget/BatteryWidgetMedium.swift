//
//  BatteryWidgetMedium.swift
//  BatteryWidgetExtension
//
//  Created by Oleg Komaristy on 26.05.2021.
//

import Foundation
import WidgetKit
import SwiftUI

struct BatteryWidgetMedium: View {
	@State var batteries: [Battery]
	
	var columnGrid: [GridItem] = [GridItem](repeating: .init(.flexible()), count: 1)

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
		GeometryReader { geometry in
			LazyHGrid(rows: columnGrid, alignment: .center, spacing: 8) {
				ForEach(elements()) { battery in
					VStack(alignment: .center, spacing: 8) {
						CircularPercentageView(battery: battery)
							.frame(
								height: (geometry.frame(in: .local).height) / 2
							)
						Text(
							battery.charge != nil ? (String(format: "%.0f %%", (battery.charge ?? 0))) : " "
						)
						.font(.system(size: 17))
						.fontWeight(.medium)
					}
				}
			}
			.frame(
				maxWidth: geometry.frame(in: .local).width,
				maxHeight: geometry.frame(in: .local).height
			)
		}
		.padding(8)
	}
}

struct BatteryWidgetMedium_Previews: PreviewProvider {
	static var previews: some View {
		BatteryWidgetMedium(batteries: [MockData.batteryPlaceholder()])
			.previewContext(WidgetPreviewContext(family: .systemMedium))
	}
}
