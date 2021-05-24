//
//  CircularPercentageView.swift
//  BatteryViewer
//
//  Created by Oleg Komaristy on 21.05.2021.
//

import SwiftUI

struct CircularPercentageView: View {
	var battery: Battery
	
	func color() -> Color {
		switch battery.charge ?? 0 {
		case 0...20: return .red
		default: return .green
		}
	}
	
	func image(frame: CGRect) -> some View {
		return Image(systemName: battery.type.imageName)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(
				width: frame.width / 2,
				height: frame.height / 2
			)
	}
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				Circle()
					.stroke(lineWidth: 8.0)
					.opacity(0.3)
					.foregroundColor(Color.secondary)
					.aspectRatio(contentMode: .fit)
				
				Circle()
					.trim(from: 0.0, to: CGFloat(min((battery.charge ?? 0) / 100.0, 1.0)))
					.stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
					.foregroundColor(self.color())
					.rotationEffect(Angle(degrees: 270.0))
					.aspectRatio(contentMode: .fit)
				
				VStack {
					if battery.isCharging == true {
						Image(systemName: "bolt.fill")
							.padding(-8)
					}
					Spacer()
					image(frame: geometry.frame(in: .local))
					Spacer()
				}
			}
		}
		.padding(8)
		.aspectRatio(contentMode: .fit)
	}
}

struct CircularPercentageView_Previews: PreviewProvider {
	
	static func batteryPlaceHolder() -> Battery {
		let battery = InternalBattery()
		battery.maxCapacity = 100
		battery.currentCapacity = Int.random(in: 0...(battery.maxCapacity ?? 0))
		battery.isCharging = true
		battery.acPowered = true
		return battery
	}
	
	static var previews: some View {
		CircularPercentageView(battery: batteryPlaceHolder())
			.previewLayout(.fixed(width: 100.0, height: 100.0))
	}
}
