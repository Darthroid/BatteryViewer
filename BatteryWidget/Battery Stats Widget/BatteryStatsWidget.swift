//
//  BatteryStatsWidget.swift
//  BatteryWidgetExtension
//
//  Created by Oleg Komaristy on 02.06.2021.
//

import Foundation
import WidgetKit
import SwiftUI

struct BatteryStatsWidgetEntryView : View {
	var entry: BatteryStatsProvider.Entry

	@Environment(\.widgetFamily) private var family
	var body : some View {
		Group {
			switch family {
			case .systemLarge:
				BatteryStatsWidgetLarge(battery: entry.battery)
			@unknown default:
				BatteryStatsWidgetLarge(battery: entry.battery)
			}
		}
	}
}


struct BatteryStatsWidget: Widget {
	let kind: String = "BatteryStatsWidget"

	var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: BatteryStatsProvider()) { entry in
			BatteryStatsWidgetEntryView(entry: entry)
		}
		.configurationDisplayName("Battery stats widget")
		.description("Shows info about internal battery.")
		.supportedFamilies([.systemLarge])
	}
}
