//
//  BatteryStatsProvider.swift
//  BatteryWidgetExtension
//
//  Created by Oleg Komaristy on 02.06.2021.
//

import Foundation
import WidgetKit
import SwiftUI

struct BatteryStatsProvider: TimelineProvider {
	func placeholder(in context: Context) -> BatteryStatsEntry {
		BatteryStatsEntry(battery: Battery())
	}

	func getSnapshot(in context: Context, completion: @escaping (BatteryStatsEntry) -> ()) {
		if let battery = InternalFinder().getInternalBattery() {
			let entry = BatteryStatsEntry(battery: battery)
			completion(entry)
		}
	}

	func getTimeline(in context: Context, completion: @escaping (Timeline<BatteryStatsEntry>) -> ()) {
		var entries: [BatteryStatsEntry] = []

		#if DEBUG
		/// Widget will refresh every `5 minutes`
		let refresh = Calendar.current.date(byAdding: .minute, value: 5, to: Date()) ?? Date()

		#else
		/// Widget will refresh every `15 minutes`
		let refresh = Calendar.current.date(byAdding: .minute, value: 15, to: Date()) ?? Date()
		#endif
		
		if let battery = InternalFinder().getInternalBattery() {
			let entry = BatteryStatsEntry(battery: battery)
			entries.append(entry)
			let timeline = Timeline(entries: entries, policy: .after(refresh))
			completion(timeline)
		}
	}
}
