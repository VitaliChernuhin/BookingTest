//
//  RoomDetailView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 12.09.2023.
//

import SwiftUI

// MARK: RoomDetailView
struct RoomDetailView: View {
    var body: some View {
        HStack(spacing: 2) {
            Text("Подробнее о номере")
                .foregroundColor(Color("RoomDetailForeground"))
                .font(Fonts.regular(size: 18).font)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
            
            Image("leftBlueArrow")
        }
        .background(Color("RoomDetailBackground"))
        .cornerRadius(5, corners: .allCorners)
    }
}

// MARK: - Preview
struct RoomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetailView()
    }
}
