//
//  GooglePlaceManager.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/12.
//

import Foundation
import GooglePlaces
import CoreLocation


final class GooglePlaceManager {
    static let shared = GooglePlaceManager()
    
    private let client = GMSPlacesClient.shared()
    
    private init() {}
    
    enum PlacesError: Error {
        case failedToFind
        case failedToGetCoordinates
    }
    
    public func findPlaces(
        query: String,
        completion: @escaping (Result<[Place], Error>) -> Void) {
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        client.findAutocompletePredictions(
            fromQuery: query,
            filter: filter,
            sessionToken: nil
        ) { results, error in
            guard let results = results, error == nil else {
                completion(.failure(PlacesError.failedToFind))
                return
            }
            
            let places: [Place] = results.compactMap({
                Place(
                    name: $0.attributedFullText.string,
                    placeName: $0.attributedPrimaryText.string,
                    address: $0.attributedSecondaryText?.string ?? "",
                    identifier: $0.placeID
                )
            })
            
            completion(.success(places))
        }
    }
    
    public func resolveLocatioin(
        for place: Place,
        completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void
    ) {
        client.fetchPlace(fromPlaceID: place.identifier,
                          placeFields: .coordinate,
                          sessionToken: nil) { googlePlace, error in
            guard let googlePlace = googlePlace, error == nil else {
                completion(.failure(PlacesError.failedToGetCoordinates))
                return
            }
            
            let coordinate = CLLocationCoordinate2D(
                latitude: googlePlace.coordinate.latitude,
                longitude: googlePlace.coordinate.longitude
            )
            
            completion(.success(coordinate))
        }
    }
}
