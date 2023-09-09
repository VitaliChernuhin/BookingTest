//
//  AdressButtonView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 08.09.2023.
//

import SwiftUI

struct AddressButtonView: View {
    
    @Binding var adress: String
    
    var body: some View {
        Button(adress) {
            
        }
        .font(Fonts.regular(size: 14).font)
        .foregroundColor(Color("ButtonForegroundColor"))
        .frame(height: 17)
    }
}

// MARK: - Preview
struct AddressButtonView_Previews: PreviewProvider {
    
    @State static var title = "Адрес отеля"
    
    static var previews: some View {
        AddressButtonView(adress: $title)
    }
}
