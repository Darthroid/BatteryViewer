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
	var batteries: [InternalBattery]
	
	func imageName(for battery: InternalBattery) -> String {
		if battery.acPowered == true {
			return "battery.100.bolt"
		} else {
			switch battery.charge ?? 0 {
			case 25...75: 	return "battery.25"
			case 76...100: 	return "battery.100"
			default: 		return "battery.0"
			}
		}
	}
	
	var body: some View {
		ForEach(batteries, id: \.self) { battery in
//			VStack {
//				Text(battery.name ?? "")
//					.font(.title)
				Label(
					String(format: "%.0f", battery.charge?.rounded(.up) ?? 0) + "%",
					systemImage: self.imageName(for: battery)
				)
				.font(.title)
//			}
		}
	}
}

struct BatteryWidgetSmall_Previews: PreviewProvider {
	static var previews: some View {
		BatteryWidgetSmall(batteries: [InternalBattery()])
			.previewContext(WidgetPreviewContext(family: .systemSmall))
	}
}
