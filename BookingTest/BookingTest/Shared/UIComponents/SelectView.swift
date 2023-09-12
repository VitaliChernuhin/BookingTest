//
//  SelectNumberButtonView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import SwiftUI

struct SelectView: View {
    
    @Binding var title: String

    var body: some View {
    
        Text(title)
            .font(Fonts.regular(size: 16).font)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity,minHeight: 48)
            .background(Color("SelectNumberButtonBackgroundColor"))
            .cornerRadius(15, corners: .allCorners)
    }
}

struct SelectView_Previews: PreviewProvider {
    
    @State static var title = "К выбору отеля"
    
    static var previews: some View {
        SelectView(title: $title)
    }
}
