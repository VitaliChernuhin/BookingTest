//
//  CurrencyFormatter.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 12.09.2023.
//

import Foundation

struct CurrencyFormater {
    
    private init() {}
    
    static var formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.groupingSeparator = " "
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSize = 3
        numberFormatter.locale = Locale(identifier: "ru_RU")
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }()
    
    static func format(_ currency: Double) -> String {
        Self.formatter.string(from: NSNumber(value: currency)) ?? ""
    }
}
