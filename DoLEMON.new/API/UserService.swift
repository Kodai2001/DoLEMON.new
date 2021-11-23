//
//  UserService.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/22.
//

import Foundation

struct UserService {
    
    static func follow(uid: String, completion: ((Error?) -> Void)?) {
        let firestoreManager = FirestoreManager()
        guard let currentUid = firestoreManager.userSession?.uid else {return}
        
        COLLECTION_FOLLOWING.document(currentUid)
            .collection("user-following").document(uid).setData([:]) { _ in
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers")
                    .document(currentUid).setData([:], completion: completion)
            }
    }

    static func unfollow(uid: String, completion: ((Error?) -> Void)?) {
        let firestoreManager = FirestoreManager()
        guard let currentUid = firestoreManager.userSession?.uid else {return}
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
            .document(uid).delete { _ in
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers")
                    .document(currentUid).delete(completion: completion)
            }
    }

    static func checkIfUserIsFollowed (uid: String, completion: @escaping (Bool) -> Void) {
        let firestoreManager = FirestoreManager()
        guard let currentUid = firestoreManager.userSession?.uid else {return}
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
            .document(uid).getDocument { snapshot, _ in
                guard let isFollowed = snapshot?.exists else {return}
                completion(isFollowed)
            }
    }

}

