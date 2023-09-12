//
//  BookingTestApp.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 05.09.2023.
//

import SwiftUI

@main
struct BookingTestApp: App {
    var body: some Scene {
        WindowGroup {
            HotelView(viewModel: HotelViewModel(hotelProvider: ServicesFactory.shared.service(type: HotelProviding.self),
                                                imagesProvider: ServicesFactory.shared.service(type: ImagesProviding.self)))
        }
    }
}
