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
    
    static let shared = FirestoreManager()
    
    
    //MARK: - User
    
    func fetchALLUsers(completion: @escaping ([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            let users = documents.compactMap({try? $0.data(as: User.self)})
            completion(users)
        }
    }
    
    func fetchCurrentUser(completion: @escaping (User) -> Void) {
        guard let uid = userSession?.uid else {return}
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else {return}
            completion(user)
        }
    }
    
    func fetchUsers(uids: [String], completion: @escaping ([User]) -> Void) {
        
        var users: [User] = []
        for uid in uids {
            COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
                guard let user = try? snapshot?.data(as: User.self) else {return}
                users.append(user)
                completion(users)
            }
        }
    }
    
    func searchUser(uid: String, completion: @escaping (User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if let _error = error {
                print("There was a issue saving data to firestore, \(_error)")
            } else {
                guard let user = try? snapshot?.data(as: User.self) else {return}
                completion(user)
            }
        }
    }
    
    func updateProfileImage(image: UIImage) {
        ImageUploader.uploadImage(image: image) { imageURL in
            guard let uid = FirebaseAuthManager.shared.userSession?.uid else { return }
            COLLECTION_USERS.document(uid).updateData(
                ["profileImageURL" : imageURL]
            )
        }
    }
    
    //MARK: - followings
    
    func fetchFollowing(completion: @escaping ([String]) -> Void) {
        guard let uid = self.userSession?.uid else { return }
        COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            var followingUid: [String] = []
            for doc in documents {
                let uid = doc.documentID
                followingUid.append(uid)
            }
            completion(followingUid)
        }
    }
    
    //MARK: - followers
    
    func fetchFollowers(completion: @escaping ([String]) -> Void) {
        guard let uid = self.userSession?.uid else { return }
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            var followerUid: [String] = []
            for doc in documents {
                let uid = doc.documentID
                followerUid.append(uid)
            }
            completion(followerUid)
        }
    }
    
    //MARK: - Pin
    
    func savePin(pin: Pin) {
        COLLECTION_PINS.addDocument(data: [
            "latitude": pin.latitude,
            "longitude": pin.longitude,
            "placeName": pin.placeName,
            "fullName": pin.fullName,
            "commentText": pin.commentText,
            "addressName": pin.addressName,
            "uid": pin.uid
            
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
                           let title = data["placeName"] as? String,
                           let subtitle = data["fullName"] as? String,
                           let commentText = data["commentText"] as? String,
                           let addressName = data["addressName"] as? String,
                           let uid = data["uid"] as? String
                        {
                            var pin = Pin()
                            
                            pin.longitude = longitude
                            pin.latitude = latitude
                            pin.placeName = title
                            pin.fullName = subtitle
                            pin.commentText = commentText
                            pin.addressName = addressName
                            pin.uid = uid
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
    
    func getAnnotations(pin: Pin, completion: @escaping ([MKAnnotation]) -> Void) {
//        var pins: [Pin] = []
//        getAllPins { piNs in
//            pins = piNs
            var results:[MKPointAnnotation] = []
//            pins.forEach { pin in
                let annotation = MKPointAnnotation()
                let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(pin.latitude)!, longitude: CLLocationDegrees(pin.longitude)!)
                annotation.title = pin.placeName
                annotation.subtitle = pin.fullName
                annotation.coordinate = coordinate
                results.append(annotation)
                completion(results)
            }
        }
//    }
//}


