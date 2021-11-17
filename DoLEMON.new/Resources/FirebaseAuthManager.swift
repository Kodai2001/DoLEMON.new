//
//  FirebaseAuthManager.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/15.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit
import MapKit



class FirebaseAuthManager {
    
    // create user
    func createUser(email: String, fullName: String, username: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                let uid = user.uid
                
                
                //辞書型で保存するため、[String: Any]でdocDataを作成
                //どのように、どの値を入れるのか記述
                let docData = [
                    "email": email,
                    "fullName": fullName,
                    "username": username,
                    "password": password
                ] as [String : Any]
                
                //下の記述でFirestoreにデータを保存
                Firestore.firestore().collection("Users").document(uid).setData(docData) {(err) in
                    if let err = err {
                        print("failed to upload user data\(err)...")
                        return
                    }
                    print("Successfuly uploaded user data...")
                }
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    // sign in
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func getUserName(completion: @escaping (String) -> Void) {
        let db = Firestore.firestore()
        var result: String = ""
        print(1)
        db.collection("Users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    guard let username = document.get("fullName") as? String else {return}
                    result = username
                    completion(result)
                    print(2)
                }
            }
        }
        print(3)
    }
    
    func savePin(pin: Pin) {
        let db = Firestore.firestore()
        
        db.collection("pin").addDocument(data: [
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
        let db = Firestore.firestore()
        var results: [Pin] = []
        
        db.collection("pin").getDocuments { (querySnapshot, error) in
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
            print(pins.count)
            pins.forEach { pin in
                let annotation = MKPointAnnotation()
                let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(pin.latitude)!, longitude: CLLocationDegrees(pin.longitude)!)
                annotation.coordinate = coordinate
                results.append(annotation)
                completion(results)
            }
        }
    }
    
}
