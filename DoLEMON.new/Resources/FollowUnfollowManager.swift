//
//  FollowUnfollowManager.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/22.
//

import Foundation

class FollowUnfollowManager {
    
    var user: User
    
    init(user: User) {
        self.user = user
        //checkIfUserIsFollowed()
    }
    
    func follow(completion: @escaping () -> Void) {
        let uid = self.user.uid
        UserService.follow(uid: uid) { _ in
            self.user.isFollowed = true
            completion()
        }
    }
    
    func unfollow(completion: @escaping () -> Void) {
        let uid = self.user.uid
        UserService.unfollow(uid: uid) { _ in
            self.user.isFollowed = false
            completion()
        }
    }
    
    func checkIfUserIsFollowed() {
        //guard !user.isCurrentUser else {return}
        let uid = self.user.uid
        UserService.checkIfUserIsFollowed(uid: uid) { isFollowed in
            self.user.isFollowed = isFollowed
        }

    }
}
