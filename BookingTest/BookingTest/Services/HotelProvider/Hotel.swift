//
//  Hotel.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Foundation

// MARK: Hotel
struct Hotel {
    let id: Int
    let name: String
    let adress: String
    let minPrice: Double
    let priceDescription: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let hotelDescription: HotelDescription
}

extension Hotel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case adress = "adress"
        case minPrice = "minimal_price"
        case priceDescription = "price_for_it"
        case rating = "rating"
        case ratingName = "rating_name"
        case imageUrls = "image_urls"
        case hotelDescription = "about_the_hotel"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.adress = try container.decode(String.self, forKey: .adress)
        self.minPrice = try container.decode(Double.self, forKey: .minPrice)
        self.priceDescription = try container.decode(String.self, forKey: .priceDescription)
        self.rating = try container.decode(Int.self, forKey: .rating)
        self.ratingName = try container.decode(String.self, forKey: .ratingName)
        self.imageUrls = try container.decode([String].self, forKey: .imageUrls)
        self.hotelDescription = try container.decode(HotelDescription.self, forKey: .hotelDescription)
    }
}

// MARK: - HotelDescription
extension Hotel {
    struct HotelDescription: Decodable {
        let description: String
        let peculiarities: [String]
    }
}
