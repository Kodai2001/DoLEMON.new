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
//        navigationItem.title = "MAPS"
//        navigationItem.largeTitleDisplayMode = .always
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultVC = searchController.searchResultsController as? ResultViewController else {
            return
        }
        
        resultVC.delegate = self
        
        GooglePlaceManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    resultVC.update(with: places)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MapViewController: ResultViewControllerDelegate {
    func didTapPlace(with coordinate: CLLocationCoordinate2D) {
        searchVC.searchBar.resignFirstResponder()
        searchVC.dismiss(animated: true, completion: nil)
        
        // Remove all map pins
        let annotaions = mapView.annotations
        mapView.removeAnnotations(annotaions)
        
        // Add a map pin
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        mapView.setRegion(MKCoordinateRegion(
                            center: coordinate,
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.5,
                                longitudeDelta: 0.5)),
                          animated: true)
    }
    
    
}
