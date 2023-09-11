//
//  API.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Foundation
import Alamofire
import Moya

enum API {
    case hotel
    case image(url: URL, imageDownloadDestination: DownloadDestination)
    case rooms
}

extension API: TargetType {
 
    var baseURL: URL {
        switch self {
        case .hotel, .rooms:
            return URL(string: "https://run.mocky.io/v3")!
        case .image(url: let url, imageDownloadDestination: _):
            return url
        }
        
    }
    
    var path: String {
        switch self {
        case .hotel:
            return "/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
        case .image:
            return ""
        case .rooms:
            return "/f9a38183-6f95-43aa-853a-9c83cbb05ecd"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .hotel, .image, .rooms:
            return Method.get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .hotel, .rooms:
            return .requestPlain
        case .image(url: _, imageDownloadDestination: let downloadDestination):
            return .downloadDestination(downloadDestination)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .hotel, .image, .rooms:
            return nil
        }
    }
}
