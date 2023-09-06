//
//  Fonts.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import SwiftUI

enum Fonts {
    case regular(size: Double)
    
    var font: Font {
        switch self {
        case .regular(size: let size):
            return Font.custom("SF-Pro-Display-Regular", size: CGFloat(size))
        }
    }
}
