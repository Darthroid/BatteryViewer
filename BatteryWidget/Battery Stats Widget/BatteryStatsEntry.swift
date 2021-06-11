//
//  BatteryStatsEntry.swift
//  BatteryWidgetExtension
//
//  Created by Oleg Komaristy on 02.06.2021.
//

import Foundation
import WidgetKit

struct BatteryStatsEntry: TimelineEntry {
	let date: Date = .init()
	let battery: Battery
}
