//
//  CategoryView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import SwiftUI

// MARK: CategoryView
struct CategoryView: View {
    
    @Binding var imageName: String
    @Binding var title: String
    @Binding var description: String
    
    var body: some View {
        
        VStack(spacing: 10) {
            HStack {
                Image(imageName)
                    .frame(width: 24, height: 24)
                
                VStack(spacing: 2) {
                    HStack {
                        Text(title)
                            .font(Fonts.regular(size: 16).font)
                            .foregroundColor(Color("CategoryTitleForeground"))
                        Spacer()
                    }
                    HStack {
                        Text(description).font(Fonts.regular(size: 14).font)
                            .foregroundColor(Color("CategoryDescriptionColor"))
                        Spacer()
                    }
                }
                .padding(.leading, 12)
                
                Spacer()
                
                Image("rightArrow")
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 15)
            }
            .frame(height: 38)
            
            Divider().padding(.leading, 36)
        }
        .frame(height: 49)
        
    }
}

// MARK: - Preview
struct CategoryView_Previews: PreviewProvider {
    
    @State static var imageName = "сonveniences"
    @State static var title = "Удобства"
    @State static var description = "Самое необходимое"
    
    static var previews: some View {
        
        ZStack {
            Color.blue.opacity(0.05)
            
            CategoryView(imageName: $imageName, title: $title, description: $description)
        }
        
       
    }
}
