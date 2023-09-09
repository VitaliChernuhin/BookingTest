//
//  View+CornerRadius.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 09.09.2023.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
