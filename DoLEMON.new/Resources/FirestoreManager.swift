//
//  FirestoreManager.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/17.
//

import FirebaseFirestore
import MapKit
import FirebaseAuth
import FirebaseFirestoreSwift


class FirestoreManager {
    
    let userSession = Auth.auth().currentUser
  
    //MARK: - User
    
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            let users = documents.compactMap({try? $0.data(as: User.self)})
            completion(users)
     }
    }
    
    func fetchUser(completion: @escaping (User) -> Void) {
        guard let uid = userSession?.uid else {return}
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else {return}
            completion(user)
        }
    }
    
    //MARK: - Comment
    
    func saveComment(comment: Comment) {
        
        COLLECTION_COMMENTS
            .addDocument(data: [
                "placeName": comment.placeName,
                "addressName": comment.addressName,
                "username": comment.username,
                "commentText": comment.commentText
                
            ]) { (error) in
                if let e = error {
                    print("There was a issue saving data to firestore, \(e)")
                } else {
                    print("Succecessfully saved data")
                }
            }
    }
    
    func getComment(completion: @escaping (Comment) -> Void) {
        
        guard let uid = userSession?.uid else {return}
        
        COLLECTION_COMMENTS
            .document(uid)
            .getDocument { (querySnapshot, error) in
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    guard let data = querySnapshot?.data() else { return }
                    
                    if let placeName = data["placeName"] as? String,
                       let addressName = data["addressName"] as? String,
                       let username = data["username"] as? String,
                       let commentText = data["commentText"] as? String
                    {
                        var result = Comment()
                        
                        result.placeName = placeName
                        result.addressName = addressName
                        result.username = username
                        result.commentText = commentText
                        completion(result)
                    } else {
                        print("There was an issue")
                    }
                }
            }
    }
    
    //MARK: - Pin
    
    func savePin(pin: Pin) {
        
        COLLECTION_PINS.addDocument(data: [
            "latitude": pin.latitude,
            "longitude": pin.longitude,
            "title": pin.title,
            "subtitle": pin.subtitle
            
        ]) { (error) in
            if let e = error {
                print("There was a issue saving data to firestore, \(e)")
            } else {
                print("Succecessfully saved data")
            }
        }
    }
    
    
    func getAllPins(completion: @escaping ([Pin]) -> Void) {
        
        var results: [Pin] = []
        
        COLLECTION_PINS.getDocuments { (querySnapshot, error) in
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        
                        let data = doc.data()
                        if let longitude = data["longitude"] as? String,
                           let latitude = data["latitude"] as? String,
                           let title = data["title"] as? String,
                           let subtitle = data["subtitle"] as? String
                        {
                            var pin = Pin()
                            
                            pin.longitude = longitude
                            pin.latitude = latitude
                            pin.title = title
                            pin.subtitle = subtitle
                            results.append(pin)
                        } else {
                            print("There was an issue")
                        }
                        completion(results)
                    }
                }
            }
        }
    }
    
    func getAnnotations(completion: @escaping ([MKAnnotation]) -> Void) {
        var pins: [Pin] = []
        getAllPins { piNs in
            pins = piNs
            var results:[MKPointAnnotation] = []
            pins.forEach { pin in
                let annotation = MKPointAnnotation()
                let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(pin.latitude)!, longitude: CLLocationDegrees(pin.longitude)!)
                annotation.title = pin.title
                annotation.subtitle = pin.subtitle
                annotation.coordinate = coordinate
                results.append(annotation)
                completion(results)
            }
        }
    }
}


