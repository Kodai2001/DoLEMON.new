//
//  User.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/16.
//

import Foundation

struct User: Codable {
    
    let profileImageURL: String
    let email: String
    let password: String
    let fullName: String
    let username: String
    let uid: String
    var isFollowd: Bool? = false
}
