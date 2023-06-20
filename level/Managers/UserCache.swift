//
//  UserCache.swift
//  level
//
//  Created by Владислав Мазуров on 20.06.23.
//

import Foundation

class UserCache {
    
    static let shared = UserCache()
    
    var nickname = ""
    var email = ""
    var avatar = ""
    var bio = ""
    
    func saveInfo(user: UserModel) {
        nickname = user.nickname
        email = user.email
        avatar = user.avatar
        bio = user.bio
    }
}
