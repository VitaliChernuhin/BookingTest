//
//  HotelViewModel.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Foundation
import Combine
import Stinsen

// MARK: HotelViewModelProtocol (protocol)
protocol HotelViewModelProtocol: ObservableObject, ViewEventHandling {
    var imageLocalPaths: [String] { get set }
    var rate: String { get set }
    var hotelName: String { get set }
}

// MARK: - HotelViewModel
final class HotelViewModel: ViewModelBaseBinding,
                            HotelViewModelProtocol {
    
    // MARK: Private properties
    
    // Services
    private let hotelProvider: HotelProviding
    private let imagesProvider: ImagesProviding
    
    // MARK: Public properties
    
    private(set) var onAppearSubject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    
    @Published var imageLocalPaths: [String] = []
    @Published var rate: String = ""
    @Published var hotelName: String = ""
    
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
