//
//  BatteryEntry.swift
//  BatteryViewer
//
//  Created by Oleg Komaristy on 20.05.2021.
//

import Foundation
import WidgetKit

struct BatteryEntry: TimelineEntry {
	let date: Date = .init()
	let batteries: [InternalBattery]
}
