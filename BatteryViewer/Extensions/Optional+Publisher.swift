//
//  Optional.swift
//  BatteryViewer
//
//  Created by Oleg Komaristy on 01.06.2021.
//

import Foundation
import Combine

extension Optional where Wrapped: Combine.Publisher {
	func orEmpty() -> AnyPublisher<Wrapped.Output, Wrapped.Failure> {
		self?.eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
	}
}
