//
//  UserCache.swift
//  level
//
//  Created by Владислав Мазуров on 20.06.23.
//

import Foundation

class UserCache {
    
    static let shared = UserCache()
    
    private init() {}
    
    var uid = ""
    var nickname = ""
    var email = ""
    var avatar = ""
    var bio = ""
    var wishList: [Int] = []
    
    func saveInfo(user: UserModel) {
        uid = user.uid
        nickname = user.nickname
        email = user.email
        avatar = user.avatar
        bio = user.bio
    }
    
    func getInfo() -> UserModel {
        UserModel(uid: uid, nickname: nickname, email: email, avatar: avatar, bio: bio, wishList: wishList)
    }
}
