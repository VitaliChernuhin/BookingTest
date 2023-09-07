//
//  Bundle+appName.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Foundation

extension Bundle {
    
    var appName: String? {
        Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }
}
