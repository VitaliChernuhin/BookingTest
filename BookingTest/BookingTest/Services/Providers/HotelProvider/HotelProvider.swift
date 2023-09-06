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
enum HotelProviderError: Error, MessageRepresentable {
    case serviceIsUnavailable
    
    var message: String {
        switch self {
        case .serviceIsUnavailable:
            return "Сервис не доступен. "
        }
    }
}

// MARK: - HotelProviding (protocol)
protocol HotelProviding {
    func requestHotel() -> AnyPublisher<Hotel, HotelProviderError>
}

// MARK: - HotelProvider
final class HotelProvider: HotelProviding {
    
    private let provider = MoyaProvider<API>()
    
    func requestHotel() -> AnyPublisher<Hotel, HotelProviderError> {
        Deferred {
            self.provider
                .requestPublisher(.hotel)
                .map(Hotel.self)
                .mapError { moyaError -> HotelProviderError in
                    return .serviceIsUnavailable
                }
        }.eraseToAnyPublisher()
    }
    
}
