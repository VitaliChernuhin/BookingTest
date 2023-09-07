//
//  DebugLoging.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 07.09.2023.
//

protocol DebugLoging {
    var source: String { get }
    func log(message: String, method: String?)
}

extension DebugLoging {
    var source: String {
        String(describing: Self.self)
    }
    
    func log(message: String, method: String? = nil) {
        #if DEBUG
        if let method = method {
            print("\n\(source)->\(method)-> \(message)")
        } else {
            print("\n\(source)-> \(message)")
        }
        #endif
    }
}
