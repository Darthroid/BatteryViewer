//
//  Battery.swift
//  BatteryReader
//
//  Created by Oleg Komaristy on 19.05.2021.
//

import Foundation

public enum BatteryType: CaseIterable {
	case mac, unknown, none
	
	var imageName: String {
		switch self {
		case .mac: return "laptopcomputer"
		case .unknown: return "questionmark"
		default: return ""
		}
	}
}

public class Battery: Identifiable {
	public var id = UUID()

	public var name: String?
		
	public var acPowered: Bool?
	
	public var isCharging: Bool?
	
	public var isCharged: Bool?
	
	public var currentCapacity: Int?
	
	public var maxCapacity: Int?
	
	public var designCapacity: Int?

	public var timeToFull: Int?
	public var timeToEmpty: Int?

	public var manufacturer: String?
	public var manufactureDate: Date?

	public var cycleCount: Int?
	public var designCycleCount: Int?

	public var amperage: Int?
	public var voltage: Double?
	public var watts: Double?
	public var temperature: Double?
	
	public var type: BatteryType = .none
	
	public var charge: Double? {
		get {
			if let current = self.currentCapacity,
			   let max = self.maxCapacity {
				return (Double(current) / Double(max)) * 100.0
			}

			return nil
		}
	}

	public var health: Double? {
		get {
			if let design = self.designCapacity,
			   let current = self.maxCapacity {
				return (Double(current) / Double(design)) * 100.0
			}

			return nil
		}
	}
	
	public init() {
		//
	}

	public var timeLeft: String {
		get {
			if let isCharging = self.isCharging {
				if let minutes = isCharging ? self.timeToFull : self.timeToEmpty {
					if minutes <= 0 {
						return "-"
					}

					return String(format: "%.2d:%.2d", minutes / 60, minutes % 60)
				}
			}

			return "-"
		}
	}

	public var timeRemaining: Int? {
		get {
			if let isCharging = self.isCharging {
				return isCharging ? self.timeToFull : self.timeToEmpty
			}

			return nil
		}
	}
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(name)
		hasher.combine(manufacturer)
		hasher.combine(manufactureDate)
	}
}
