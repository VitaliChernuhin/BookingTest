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
    @Binding var price: String
    let roomDetailAction: () -> Void
    let selectRoomAction: () -> Void
    
    @State private var selectRooomTitle = "Выбрать номер"
    
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
            
            HStack {
                RoomDetailView()
                    .onTapGesture {
                        roomDetailAction()
                }
                Spacer()
            }
            
            HStack(spacing: 8) {
                VStack {
                    Spacer()
                    Text(price)
                        .font(Fonts.regular(size: 30).font)
                }
               
                VStack {
                    Spacer()
                    Text("за 7 ночей с перелётом")
                        .foregroundColor(Color("DescriptionForegroundColor"))
                        .font(Fonts.regular(size: 18).font)
                }
                Spacer()
            }
            .frame(height: 36)
            .padding(.top, 8)
            
            HStack {
                SelectView(title: $selectRooomTitle)
            }
            .padding(.top, 8)
            .onTapGesture {
                selectRoomAction()
            }
        }.background(.white)
    }
}

// MARK: - Preview
struct RoomView_Previews: PreviewProvider {
    
    @State static var imageLocalPaths: [String] = ["imagePlaceholder"]
    @State static var name = "Стандартный с видом на бассейн или сад"
    @State static var particularities = ["Все включено", "Кондиционер"]
    @State static var price = "186 600 ₽"
    
    static var previews: some View {
        
        ZStack {
            Color.blue.opacity(0.05)
            
            RoomView(imageLocalPaths: $imageLocalPaths,
                     name: $name,
                     particularities: $particularities,
                     price: $price,
                     roomDetailAction: {},
                     selectRoomAction: {})
        }
    }
}
