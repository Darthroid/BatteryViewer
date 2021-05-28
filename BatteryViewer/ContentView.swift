//
//  ContentView.swift
//  BatteryViewer
//
//  Created by Oleg Komaristy on 20.05.2021.
//

import SwiftUI

struct ContentView: View {
	@State var batteries: [Battery]
	
	// TODO: - move to viewModel
	var macIconName: String {
		let name = InternalFinder().getMacName()
		if name.contains("iMac") {
			return "desctopcomputer"
		} else if name.contains("MacBook") {
			return "laptopcomputer"
		}
		return "questionmark"
	}
	
	var header: some View {
		HStack(spacing: 16) {
			Image(systemName: macIconName)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 50, height: 50)
			
			VStack(alignment: .leading, spacing: 4) {
				Text(InternalFinder().getMacName())
					.font(.title2)
					.fontWeight(.medium)
				
				Text(InternalFinder().getMacModelID())
					.font(.title3)
			}
			Spacer()
		}
		.padding(16)
	}
	
	var batteryList: some View {
		List {
			ForEach(batteries) { battery in
				VStack(alignment: .leading) {
					Text(battery.name ?? "")
					if let charge = battery.charge {
						ProgressBar(value: charge, title: "Current charge")
					}
					if let health = battery.health {
						ProgressBar(value: health, title: "Health")
					}
					if let cycles = battery.cycleCount {
						Text("Cycles count: \(cycles)" + (battery.designCycleCount != nil ? " / \(battery.designCycleCount ?? 0)" : ""))
					}
					if let currentCapacity = battery.currentCapacity {
						Text("Current capacity: \(currentCapacity)" + (battery.maxCapacity != nil ? " / \(battery.maxCapacity ?? 0)" : "") + " " + "mAh")
					}
					if let designCapacity = battery.designCapacity {
						Text("Designed capacity: \(designCapacity) mAh")
					}
				}
			}
		}
	}
	
    var body: some View {
		VStack {
			header
			batteryList
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView(batteries: [MockData.batteryPlaceholder()])
    }
}
