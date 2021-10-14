//
//  NetworkManager.swift
//  RobinGonzalesChallenge
//
//  Created by Robin Gonzales on 13/10/21.
//

import Foundation
import Combine

class NetworkManager {
    
    private let session = URLSession.shared
    
    func getData(from url: String) -> AnyPublisher<Data, NetworkError> {
        // creating url
        guard let url = URL(string: url)
        else { return Fail(error: NetworkError.url).eraseToAnyPublisher() }
        
        // fetch
        return session
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .mapError { error in NetworkError.other(error) }
            .eraseToAnyPublisher()
    }
    
    func getData<T: Decodable>(from url: String, parseIn type: T.Type) -> AnyPublisher<T, NetworkError> {
        // creating url
        guard let url = URL(string: url)
        else { return Fail(error: NetworkError.url).eraseToAnyPublisher() }
        
        // fetch
        return session
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: type, decoder: JSONDecoder())
            .mapError { error in NetworkError.other(error) }
            .eraseToAnyPublisher()
    }
}
