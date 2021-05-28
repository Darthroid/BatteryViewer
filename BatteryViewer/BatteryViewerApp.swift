//
//  BatteryViewerApp.swift
//  BatteryViewer
//
//  Created by Oleg Komaristy on 20.05.2021.
//

import SwiftUI

@main
struct BatteryViewerApp: App {
    var body: some Scene {
        WindowGroup {
			if let battery = InternalFinder().getInternalBattery() {
				ContentView(batteries: [battery])
					.frame(minWidth: 400, minHeight: 300)
//					.frame(maxWidth: .infinity, maxHeight: .infinity)
			} else {
				ContentView(batteries: [])
					.frame(minWidth: 400, minHeight: 300)
//					.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
        }
    }
}
