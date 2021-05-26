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
	
	var chargingIcon: some View {
		ZStack {
			GeometryReader { geometry in
				if battery.isCharging == true {
					Image(systemName: "bolt.fill")
						.position(x: geometry.size.width / 2, y: 0)
				} else {
					EmptyView()
				}
			}
		}
	}
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				Circle()
					.stroke(lineWidth: 6.0)
					.opacity(0.3)
					.foregroundColor(Color.secondary)
					.aspectRatio(contentMode: .fit)
				
				Circle()
					.trim(from: 0.0, to: CGFloat(min((battery.charge ?? 0) / 100.0, 1.0)))
					.stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
					.foregroundColor(self.color())
					.rotationEffect(Angle(degrees: 270.0))
					.aspectRatio(contentMode: .fit)
				
				VStack {
					Spacer()
					image(frame: geometry.frame(in: .local))
					Spacer()
				}
				chargingIcon
			}
		}
		.padding(8)
		.aspectRatio(contentMode: .fit)
	}
}

struct CircularPercentageView_Previews: PreviewProvider {
	static var previews: some View {
		CircularPercentageView(battery: MockData.batteryPlaceholder())
			.previewLayout(.fixed(width: 100.0, height: 100.0))
	}
}
