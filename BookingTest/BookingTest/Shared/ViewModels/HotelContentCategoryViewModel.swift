//
//  HotelContentCategoryViewModel.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import Foundation

enum HotelContentCategory {
    case сonveniences
    case included
    case notIncluded
}

// MARK: HotelContentCategoryViewModel
struct HotelContentCategoryViewModel {
    
    let category: HotelContentCategory
    var imageName: String {
        get {
            switch category {
            case .сonveniences:
                return "сonveniences"
            case .included:
                return "allow"
            case .notIncluded:
                return "disallow"
            }
        }
        set {}
    }
    var title: String {
        get {
            switch category {
            case .сonveniences:
                return "Удобства"
            case .included:
                return "Что включено"
            case .notIncluded:
                return "Что не включено"
            }
        }
        set {}
    }
    var description: String {
        get {
            switch category {
            case .сonveniences:
                return"Самое необходимое"
            case .included:
                return"Самое необходимое"
            case .notIncluded:
                return"Самое необходимое"
            }
        }
        set {}
    }
}


