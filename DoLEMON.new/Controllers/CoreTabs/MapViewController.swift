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
        view.backgroundColor = .systemBackground
        
        mapView.delegate = self
        
        // titleの設定
        navigationItem.title = "MAPS"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width,
            height: view.frame.size.height - view.safeAreaInsets.top)
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
        
        // Add a map pin
        let pin = MKPointAnnotation()
        pin.title = "TokyoDisneySea "
        pin.subtitle = "Kodai Hayashi"
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


//　ピンをカスタムする
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //アノテーションビューを作成する。
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
    
        //吹き出しを表示可能にする。
        pinView.canShowCallout = true
        
        //左ボタンをアノテーションビューに追加する。
        let deletePinButton = UIButton()
        deletePinButton.frame = CGRect(x: 0,y: 0,width: 40,height: 40)
        deletePinButton.setImage(UIImage(systemName: "trash"), for: .normal)
        pinView.rightCalloutAccessoryView = deletePinButton
        
        //右ボタンをアノテーションビューに追加する。
        let showDetailButton = UIButton()
        showDetailButton.frame = CGRect(x: 0,y: 0,width: 40,height: 40)
        showDetailButton.setImage(UIImage(systemName: "doc.text.magnifyingglass"), for: .normal)
        pinView.leftCalloutAccessoryView = showDetailButton
        return pinView
    }
    
    //吹き出しアクササリー押下時の呼び出しメソッド
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if(control == view.leftCalloutAccessoryView) {
            print("detailVCに遷移")
        } else {
            guard let pin = view.annotation else {return}
            mapView.removeAnnotation(pin)
        }
    }
}
