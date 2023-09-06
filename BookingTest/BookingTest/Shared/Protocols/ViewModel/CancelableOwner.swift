//
//  CancelableOwner.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Combine

protocol CancelableOwner: AnyObject {
    var cancellables: Set<AnyCancellable> { get }
}
