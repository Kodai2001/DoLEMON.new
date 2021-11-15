//
//  FirebaseAuthManager.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/15.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit

class FirebaseAuthManager {
    
    // create user
    func createUser(email: String, fullName: String, username: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
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
}
