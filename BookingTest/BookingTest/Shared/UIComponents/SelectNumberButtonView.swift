//
//  SelectNumberButtonView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import SwiftUI

struct SelectNumberButtonView: View {
    
    let action: () -> Void
    
    var body: some View {
        Button("К выбору номера", action: action)
            .font(Fonts.regular(size: 16).font)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity,minHeight: 48)
            .background(Color("SelectNumberButtonBackgroundColor"))
            .cornerRadius(15, corners: .allCorners)
    }
}

struct SelectNumberButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        SelectNumberButtonView(action: {
            
        })
    }
}
