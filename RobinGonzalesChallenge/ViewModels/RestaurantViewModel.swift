//
//  LunchViewModel.swift
//  RobinGonzalesChallenge
//
//  Created by Robin Gonzales on 13/10/21.
//

import Foundation
import Combine

class RestaurantViewModel {
    
    var count: Int { restaurants.count }
    func getRestaurant(by row: Int) -> Restaurant { restaurants[row] }
    
    private let service = NetworkManager()
    private var subscribers = Set<AnyCancellable>()
    private var imageCache = [String: Data]()
    
    @Published private(set) var restaurants = [Restaurant]()
    @Published private(set) var rowToUpdate = 0
    
    func loadRestaurant() {
        service
            .getData(from: NetworkURL.lunch, parseIn: RestaurantResponse.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // print error in the log
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                self?.restaurants = response.restaurants
            }
            .store(in: &subscribers)
    }
    
    func imageData(by row: Int) -> Data? {
        
        let restaurant = restaurants[row]
        
        // verifying image url
        guard let key = restaurant.backgroundImageURL
        else { return nil }
        
        // verifying image in cache
        if let data = imageCache[key] { return data }
        
        // download image
        service
            .getData(from: key)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // print error in the log
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] data in
                self?.imageCache[key] = data
                self?.rowToUpdate = row
            }
            .store(in: &subscribers)
        
        return nil
    }
}
