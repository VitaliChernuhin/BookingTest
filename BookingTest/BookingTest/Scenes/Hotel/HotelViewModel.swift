//
//  HotelViewModel.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Foundation
import Combine
import Stinsen

// MARK: - HotelViewModelProtocol (protocol)
protocol HotelViewModelProtocol: ObservableObject, ViewEventHandling, ViewActionHandling {
    
    // Common hotel info
    var imageLocalPaths: [String] { get set }
    var rate: String { get set }
    var hotelName: String { get set }
    var hotelAddress: String { get set }
    var price: String { get set }
    var priceDescription: String { get set }
    
    // Hotel description
    var aboutHotelTitle: String { get set }
    var particularity: [String] { get set }
    var hotelDescription: String { get set }
    
    // Hotel content categories
    var hotelContentCategoryViewModels: [HotelContentCategoryViewModel] { get set }
}

// MARK: - HotelViewModel
final class HotelViewModel: ViewModelBaseBinding,
                            HotelViewModelProtocol {
    
    // MARK: Private properties
    
    // Services
    private let hotelProvider: HotelProviding
    private let imagesProvider: ImagesProviding
    
    private var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.groupingSeparator = " "
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSize = 3
        numberFormatter.locale = Locale(identifier: "ru_RU")
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }()
    
    // MARK: Public properties
    
    private(set) var onAppearSubject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    
    // Common hotel info
    @Published var imageLocalPaths: [String] = []
    @Published var rate: String = ""
    @Published var hotelName: String = ""
    @Published var hotelAddress: String = ""
    @Published var price: String = ""
    @Published var priceDescription: String = ""
    
    // Hotel info description
    @Published var aboutHotelTitle: String = "Об отеле"
    @Published var particularity: [String] = []
    @Published var hotelDescription: String = ""
    @Published var hotelContentCategoryViewModels: [HotelContentCategoryViewModel] = {
        var viewModels: [HotelContentCategoryViewModel] = []
        
        let conveniencesViewModel = HotelContentCategoryViewModel(category: .сonveniences)
        viewModels.append(conveniencesViewModel)
        
        let inclidedViewModel = HotelContentCategoryViewModel(category: .included)
        viewModels.append(inclidedViewModel)
        
        let notIncludedViewModel = HotelContentCategoryViewModel(category: .notIncluded)
        viewModels.append(notIncludedViewModel)
        
        return viewModels
    }()
    
    // MARK: Life cycle
    init(hotelProvider: HotelProviding, imagesProvider: ImagesProviding) {
        self.hotelProvider = hotelProvider
        self.imagesProvider = imagesProvider
    }
}

// MARK: - Binduble (implementation)
extension HotelViewModel {
    func bindInput() {
        configureHotel()
    }
}

// MARK: - ViewActionHandling (implementation)
extension HotelViewModel: ViewActionHandling {
    func handle(action: HotelViewAction) {
        switch action{
        case .address:
            break
        case .contentCategory(_):
            break
        }
    }
}

// MARK: - Configure hotel (private)
private extension HotelViewModel {
    func configureHotel() {
        self.hotelProvider
            .requestHotel()
            .sink { completion in
                self.handleCompletion(completion: completion)
        } receiveValue: { [weak self] hotel in
            self?.configureImages(imagePaths: hotel.imageUrls)
            self?.rate = "\(hotel.rating) \(hotel.ratingName)"
            self?.hotelName = hotel.name
            self?.hotelAddress = hotel.adress
            self?.configurePrice(price: hotel.minPrice)
            self?.priceDescription = hotel.priceDescription
            self?.particularity = hotel.hotelDescription.peculiarities
            self?.hotelDescription = hotel.hotelDescription.description
        }.store(in: &cancellables)
    }
    
    func configureImages(imagePaths: [String]) {
        let imagesSource: [ImageSource] = imagePaths.map { path in
            ImageSource(downloadPath: path)
        }
        self.imagesProvider.requestImages(imageSources: imagesSource)
            .sink { [weak self] completion in
                self?.handleCompletion(completion: completion)
            } receiveValue: { loadedImageSources in
                self.imageLocalPaths = loadedImageSources.compactMap({ imageSource -> String? in
                    imageSource.localPathUrl?.path()
                })
            }.store(in: &cancellables)
    }
    
    func configurePrice(price: Double) {
        self.price = "От " + (self.numberFormatter.string(from: NSNumber(value: price)) ?? "")
    }
}

// MARK: - Handle completion
extension HotelViewModel {
    func handleCompletion<T: Error>(completion: Subscribers.Completion<T>) {
        switch completion {
        case .finished:
            return
        case .failure(let error):
            guard let message = (error as? MessageRepresentable)?.message
            else { return }
            alertMessage(message: message)
        }
    }
}

// MARK: - Alert Message method
extension HotelViewModel {
    
    func alertMessage(message: String) {
        
    }
}
