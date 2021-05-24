//
//  BatteryProvider.swift
//  BatteryViewer
//
//  Created by Oleg Komaristy on 20.05.2021.
//

import Foundation
import WidgetKit
import SwiftUI

struct BatteryProvider: TimelineProvider {
	func placeholder(in context: Context) -> BatteryEntry {
		BatteryEntry(batteries: [])
	}

	func getSnapshot(in context: Context, completion: @escaping (BatteryEntry) -> ()) {
		var batteries = [InternalBattery]()
		if let battery = InternalFinder().getInternalBattery() {
			batteries.append(battery)
			let entry = BatteryEntry(batteries: batteries)
			completion(entry)
		}
	}

	func getTimeline(in context: Context, completion: @escaping (Timeline<BatteryEntry>) -> ()) {
		var entries: [BatteryEntry] = []

		#if DEBUG
		/// Widget will refresh every `5 minutes`
		let refresh = Calendar.current.date(byAdding: .minute, value: 5, to: Date()) ?? Date()

		#else
		/// Widget will refresh every `15 minutes`
		let refresh = Calendar.current.date(byAdding: .minute, value: 15, to: Date()) ?? Date()
		#endif
		
		var batteries = [InternalBattery]()
		if let battery = InternalFinder().getInternalBattery() {
			batteries.append(battery)
			let entry = BatteryEntry(batteries: batteries)
			entries.append(entry)
			let timeline = Timeline(entries: entries, policy: .after(refresh))
			completion(timeline)
		}
	}
}
