//
//  BatteryWidget.swift
//  BatteryWidget
//
//  Created by Oleg Komaristy on 20.05.2021.
//
import WidgetKit
import SwiftUI

@main

struct BatteryWidgetBudle: WidgetBundle {
	var body: some Widget {
		BatteryWidget()
	}
}

struct BatteryWidgetEntryView : View {
	var entry: BatteryProvider.Entry

	@Environment(\.widgetFamily) private var family
	var body : some View {
		Group {
			switch family {
			case .systemSmall:
				BatteryWidgetSmall(batteries: entry.batteries)
			case .systemMedium:
				BatteryWidgetMedium(batteries: entry.batteries)
//			case .systemLarge:
//				BatteryWidgetSmall(batteries: entry.batteries)
			@unknown default:
				BatteryWidgetSmall(batteries: entry.batteries)
			}
		}
	}
}


struct BatteryWidget: Widget {
	let kind: String = "BatteryWidget"

	var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: BatteryProvider()) { entry in
			BatteryWidgetEntryView(entry: entry)
		}
		.configurationDisplayName("Battery widget")
		.description("Shows info about internal battery.")
		.supportedFamilies([.systemSmall,.systemMedium/*, .systemLarge*/])
	}
}
