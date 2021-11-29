//
//  FirebaseAuthManager.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/15.
//

import FirebaseAuth
import FirebaseFirestore
import Firebase
import UIKit

class FirebaseAuthManager {
    
    var userSession: FirebaseAuth.User?
    
    static let shared = FirebaseAuthManager()
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
    // create user
    func createUser(email: String, fullName: String, username: String, password: String, image: UIImage, completionBlock: @escaping (_ success: Bool) -> Void) {
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
                if let user = authResult?.user {
                    let uid = user.uid
                    
                    
                    //辞書型で保存するため、[String: Any]でdocDataを作成
                    //どのように、どの値を入れるのか記述
                    let docData = [
                        "email": email,
                        "fullName": fullName,
                        "username": username,
                        "password": password,
                        "profileImageURL": imageUrl,
                        "uid": uid
                    ] as [String : Any]
                    
                    //下の記述でFirestoreにデータを保存
                    COLLECTION_USERS.document(uid).setData(docData) {(err) in
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
    }
    
    // sign in
    func signIn(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
                print("DEBUG: \(error)")
            } else {
                completionBlock(true)
            }
        }
    }
    
    // sign out
    func signout() {
        try? Auth.auth().signOut()
    }
}

