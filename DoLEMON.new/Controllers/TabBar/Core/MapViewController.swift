//
//  MapViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/11.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UISearchResultsUpdating {
    
    
    
    let mapView = MKMapView()
    
    let searchVC = UISearchController(searchResultsController: ResultViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        searchVC.searchBar.backgroundColor = .secondarySystemBackground
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
        
        // titleの設定
        navigationItem.title = "MAPS"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        mapView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height: view.frame.size.height - view.safeAreaInsets.top)
        mapView.frame = view.bounds
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
