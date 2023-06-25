//
//  MessagesVM.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import Foundation

final class MessagesViewModel: ObservableObject {
    
    let firebaseManager: FirebaseProtocol = FirebaseManager()
    
    @Published var chatUser: UserModel?
    @Published var recentMessages = [RecentMessage]()
    @Published var showNewMessageScreen: Bool = false
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    func getChatUser() {
        
        chatUser = UserModel(uid: UserCache.shared.uid,
                             nickname: UserCache.shared.nickname,
                             email: UserCache.shared.email,
                             avatar: UserCache.shared.avatar,
                             bio: UserCache.shared.bio)
    }
    
    func getRecentMessages() {
        guard let uid = firebaseManager.auth.currentUser?.uid else { return }
        
        firebaseManager.database
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorText = error.localizedDescription
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    let docId = change.document.documentID
                    
                    if let index = self.recentMessages.firstIndex(where: { rm in
                        return rm.documentId == docId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    self.recentMessages.insert(.init(documentId: docId, data: change.document.data()), at: 0)
                })
            }
    }
    
}

