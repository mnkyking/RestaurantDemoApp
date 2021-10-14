//
//  RestaurantDetailViewController.swift
//  RobinGonzalesChallenge
//
//  Created by Robin Gonzales on 13/10/21.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController {
    
    var restaurant: Restaurant?
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantTypeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateUI()
        displayLocation()
    }
    
    private func populateUI() {
        // reset view
        restaurantNameLabel.text = nil
        restaurantTypeLabel.text = nil
        addressLabel.text = nil
        twitterLabel.text = nil
        phoneLabel.text = nil
        
        restaurantNameLabel.text = restaurant?.name
        restaurantTypeLabel.text = restaurant?.category
        addressLabel.text = restaurant?.location?.address
        twitterLabel.text = restaurant?.contact?.twitter
        phoneLabel.text = restaurant?.contact?.formattedPhone
    }
    
    private func displayLocation() {
        guard let latitude = restaurant?.location?.lat,
        let longitude = restaurant?.location?.lng
        else { return }
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(annotation1)
        
        let coordinateRegion = MKCoordinateRegion(center: annotation1.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
