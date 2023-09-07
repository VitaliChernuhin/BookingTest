//
//  ImageSource.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Foundation

struct ImageSource {
    let downloadPath: String
    var localPathUrl: URL?
    
    var isDownloaded: Bool { localPathUrl != nil }
    var fileName: String? {
        downloadPath.components(separatedBy: "/").last
    }
}
