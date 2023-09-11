//
//  Room.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import Foundation

// MARK: Room
struct Room {
    let id: Int
    let name: String
    let price: Double
    let priceDescription: String
    let peculiarities: [String]
    let imageUrls: [String]
}

extension Room: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case priceDescription = "price_per"
        case peculiarities = "peculiarities"
        case imageUrls = "image_urls"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.priceDescription = try container.decode(String.self, forKey: .priceDescription)
        self.peculiarities = try container.decode([String].self, forKey: .peculiarities)
        self.imageUrls = try container.decode([String].self, forKey: .imageUrls)
    }
}
