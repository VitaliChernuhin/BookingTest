//
//  DescriptionView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 09.09.2023.
//

import SwiftUI

struct DescriptionView: View {
    
    @Binding var description: String
    
    var body: some View {
        Text(description)
            .font(Fonts.regular(size: 16).font)
            .frame(height: 29)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background(Color("DescriptionBackgroundColor"))
            .cornerRadius(5, corners: .allCorners)
    }
}

struct DescriptionView_Previews: PreviewProvider {
    
    @State static var description = "3-ая линия"
    
    static var previews: some View {
        
        ZStack {
            Color.blue.opacity(0.1)
            
            DescriptionView(description: $description)
        }
    }
}
