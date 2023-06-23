//
//  ChatLogVM.swift
//  level
//
//  Created by Vlad on 23.06.23.
//

import Foundation
import Firebase

struct ChatMessageModel: Identifiable {
    
    var documentId: String { id }
    
    let id: String
    let fromId, toId, text: String
    
    init(documentId: String, data: [String: Any]) {
        self.id = documentId
        self.fromId = data[MessagesConstants.fromId] as? String ?? ""
        self.toId = data[MessagesConstants.toId] as? String ?? ""
        self.text = data[MessagesConstants.text] as? String ?? ""
    }
}

final class ChatLogViewModel: ObservableObject {
    
    let firebaseManager: FirebaseProtocol = FirebaseManager()
    
    @Published var chatText = ""
    @Published var chatMessages = [ChatMessageModel]()
    
    let chatUser: ChatUser?
    
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
                    self.chatText = ""
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
        }
    }
}
    

