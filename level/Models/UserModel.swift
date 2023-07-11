//
//  UserModel.swift
//  level
//
//  Created by Владислав Мазуров on 14.06.23.
//

import Foundation
import Firebase

struct UserModel: Codable {
    var uid: String
    let nickname: String
    let email: String
    let avatar: String
    let bio: String
    var wishList: [Int]
    var purchasedGames: [Int]
}

struct ChatUser: Identifiable {
    var id: String { uid }
    let uid, nickname, avatar: String
    
    init(data: [String: Any]) {
        self.uid = data[ChatUserConstants.uid] as? String ?? ""
        self.nickname = data[ChatUserConstants.nickname] as? String ?? ""
        self.avatar = data[ChatUserConstants.avatar] as? String ?? ""
    }
}

struct RecentMessage: Identifiable {
    
    var id: String { documentId }
  
    let documentId: String
    let text, nickname, avatar: String
    let fromId, toId: String
    let timestamp: Timestamp
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.text = data[MessagesConstants.text] as? String ?? ""
        self.fromId = data[MessagesConstants.fromId] as? String ?? ""
        self.toId = data[MessagesConstants.toId] as? String ?? ""
        self.avatar = data[DatabaseConstants.avatar] as? String ?? ""
        self.nickname = data[DatabaseConstants.nickname] as? String ?? ""
        self.timestamp = data[DatabaseConstants.timestamp] as? Timestamp ?? Timestamp(date: Date())
    }
}
