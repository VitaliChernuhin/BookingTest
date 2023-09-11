//
//  NavigationTitledView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import SwiftUI

struct NavigationTitledView: View {
    
    let title: String
    let backAction: () -> Void
    
    var body: some View {
        HStack(spacing: 49) {
            Button(action: backAction) {
                Image("leftArrow")
            }
            .frame(width: 44, height: 44)
            .padding(.leading, 10)
            
            Text(title)
                .font(Fonts.regular(size: 18).font)
            
            Spacer()
        }
        .background(Color.white)
    }
}

struct NavigationTitledView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.opacity(0.05)
            
            NavigationTitledView(title: "Название отеля", backAction: {})
        }
       
    }
}
