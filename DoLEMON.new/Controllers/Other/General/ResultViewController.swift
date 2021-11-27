//
//  ListViewControllerViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/11.
//

import UIKit
import CoreLocation
import FirebaseFirestore

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
    
    private var places: [Place] = []
    
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
    
    
    
    public func update(with places: [Place]) {
        self.tableView.isHidden = false
        self.places = places
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = places[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.isHidden = true
        let place = places[indexPath.row]
        let commentsVC = CommentsViewController()
        
        commentsVC.placeNameLabel.text = place.placeName
        commentsVC.addressLabel.text = place.address
        
        // commentVCとpinのsubtitleにfullnameを代入
        
        FirestoreManager.shared.fetchCurrentUser { result in
            commentsVC.usernameLabel.text = result.fullName
            commentsVC.pin.subtitle = result.fullName
        }
        
        commentsVC.pin.title = place.placeName
        // commntsVCにmodalで遷移
        present(commentsVC, animated: true, completion: nil)
        
        GooglePlaceManager.shared.resolveLocatioin(for: place) { [weak self] result in
            switch result {
            case .success(let coordinate):
                
                DispatchQueue.main.async {
                    // AuthManagerに切り出したい
                    COLLECTION_USERS.getDocuments { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            FirestoreManager.shared.fetchCurrentUser { user in
                                commentsVC.pin.latitude = String(coordinate.latitude)
                                commentsVC.pin.longitude = String(coordinate.longitude)
                                
                                self?.delegate?.didTapPlace(with: coordinate, title: place.placeName, subtitle: user.fullName)
                            }
                        }
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

