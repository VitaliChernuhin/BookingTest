//
//  ListRowModifier.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//
import SwiftUI

struct ListRowModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .listRowSeparator(.hidden)
        } else {
            content
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemBackground))
                .listStyle(.plain)
        }
        
    }
}
