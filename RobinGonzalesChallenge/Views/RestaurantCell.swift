//
//  RestaurantCell.swift
//  RobinGonzalesChallenge
//
//  Created by Robin Gonzales on 13/10/21.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    static let identifier = "RestaurantCell"
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var restaurantTypeLabel: UILabel!
    
    func configureCell(name: String?, type: String?, imageData: Data?) {
        backgroundImageView.image = nil
        restaurantNameLabel.text = name
        restaurantTypeLabel.text = type
        if let data = imageData {
            backgroundImageView.image = UIImage(data: data)
        }
    }
}
