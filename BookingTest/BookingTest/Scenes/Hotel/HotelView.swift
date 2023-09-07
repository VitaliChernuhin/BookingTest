//
//  HotelView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import SwiftUI
import Combine
import ACarousel


// MARK: HotelViewAction
enum HotelViewAction {
}

// MARK: - HotelView
struct HotelView<TViewModel: HotelViewModelProtocol>: View {
    
    // MARK: Private properties
    
    @ObservedObject private var viewModel: TViewModel
    
    @State private var imageIndex: Int = 0
    
    // MARK: - Life cycle
    
    init(viewModel: TViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
         
        let imageViewModels: [ImageViewModel] =  {
            if !viewModel.imageLocalPaths.isEmpty {
                return viewModel
                    .imageLocalPaths
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
            
        
        return ZStack {
            VStack(spacing: 16) {
                
                // Title
                HStack {
                    Text("Отель")
                        .font(Fonts.regular(size: 19).font)
                }
                
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
                
                Spacer()
                
            }
            .padding(EdgeInsets(top: 19, leading: 16,
                                bottom: 0, trailing: 16))
        }.onAppear {
            viewModel.handle(event: .onAppear)
        }
    }
}

// MARK: - Preview
struct HotelView_Previews: PreviewProvider {
    
    static var viewModel: HotelViewModel = {
        let imagePlaceholder = "imagePlaceholder"
        var viewModel = HotelViewModel(hotelProvider: ServicesFactory.shared.service(type: HotelProviding.self), imagesProvider: ServicesFactory.shared.service(type: ImagesProviding.self))
        viewModel.imageLocalPaths.append(imagePlaceholder)
        return viewModel
    }()
    
    static var previews: some View {
        HotelView(viewModel: viewModel)
    }
}
