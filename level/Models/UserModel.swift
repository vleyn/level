//
//  UserModel.swift
//  level
//
//  Created by Владислав Мазуров on 14.06.23.
//

import Foundation

struct UserModel: Codable {
    var uid: String
    let nickname: String
    let email: String
    let avatar: String
    let bio: String
}

struct ChatUser: Identifiable {
    var id: String { uid }
    let uid, nickname, avatar: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.nickname = data["nickname"] as? String ?? ""
        self.avatar = data["avatar"] as? String ?? ""
    }
}
