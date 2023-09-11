//
//  HotelCoordinator.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Foundation
import SwiftUI
import Stinsen

final class HotelCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initial: \HotelCoordinator.start)
    
    @Root var start = makeHotel
}

private extension HotelCoordinator {
    @ViewBuilder func makeHotel() -> some View {
        let viewModel =  HotelViewModel(hotelProvider: ServicesFactory.shared.service(type: HotelProviding.self), imagesProvider: ServicesFactory.shared.service(type: ImagesProviding.self))
        HotelView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeSelectHotel() -> some View {
        
    }
}
