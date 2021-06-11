//
//  BatteryWidgetBundle.swift
//  BatteryWidgetExtension
//
//  Created by Oleg Komaristy on 02.06.2021.
//

import Foundation
import WidgetKit
import SwiftUI

@main

struct BatteryWidgetBudle: WidgetBundle {
	var body: some Widget {
		BatteryWidget()
		BatteryStatsWidget()
	}
}
