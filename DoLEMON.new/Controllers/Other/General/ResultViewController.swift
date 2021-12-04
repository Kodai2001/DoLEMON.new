//
//  ListViewControllerViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/11.
//

import UIKit
import CoreLocation
import FirebaseFirestore
import MapKit

protocol ResultViewControllerDelegate: AnyObject {
    func didTapPlace(with coordinate: CLLocationCoordinate2D, title: String, subtitle: String)
}

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: ResultViewControllerDelegate?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var results: [MKLocalSearchCompletion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func update(with results: [MKLocalSearchCompletion]) {
        self.tableView.isHidden = false
        self.results = results
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row].title
        cell.detailTextLabel?.text = results[indexPath.row].subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.isHidden = true
        let place = results[indexPath.row]
        let commentsVC = CommentsViewController()
        
        commentsVC.placeNameLabel.text = place.title
        commentsVC.addressLabel.text = place.subtitle
        
        // commentVCとpinのsubtitleにfullnameを代入
        let firestoreManager = FirestoreManager()
        firestoreManager.fetchCurrentUser { result in
            commentsVC.usernameLabel.text = result.fullName
            commentsVC.pin.fullName = result.fullName
        }
        
        commentsVC.pin.placeName = place.title
        // commntsVCにmodalで遷移
        present(commentsVC, animated: true, completion: nil)
        
        
        let address = place.subtitle
        
        GooglePlaceManager.shared.resolveLocations(with: address) { coordinate in
            DispatchQueue.main.async {
                COLLECTION_USERS.getDocuments { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        FirestoreManager.shared.fetchCurrentUser { user in
                            commentsVC.pin.latitude = String(coordinate.latitude)
                            commentsVC.pin.longitude = String(coordinate.longitude)
                            
                            self.delegate?.didTapPlace(with: coordinate, title: place.title, subtitle: user.fullName)
                        }
                    }
                }
            }
        }
    }
}


