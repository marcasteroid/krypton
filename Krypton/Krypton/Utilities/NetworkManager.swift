//
//  NetworkManager.swift
//  Krypton
//
//  Created by Marco Margarucci on 09/09/23.
//

import Foundation
import Combine

final class NetworkManager {
    
    enum NetworkError: LocalizedError {
        case badURLResponse(url: URL)
        case unkwown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return NetworkManagerConstants.networkErrorBadURLResponseErrorDescription + ": \(url)"
            case .unkwown:
                return NetworkManagerConstants.networkErrorUnknownErrorDescription
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            debugPrint("[DEBUG]: \(error)")
            debugPrint("\(error.localizedDescription)")
        }
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let reponse = output.response as? HTTPURLResponse, reponse.statusCode >= 200 && reponse.statusCode < 300 else {
            throw NetworkError.badURLResponse(url: url)
        }
        return output.data
    }
}
