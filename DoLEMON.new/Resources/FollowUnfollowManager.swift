//
//  FollowUnfollowManager.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/22.
//

import Foundation

class FollowUnfollowManager {
    
    func follow(uid: String) {
        UserService.follow(uid: uid) { _ in
            print("DEBUG: succesfully \(uid) is followed")
        }
    }

    func unfollow(uid: String) {
        UserService.unfollow(uid: uid) { _ in
            print("DEBUG: succesfully \(uid) is unfollowed")
        }
    }}

