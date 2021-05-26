//
//  InternalBattery.swift
//  BatteryReader
//
//  Created by Oleg Komaristy on 19.05.2021.
//

import Foundation
import IOKit.ps

public protocol BatteryProtocol: AnyObject {
	var acPowered: Bool? { get set }
	var isCharging: Bool? { get set }
	var isCharged: Bool? { get set }
	var charge: Double? { get }
	var currentCapacity: Int? { get set }
	var maxCapacity: Int? { get set }
	var designCapacity: Int? { get set }
	var type: BatteryType { get set }
}

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

public class Battery: BatteryProtocol, Identifiable, Hashable {
	public var id = UUID()
	
	public var acPowered: Bool?

	public var isCharging: Bool?
	
	public var isCharged: Bool?
		
	public var currentCapacity: Int?
	
	public var maxCapacity: Int?
	
	public var designCapacity: Int?
	
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
	
	public init() { }
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(acPowered)
		hasher.combine(charge)
		hasher.combine(isCharged)
		hasher.combine(isCharging)
	}
	
	public static func == (lhs: Battery, rhs: Battery) -> Bool {
		return lhs.id == rhs.id
	}
}

public class InternalBattery: Battery {
	public var name: String?

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
	
	override public init() {
		super.init()
		self.type = .mac
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
	
	public override func hash(into hasher: inout Hasher) {
		super.hash(into: &hasher)
		hasher.combine(name)
		hasher.combine(manufacturer)
		hasher.combine(manufactureDate)
	}
}
