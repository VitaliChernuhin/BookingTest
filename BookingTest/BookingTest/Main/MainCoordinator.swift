//
//  MainCoordinator.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Foundation
import SwiftUI
import Stinsen

final class MainCoordinator: NavigationCoordinatable {
    
    var stack: Stinsen.NavigationStack<MainCoordinator>
    
    @Root var start = makeHotel
    
    init() {
        self.stack = NavigationStack(initial:\MainCoordinator.start)
    }
}

private extension MainCoordinator {
    func makeHotel() -> HotelCoordinator {
        return HotelCoordinator()
    }
}
