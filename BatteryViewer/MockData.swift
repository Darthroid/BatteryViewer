//
//  MockData.swift
//  BatteryViewer
//
//  Created by Oleg Komaristy on 25.05.2021.
//

import Foundation
class MockData {
	static func batteryPlaceholder() -> Battery {
		let battery = Battery()
		battery.maxCapacity = 100
		battery.type = BatteryType.allCases.randomElement() ?? .unknown
		battery.currentCapacity = Int.random(in: 0...(battery.maxCapacity ?? 0))
		battery.isCharging = Bool.random()
		battery.acPowered = battery.isCharging
		return battery
	}
	
	static func batteries(count: Int) -> [Battery] {
		var arr = [Battery]()
		for _ in 0...count {
			arr.append(batteryPlaceholder())
		}
		return arr
	}
}

