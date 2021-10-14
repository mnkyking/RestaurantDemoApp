//
//  ViewController.swift
//  RobinGonzalesChallenge
//
//  Created by Robin Gonzales on 13/10/21.
//

import UIKit
import Combine

class RestaurantViewController: UIViewController {
    
    private let viewModel = RestaurantViewModel()
    private var subscribers = Set<AnyCancellable>()
    private var rowSelected = 0

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpUI()
        setUpBinding()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
            let destination = segue.destination as? RestaurantDetailViewController {
            destination.restaurant = viewModel.getRestaurant(by: rowSelected)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setUpUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func setUpBinding() {
        // creating binding for restaurants
        viewModel
            .$restaurants
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &subscribers)
        
        // creating binding for row
        viewModel
            .$rowToUpdate
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] row in
                self?.collectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
            }
            .store(in: &subscribers)
        
        // load restaurant
        viewModel
            .loadRestaurant()
    }
    
}

extension RestaurantViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // getting custom cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCell.identifier, for: indexPath) as? RestaurantCell
        else { return UICollectionViewCell() }
        
        let row = indexPath.row
        let restaurant = viewModel.getRestaurant(by: row)
        let data = viewModel.imageData(by: row)
        cell.configureCell(name: restaurant.name, type: restaurant.category, imageData: data)
        
        return cell
    }
    
}

extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var witdh = 0.0
        
        // get device's type
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        
        if deviceIdiom == .pad {
            witdh = collectionView.bounds.size.width / 2
        } else {
            witdh = collectionView.bounds.size.width
        }
        
        return CGSize(width: witdh, height: 180.0)
    }
    
}
