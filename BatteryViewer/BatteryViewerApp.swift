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
			BatteryListView()
				.frame(minWidth: 400, minHeight: 300)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
