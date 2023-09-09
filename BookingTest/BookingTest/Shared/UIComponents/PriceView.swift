//
//  PriceView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 09.09.2023.
//

import SwiftUI

// MARK: PriceView
struct PriceView: View {
    
    @Binding var price: Int
    
    private var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = " "
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSize = 3
        numberFormatter.currencySymbol = "₽"
        return numberFormatter
    }()
    
    
    init(price: Binding<Int>) {
        self._price = price
    }
    
    var body: some View {
        
        let formattedPrice: String = {
            var formatted = "От "
            formatted += numberFormatter.string(from: NSNumber(value: price)) ?? ""
            return formatted
        }()
        
        Text("\(formattedPrice) ₽")
            .font(Fonts.regular(size: 30).font)
    }
}

// MARK: - Preview
struct PriceView_Previews: PreviewProvider {
    
    @State static var price: Int = 134673
    
    static var previews: some View {
        PriceView(price: $price)
    }
}
