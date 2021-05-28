//
//  ProgressBar.swift
//  BatteryViewer
//
//  Created by Oleg Komaristy on 28.05.2021.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
	@State var value: Double
	@State var title: String?
	
	var color: Color {
		switch value {
		case 0...20: return .red
		default: return .green
		}
	}
	
	var progressView: some View {
		GeometryReader { geometry in
			ZStack(alignment: .leading) {
				Rectangle()
					.frame(width: geometry.size.width , height: geometry.size.height)
					.opacity(0.3)
					.foregroundColor(Color.secondary)
				
				Rectangle()
					.frame(width: min(CGFloat(self.value / 100)*geometry.size.width, geometry.size.width), height: geometry.size.height)
					.foregroundColor(color)
					.animation(.linear)
			}
			.cornerRadius(45.0)
		}
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 4) {
			if let title = self.title {
				Text(title)
					.font(.headline)
					.fontWeight(.medium)
			}
			HStack {
				progressView
				Text((String(format: "%.0f %%", value)))
			}
		}
		.padding(.bottom)
	}
}

struct ProgressBar_Previews: PreviewProvider {
	static var previews: some View {
		ProgressBar(value: Double.random(in: 0...100), title: "Sample text")
			.previewLayout(.fixed(width: 375, height: 44))
	}
}
