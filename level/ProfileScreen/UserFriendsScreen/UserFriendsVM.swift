//
//  UserFriendsVM.swift
//  level
//
//  Created by Владислав Мазуров on 15.07.23.
//

import Foundation

final class UserFriendsViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    
    @Published var allUsersIsPresented = false
    @Published var friends: [FriendRequestModel] = []
    @Published var searchFriendText = ""
    var searchResults: [FriendRequestModel] {
        if searchFriendText.isEmpty {
            return friends
        } else {
            return friends.filter { $0.nickname.contains(searchFriendText) }
        }
    }
    
    func fetchUserFriends() {
        
        friends.removeAll()
        
        firebaseManager.database
            .collection("friend_requests")
            .document(firebaseManager.auth.currentUser?.uid ?? "")
            .collection("friends")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.friends.append(contentsOf: snapshot?.documentChanges.filter({$0.type == .added}).map({FriendRequestModel(documentId: $0.document.documentID, data: $0.document.data())}) ?? [FriendRequestModel(documentId: "", data: [:])])
            }
    }
    
}
