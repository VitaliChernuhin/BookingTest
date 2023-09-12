//
//  RoomView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 12.09.2023.
//

import SwiftUI
import ACarousel

// MARK: RoomView
struct RoomView: View {
    
    @Binding var imageLocalPaths: [String]
    @Binding var name: String
    @Binding var particularities: [String]
    
    @State private var imageIndex: Int = 0
    
    var body: some View {
        
        let imageViewModels: [ImageViewModel] =  {
            if !imageLocalPaths.isEmpty {
                return imageLocalPaths
                    .compactMap({ imagePath -> UIImage? in
                        UIImage(contentsOfFile: imagePath) ?? UIImage(named: "imagePlaceholder")
                    })
                    .map({ image -> ImageViewModel in
                        let image = Image(uiImage: image)
                        return ImageViewModel(image: image)
                    })
            }
            else {
                return [ImageViewModel(image: Image("imagePlaceHolder"))]
            }
        }()
        
        return VStack(spacing: 8) {
            
            // Image carousel
            ACarousel(imageViewModels,
                      index: $imageIndex,
                      spacing: 0,
                      headspace: 0) { imageVewModel in
                imageVewModel.image
                    .resizable()
                    .scaledToFill()
            }
            .frame(height: 257)
            .cornerRadius(15)
            
            HStack {
                Text(name)
                    .font(Fonts.regular(size: 22).font)
                Spacer()
            }
            
            ParticularitiesView(particularities: $particularities)
            
            
        }
    }
}

// MARK: - Preview
struct RoomView_Previews: PreviewProvider {
    
    @State static var imageLocalPaths: [String] = ["imagePlaceholder"]
    @State static var name = "Стандартный с видом на бассейн или сад"
    @State static var particularities = ["Все включено", "Кондиционер"]
    
    static var previews: some View {
        
        ZStack {
            Color.blue.opacity(0.05)
            
            RoomView(imageLocalPaths: $imageLocalPaths,
                     name: $name,
                     particularities: $particularities)
        }
    }
}
