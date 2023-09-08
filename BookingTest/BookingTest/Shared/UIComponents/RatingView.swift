//
//  RatingView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 07.09.2023.
//

import SwiftUI

// MARK: RatingView
struct RatingView: View {
    
    @Binding var rate: String
    
    var body: some View {
        HStack(spacing: 2) {
            Image("star")
                .frame(width: 15, height: 15)
                .padding(EdgeInsets(top: 7,leading: 10, bottom: 7, trailing: 0))
            Text(rate)
                .foregroundColor(Color("RatingForegroundColor"))
                .font(Fonts.regular(size: 18).font)
                .padding(.trailing, 10)
        }
        .frame(height: 29)
        .background(Color("RatingBackgroundColor"))
        .cornerRadius(5)
    }
}

// MARK: - Preview
struct RatingView_Previews: PreviewProvider {
    
    @State static var rate = "5 Превосходно"
    
    static var previews: some View {
        RatingView(rate: $rate)
    }
}
