//
//  AboutHotelCategoriesView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import SwiftUI

struct AboutHotelCategoriesView: View {
    
    @Binding var categoryViewModels: [HotelContentCategoryViewModel]
    let action: (_ category: HotelContentCategory) -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<categoryViewModels.count , id: \.self) { index in
                CategoryView(imageName: $categoryViewModels[index].imageName,
                             title: $categoryViewModels[index].title,
                             description: $categoryViewModels[index].description)
                .onTapGesture {
                    self.action(categoryViewModels[index].category)
                }
            }
        }
        .padding(EdgeInsets(top: 15,
                            leading: 15,
                            bottom: 15,
                            trailing: 0))
        .background(Color("CategoriesBackgroundColor"))
        .cornerRadius(15, corners: .allCorners)
        
    }
}

struct AboutHotelCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var viewModels: [HotelContentCategoryViewModel] = {
            [HotelContentCategoryViewModel(category: .сonveniences), HotelContentCategoryViewModel(category: .included), HotelContentCategoryViewModel(category: .notIncluded)]
        }()
        
        ZStack {
            Color.blue.opacity(0.05)
            
            AboutHotelCategoriesView(categoryViewModels: $viewModels, action: { _ in
                
            })
        }
    }
}
