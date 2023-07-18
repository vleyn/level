//
//  FriendRequestModel.swift
//  level
//
//  Created by Владислав Мазуров on 16.07.23.
//

import Foundation

struct FriendRequestModel: Identifiable {
        
    let id: String
    let uid, nickname, avatar: String
    
    init(id: String, data: [String: Any]) {
        self.id = id
        self.uid = data[DatabaseConstants.uid] as? String ?? ""
        self.nickname = data[DatabaseConstants.nickname] as? String ?? ""
        self.avatar = data[DatabaseConstants.avatar] as? String ?? ""
    }
}
