//
//  ParticularitiesView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 12.09.2023.
//

import SwiftUI

struct ParticularitiesView: View {
    
    @Binding var particularities: [String]
    
    var body: some View {
        if !particularities.isEmpty {
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    DescriptionView(description: $particularities[0])
                    if particularities.count >= 2 {
                        DescriptionView(description: $particularities[1])
                    }
                    Spacer()
                }
                
                if particularities.count >= 3 {
                    HStack(spacing: 8) {
                        DescriptionView(description: $particularities[2])
                        if particularities.count == 4 {
                            DescriptionView(description: $particularities[3])
                        }
                        Spacer()
                    }
                }
            }
        } else { EmptyView() }
    }
}
    
struct ParticularitiesView_Previews: PreviewProvider {
        
        @State static var particularities = ["3-ая полоса", "3-ая полоса", "3-ая полоса", "3-ая полоса"]
        
        static var previews: some View {
            ParticularitiesView(particularities: $particularities)
        }
}

