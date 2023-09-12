//
//  AboutHotelView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import SwiftUI

struct AboutHotelView: View {
    
    @Binding var title: String
    @Binding var particularity: [String]
    @Binding var description: String
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Title
            HStack {
                Text(title)
                Spacer()
            }.padding(EdgeInsets(top: 16,
                                 leading: 16,
                                 bottom: 0,
                                 trailing: 16))
            
            // Hotel particularity
            ParticularitiesView(particularities: $particularity)
                .padding(.horizontal, 16)
            
            
            // About hotel
            HStack {
                Text(description)
                    .font(Fonts.regular(size: 16).font)
                    .padding(.horizontal, 16)
                Spacer()
            }
            
        }
        .padding(.bottom, 16)
        .background(Color.white)
      
    }
}

struct AboutHotelView_Previews: PreviewProvider {
    
    @State static var title = "Об отеле"
    @State static var particularity: [String] = ["3-ая полоса", "3-ая полоса", "3-ая полоса", "3-ая полоса"]
    @State static var description: String = "Длинное описание... Длинное описание... Длинное описание... Длинное описание... Длинное описание... Длинное описание..."
    
    static var previews: some View {
        
        ZStack {
            Color.blue.opacity(0.05)
            
            AboutHotelView(title: $title,
                           particularity: $particularity,
                           description: $description)
        }
        

    }
}
