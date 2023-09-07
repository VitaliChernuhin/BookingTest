//
//  ImagesProvider.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Foundation
import Combine
import Moya
import CombineMoya

// MARK: ImagesProviderError
enum ImagesProviderError: Error, MessageRepresentable {
    case destinationPath
    case download
    
    var message: String {
        switch self {
        case .destinationPath:
            return "Ошибка пути загрузки картинки"
        case .download:
            return "Ошибка загрузки картинки"
        }
    }
}

// MARK: ImagesProviding (protocol)
protocol ImagesProviding: AnyObject {
    func requestImage(source: ImageSource) -> AnyPublisher<ImageSource, ImagesProviderError>
}

// MARK: - ImagesProvider (implementation)
final class ImagesProvider: ImagesProviding {
    
    private var imagesPathURL: URL {
        let appName: String = Bundle.main.appName ?? "BookingTest"
        let tempDirectoryUrl = FileManager.default.temporaryDirectory
        return tempDirectoryUrl.appendingPathComponent("/\(appName)/images/")
    }
    
    private var downloadDestination: DownloadDestination?
    private let provider = MoyaProvider<API>()
    
    func requestImage(source: ImageSource) -> AnyPublisher<ImageSource, ImagesProviderError> {
        Deferred {
            guard let localPathUrl = source.localPathUrl, self.isFileExist(fileName: localPathUrl.absoluteString)
            else {
                return self.downloadImage(imageSource: source)
            }
            return CurrentValueSubject<ImageSource, ImagesProviderError>(source).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}

// MARK: - Check is file exists
private extension ImagesProvider {
    
    func isFileExist(fileName: String) -> Bool {
        let path: String = imagesPathURL.appending(path: fileName).path()
        return FileManager.default.fileExists(atPath: path)
    }
}

// MARK: - Load image (private)
private extension ImagesProvider {
    func downloadImage(imageSource: ImageSource) -> AnyPublisher<ImageSource, ImagesProviderError> {
        Deferred {
            guard let downloadUrl: URL = URL(string: imageSource.downloadPath) else {
                return Fail<ImageSource, ImagesProviderError>(error: .destinationPath).eraseToAnyPublisher()
            }
            guard let destUrl: URL = self.destinationUrl(imageSource: imageSource) else {
                return Fail<ImageSource, ImagesProviderError>(error: .destinationPath).eraseToAnyPublisher()
            }
            
            let downloadDestination = self.imagesDownloadDestination(destinationURL: destUrl)
            self.downloadDestination = downloadDestination
            
            return self.provider
                .requestPublisher(.image(url: downloadUrl,
                                         imageDownloadDestination: downloadDestination))
                .mapError { moyaErrror -> ImagesProviderError in
                    return .download
                }.compactMap { _ -> ImageSource in
                    var imageSource = imageSource
                    imageSource.localPathUrl = destUrl
                    return imageSource
                }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}

// MARK: - Generate DownloadDestination (private)
private extension ImagesProvider {
    func destinationUrl(imageSource: ImageSource) -> URL? {
        guard let fileName = imageSource.fileName
        else { return nil }
        var pathUrl = self.imagesPathURL
        pathUrl.appendPathComponent(fileName)
        return pathUrl
    }
    func imagesDownloadDestination(destinationURL: URL) -> DownloadDestination {
        return { temporaryURL, response in
            return (destinationURL, [.removePreviousFile, .createIntermediateDirectories])
        }
    }
}



