//
//  RoomsProvider.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import Foundation
import Combine
import Moya
import CombineMoya

// MARK: RoomsProviderError
enum RoomsProviderError: Error, MessageRepresentable {
    case serviceIsUnavailable
    
    var message: String {
        switch self {
        case .serviceIsUnavailable:
            return "Сервис не доступен. "
        }
    }
}

// MARK: - RoomsProviding (protocol)
protocol RoomsProviding {
    func requestRooms() -> AnyPublisher<[Room], RoomsProviderError>
}

// MARK: - ProomsProvider
final class RoomsProvider: RoomsProviding {
    
    private let provider = MoyaProvider<API>()
    
    func requestRooms() -> AnyPublisher<[Room], RoomsProviderError> {
        Deferred {
            self.provider
                .requestPublisher(.rooms)
                .map([Room].self)
                .mapError { moyaError -> RoomsProviderError in
                    return .serviceIsUnavailable
                }
        }.eraseToAnyPublisher()
    }
}
