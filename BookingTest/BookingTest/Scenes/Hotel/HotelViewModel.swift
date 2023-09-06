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
}

// MARK: - HotelViewModel
final class HotelViewModel: ViewModelBaseBinding,
                            HotelViewModelProtocol {
    
    // MARK: Private properties
    
    // Services
    private let hotelProvider: HotelProviding
    
    // Model
//    private var hotel: Hotel? {
//        didSet {
//            guard let hotel = self.hotel else { return }
//            self.imageLocalPaths
//        }
//    }
    
    // MARK: Public properties
    
    private(set) var onAppearSubject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    
    @Published var imageLocalPaths: [String] = []
    
    // MARK: Life cycle
    init(hotelProvider: HotelProviding) {
        self.hotelProvider = hotelProvider
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
        } receiveValue: { hotel in
            
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
