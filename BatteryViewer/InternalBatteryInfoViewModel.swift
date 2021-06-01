//
//  BatteryListViewModel.swift
//  BatteryViewer
//
//  Created by Oleg Komaristy on 28.05.2021.
//

import Foundation
import Combine

class InternalBatteryInfoViewModel: ObservableObject {
	@Published var battery: Battery?
	@Published var macName: String
	
	var timerPublisher: Timer.TimerPublisher?
	var timerCancellable: AnyCancellable?
	
	#if DEBUG
	let refreshInterval = 5.0
	#else
	let refreshInterval = 30.0
	#endif
	
	var macIconName: String {
		if macName.contains("iMac") {
			return "desctopcomputer"
		} else if macName.contains("MacBook") {
			return "laptopcomputer"
		}
		return "questionmark"
	}

	init() {
		let internalFinder = InternalFinder()
		self.macName = internalFinder.getMacName()
		self.battery = internalFinder.getInternalBattery()
	}
	
	deinit {
		self.timerCancellable?.cancel()
	}
	
	func startTimer() {
		timerPublisher = Timer.TimerPublisher(interval: self.refreshInterval, tolerance: 0.5, runLoop: .main, mode: .default)
		
		timerCancellable = timerPublisher?
			.autoconnect()
			.receive(on: RunLoop.main)
			.merge(with: Just(Date()))	// trigger first event instantly
			.map { _ in InternalFinder().getInternalBattery() }
			.assign(to: \InternalBatteryInfoViewModel.battery, on: self)
	}
	
	func stopTimer() {
		self.timerCancellable?.cancel()
	}
}
