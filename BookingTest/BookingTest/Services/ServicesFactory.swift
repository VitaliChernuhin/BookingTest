//
//  ServicesFactory.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Foundation
import Swinject

// MARK: ServicesFactory
class ServicesFactory {
    
    // MARK: Private properties
    
    private let container: Container
    
    // MARK: Life cycle
    
    private init() {
        self.container = Container()
        self.registerServices()
    }
    
    static let shared = ServicesFactory()
    
    // MARK: Public methods
    
    func service<T: Any>(type: T.Type) -> T {
        guard let service = container.resolve(T.self)
        else {
            fatalError("Unregistered service")
        }
        return service
    }
    
    static func service<T: Any>(type: T.Type) -> T {
        return shared.service(type: type)
    }
}

// MARK: - Register services (private)
private extension ServicesFactory {
    
    func registerServices() {
        registerHotelProvider()
        registerImagesprovider()
    }
    
    func registerHotelProvider() {
        container.register(HotelProviding.self) { _ in
            return HotelProvider()
        }.inObjectScope(.transient)
    }
    
    func registerImagesprovider() {
        container.register(ImagesProviding.self) { _ in
            return ImagesProvider()
        }.inObjectScope(.transient)
    }
}

// MARK: - Make error message (private)
private extension ServicesFactory {
    func makeErrorMessage<T: Any>(type: T.Type) -> String {
        "ServicesFactory -> \(type) resolve error"
    }
}

