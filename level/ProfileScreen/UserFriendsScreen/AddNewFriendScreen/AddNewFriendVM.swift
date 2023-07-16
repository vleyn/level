//
//  AddNewFriendVM.swift
//  level
//
//  Created by Владислав Мазуров on 15.07.23.
//

import Foundation

final class AddNewFriendViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    @Published var users: [ChatUser] = []
    @Published var isSendRequest = false
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    func getAllUsers() async {
        
        do {
            let users = try await firebaseManager.getAllUsers()
            await MainActor.run {
                self.users = users
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
    
    func sendRequestToUser(targetUser: ChatUser) {
        
        Task {
            let fromId = UserCache.shared.getInfo()
            let toId = targetUser.uid
            
            let documentFromId = firebaseManager.database.collection("friend_requests")
                .document(fromId.uid)
                .collection("own_requests")
                .document(toId)
            
            let requestDataFromId = [DatabaseConstants.uid : toId,
                                     DatabaseConstants.nickname : targetUser.nickname,
                                     DatabaseConstants.avatar : targetUser.avatar
            ] as [String : Any]
            
            do {
                try await documentFromId.setData(requestDataFromId)
            } catch {
                await MainActor.run {
                    errorText = error.localizedDescription
                }
            }
            
            let documentToId = firebaseManager.database.collection("friend_requests")
                .document(toId)
                .collection("requests_to_you")
                .document(fromId.uid)
            
            let requestDataToId = [DatabaseConstants.uid : fromId.uid,
                                   DatabaseConstants.nickname : fromId.nickname,
                                   DatabaseConstants.avatar : fromId.avatar
            ] as [String : Any]
            
            do {
                try await documentToId.setData(requestDataToId)
            } catch {
                await MainActor.run {
                    errorText = error.localizedDescription
                }
            }
            await MainActor.run {
                isSendRequest = true
            }
        }
    }
    
}
