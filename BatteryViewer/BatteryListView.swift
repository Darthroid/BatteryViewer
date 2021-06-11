//
//  ContentView.swift
//  BatteryViewer
//
//  Created by Oleg Komaristy on 20.05.2021.
//

import SwiftUI
import WidgetKit
import Combine

struct BatteryListView: View {
	@ObservedObject var viewModel = InternalBatteryInfoViewModel()
	
	func stack(_ title: String, _ value: String) -> some View {
		HStack {
			Text(title)
				.font(.headline)
				.fontWeight(.medium)
			Spacer()
			Text(value)
		}
	}
	
	var header: some View {
		HStack(alignment: .center,spacing: 16) {
			Image(systemName: viewModel.macIconName)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 50, height: 50)
			
			VStack(alignment: .leading, spacing: 4) {
				Text(InternalFinder().getMacName())
					.font(.title2)
					.foregroundColor(.primary)
					.fontWeight(.medium)
				
				Text(InternalFinder().getMacModelID())
					.font(.title3)
					.foregroundColor(.secondary)
			}
			Spacer()
		}
		.padding(.horizontal, 16)
		.padding(.vertical, 8.0)
	}
	
	var batteryStats: some View {
		VStack(alignment: .leading, spacing: 4) {
			Text("Last update: \(Date())")
			if let charge = viewModel.battery?.charge {
				ProgressBar(value: charge, title: "Current charge")
					.frame(height: 32)
					.padding(.bottom, 8)
			}
			if let health = viewModel.battery?.health {
				ProgressBar(value: health, title: "Health")
					.frame(height: 32)
					.padding(.bottom, 8)
			}
			if let cycles = viewModel.battery?.cycleCount {
				stack(
					"Cycles count:",
					"\(cycles)" + (viewModel.battery?.designCycleCount != nil ? " / \(viewModel.battery?.designCycleCount ?? 0)" : "")
				)
			}
			if let currentCapacity = viewModel.battery?.currentCapacity {
				stack(
					"Current capacity:",
					"\(currentCapacity)" + (viewModel.battery?.maxCapacity != nil ? " / \(viewModel.battery?.maxCapacity ?? 0)" : "") + " " + "mAh"
				)
			}
			if let designCapacity = viewModel.battery?.designCapacity {
				stack("Designed capacity:", String(format: "%d mAh%", designCapacity))
			}
			if let watts = viewModel.battery?.watts {
				stack("Discharging wattage:", String(format: "%.1f W%", watts))
			}
			if let voltage = viewModel.battery?.voltage {
				stack("Voltage:", String(format: "%.1f V%", voltage))
			}
			if let temperature = viewModel.battery?.temperature {
				stack("Temperature:", String(format: "%.1f ℃%", temperature))
			}
		}
		.padding(16)
	}
	
    var body: some View {
		VStack(spacing: 0) {
			header
			Divider()
			if viewModel.battery != nil {
				batteryStats
				Spacer()
			} else {
				Spacer()
				Text("Battery stats unvavailable")
					.font(.title2)
					.foregroundColor(.secondary)
				Spacer()
			}
			
		}
		.onAppear(perform: viewModel.startTimer)
		.onDisappear(perform: viewModel.stopTimer)
		.onReceive(viewModel.timerPublisher.orEmpty(), perform: { _ in
			WidgetCenter.shared.reloadAllTimelines()
		})
    }
}

struct BatteryListView_Previews: PreviewProvider {
    static var previews: some View {
		BatteryListView()
    }
}
