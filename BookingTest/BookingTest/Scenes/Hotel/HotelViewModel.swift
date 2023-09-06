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
protocol HotelViewModelProtocol: ObservableObject {
    var imageLocalPaths: [String] { get set }
}

// MARK: - HotelViewModel
final class HotelViewModel: ViewModelBaseBinding,
                            HotelViewModelProtocol {
    
    private(set) var onAppearSubject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    
    var imageLocalPaths: [String] = []
}

// MARK: - Binduble (implementation)


// MARK: - ViewActionHandling (implementation)
extension HotelViewModel: ViewActionHandling {
    
    func handle(action: HotelViewAction) {
        
    }
}
