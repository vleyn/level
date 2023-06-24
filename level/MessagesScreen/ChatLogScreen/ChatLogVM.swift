//
//  ChatLogVM.swift
//  level
//
//  Created by Vlad on 23.06.23.
//

import Foundation
import Firebase

final class ChatLogViewModel: ObservableObject {
    
    let firebaseManager: FirebaseProtocol = FirebaseManager()
    let emptyScrollToString = "Empty"
    
    @Published var chatText = ""
    @Published var chatMessages = [ChatMessageModel]()
    @Published var newMessageCount = 0
    
    let chatUser: ChatUser?
    var currentUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        fetchMessages()
    }
    
    func handleSend() {
        Task {
            print(chatText)
            guard let fromId = self.firebaseManager.auth.currentUser?.uid else { return }
            
            guard let toId = self.chatUser?.uid else { return }
            
            let document = firebaseManager.database.collection("Messages")
                .document(fromId)
                .collection(toId)
                .document()
            
            let messageData = [MessagesConstants.fromId: fromId, MessagesConstants.toId: toId, MessagesConstants.text: self.chatText, "timestamp": Timestamp()] as [String : Any]
            
            do {
                try await document.setData(messageData)
                await MainActor.run {
                    persistRecentMessage()
                    self.chatText = ""
                    self.newMessageCount += 1
                }
            } catch {
                print(error.localizedDescription)
            }
                        
            let recipientMessageDocument = firebaseManager.database.collection("Messages")
                .document(toId)
                .collection(fromId)
                .document()
            
            do {
                try await recipientMessageDocument.setData(messageData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchMessages() {
        guard let fromId = firebaseManager.auth.currentUser?.uid else { return }
        guard let toId = chatUser?.uid else { return }
        firebaseManager.database
            .collection("Messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
                    }
                })
                DispatchQueue.main.async {
                    self.newMessageCount += 1
                }
            }
    }
    
    private func persistRecentMessage() {
        guard let chatUser = chatUser else { return }
        guard let uid = firebaseManager.auth.currentUser?.uid else { return }
        guard let toId = self.chatUser?.uid else { return }
        
        let document = firebaseManager.database
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .document(toId)
        
        let data = [
            DatabaseConstants.timestamp: Timestamp(),
            MessagesConstants.text: self.chatText,
            MessagesConstants.fromId: uid,
            MessagesConstants.toId: toId,
            DatabaseConstants.avatar: chatUser.avatar,
            DatabaseConstants.nickname: chatUser.nickname
        ] as [String : Any]
        
        document.setData(data)

        let currentUser = UserCache.shared.getInfo()
        
        let recipientRecentMessageDictionary = [
            DatabaseConstants.timestamp: Timestamp(),
            MessagesConstants.text: self.chatText,
            MessagesConstants.fromId: uid,
            MessagesConstants.toId: toId,
            DatabaseConstants.avatar: currentUser.avatar,
            DatabaseConstants.nickname: currentUser.nickname
        ] as [String : Any]
        
        firebaseManager.database
            .collection("recent_messages")
            .document(toId)
            .collection("messages")
            .document(currentUser.uid)
            .setData(recipientRecentMessageDictionary)
    }
}


