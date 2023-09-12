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
    case address
    case contentCategory(HotelContentCategory)
    case selectNumber
}

// MARK: - HotelView
struct HotelView<TViewModel: HotelViewModelProtocol>: View where TViewModel.ViewActionType == HotelViewAction {
    
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
            
        return NavigationView {
            ZStack {
                
                Color("GrayBackgroundColor")
                
                VStack(spacing: 8) {
                    
                    // Common hotel info
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
                        
                        VStack(spacing: 8) {
                            
                            // Rate
                            HStack {
                                RatingView(rate: $viewModel.rate)
                                Spacer( )
                            }
                            
                            // Hotel name
                            HStack {
                                Text(viewModel.hotelName)
                                    .font(Fonts.regular(size: 22).font)
                                Spacer()
                            }
                            
                            // Hotel address
                            HStack {
                                AddressButtonView(adress: $viewModel.hotelAddress, action: {
                                    viewModel.handle(action: .address)
                                })
                                Spacer()
                            }
                            
                            // Hotel price
                            HStack(spacing: 8) {
                                Text(viewModel.price)
                                    .font(Fonts.regular(size: 30).font)
                                VStack {
                                    Spacer()
                                    Text(viewModel.priceDescription)
                                        .font(Fonts.regular(size: 16).font)
                                        .foregroundColor(Color("DescriptionForegroundColor"))
                                }
                                Spacer()
                            }.frame(height: 28)
                        }
                        .padding(.bottom, 16)
                    }
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                    
                    ScrollView {
                        AboutHotelView(title: $viewModel.aboutHotelTitle,
                                       particularity: $viewModel.particularity,
                                       description: $viewModel.hotelDescription)
                        AboutHotelCategoriesView(categoryViewModels: $viewModel.hotelContentCategoryViewModels) { category in
                            viewModel.handle(action: .contentCategory(category))
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)
                        
                        
                        NavigationLink {
                            let viewModel = SelectNumberViewModel(hotelName: self.viewModel.hotelName, roomsProvider: ServicesFactory.shared.service(type: RoomsProviding.self), imagesProvider: ServicesFactory.shared.service(type: ImagesProviding.self))
                            SelectNumberView(viewModel: viewModel)
                        } label: {
                            SelectView(title: $viewModel.selectTitle)
                                .padding(EdgeInsets(top: 12, leading: 16, bottom: 26, trailing: 16))
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(12, corners: .allCorners)
                }
            }
            .onAppear {
                viewModel.handle(event: .onAppear)
            }
        }
    }
}

extension HotelView: DebugLoging {}

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
