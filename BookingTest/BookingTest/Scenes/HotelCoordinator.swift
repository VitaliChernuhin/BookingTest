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
        HotelView(viewModel: HotelViewModel())
    }
}
