//
//  GooglePlaceManager.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/12.
//

import Foundation
import GooglePlaces
import CoreLocation
import MapKit


final class GooglePlaceManager {
    static let shared = GooglePlaceManager()
    
    private let client = GMSPlacesClient.shared()
    
    private init() {}
    
    public func resolveLocations(with address: String,
                                 completion: @escaping (CLLocationCoordinate2D) -> Void) {
        CLGeocoder().geocodeAddressString(address) { placemarks, error in
            guard let coordinate = placemarks?.first?.location?.coordinate else { return }
            
            completion(coordinate)
        }
    }
}
