//
//  HotelProvider.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Foundation
import Combine
import Moya
import CombineMoya

// MARK: HotelProviderError
enum HotelProviderError: Error {
    
}

// MARK: - HotelProviding (protocol)
protocol HotelProviding {
    func requestHotel() -> AnyPublisher<Hotel, HotelProviderError>
}

// MARK: - HotelProvider
final class HotelProvider: HotelProviding {
    
    private let provider = 
    
    func requestHotel() -> AnyPublisher<Hotel, HotelProviderError> {
        
    }
    
    
}
