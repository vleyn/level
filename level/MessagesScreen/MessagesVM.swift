//
//  MessagesVM.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import Foundation

final class MessagesViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    
    @Published var chatUser: UserModel?
    @Published var showNewMessageScreen: Bool = false
    
    func getChatUser() {
        
        chatUser = UserModel(uid: UserCache.shared.uid,
                             nickname: UserCache.shared.nickname,
                             email: UserCache.shared.email,
                             avatar: UserCache.shared.avatar,
                             bio: UserCache.shared.bio)
    }
}
