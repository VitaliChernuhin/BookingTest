//
//  SelectHotelNumberViewModel.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import Foundation
import Combine
import Stinsen

// MARK: SelectNumberViewModelProtocol
protocol SelectNumberViewModelProtocol: ObservableObject, ViewEventHandling, ViewActionHandling {
    
    var hotelName: String { get set }
}

// MARK: - SelectNumberViewModel
final class SelectNumberViewModel: ViewModelBaseBinding,
                                  SelectNumberViewModelProtocol {
    
    // MARK: Private properties
    
    // Services
    private let roomsProvider: RoomsProviding
    private let imagesProvider: ImagesProviding
    
    // MARK: Public properties
    
    private(set) var onAppearSubject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    
    @Published var hotelName: String = ""
    
    init(hotelName: String,
         roomsProvider: RoomsProviding,
         imagesProvider: ImagesProviding) {
        self.hotelName = hotelName
        self.roomsProvider = roomsProvider
        self.imagesProvider = imagesProvider
    }
}

// MARK: - Binduble (implementation)
extension SelectNumberViewModel: Bindable {
    func bindInput() {
        
    }
}

// MARK: - ViewActionHandling (implementation)
extension SelectNumberViewModel: ViewActionHandling {
    func handle(action: SelectNumberViewAction) {
        switch action {
        case .back:
            break
        }
    }
}
