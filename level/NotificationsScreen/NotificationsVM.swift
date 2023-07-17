//
//  NotificationsVM.swift
//  level
//
//  Created by Владислав Мазуров on 15.07.23.
//

import Foundation

enum ProcessingRequest {
    case accept
    case decline
}


final class NotificationsViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    @Published var requests: [FriendRequestModel] = []
    
    func fetchIncomingRequests() {
        
        requests = []
        
        firebaseManager.database
            .collection("friend_requests")
            .document(firebaseManager.auth.currentUser?.uid ?? "")
            .collection("requests_to_you")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.requests.append(contentsOf: snapshot?.documentChanges.filter({$0.type == .added}).map({FriendRequestModel(id: $0.document.documentID, data: $0.document.data())}) ?? [FriendRequestModel(id: "", data: [:])])
        }
    }
    
    func proccessingRequest(action: ProcessingRequest, request: FriendRequestModel) {
        switch action {
        case .accept:
            
            firebaseManager.database
                .collection("friend_requests")
                .document(firebaseManager.auth.currentUser?.uid ?? "")
                .collection("requests_to_you")
                .document(request.uid)
                .delete()
            
            firebaseManager.database
                .collection("friend_requests")
                .document(request.uid)
                .collection("own_requests")
                .document(firebaseManager.auth.currentUser?.uid ?? "")
                .delete()
            
            let friendsFrom = firebaseManager.database
                .collection("friend_requests")
                .document(firebaseManager.auth.currentUser?.uid ?? "")
                .collection("friends")
                .document(request.uid)
            
            let friendsTo = firebaseManager.database
                .collection("friend_requests")
                .document(request.id)
                .collection("friends")
                .document(firebaseManager.auth.currentUser?.uid ?? "")
            
            let friendDataFrom = [DatabaseConstants.uid : request.uid,
                                  DatabaseConstants.nickname : request.nickname,
                                  DatabaseConstants.avatar : request.avatar
                                ] as [String : Any]
            
            let friendDataTo = [DatabaseConstants.uid : UserCache.shared.uid,
                                DatabaseConstants.nickname : UserCache.shared.nickname,
                                DatabaseConstants.avatar : UserCache.shared.avatar
                                ] as [String : Any]
            
            
            friendsFrom.setData(friendDataFrom)
            friendsTo.setData(friendDataTo)
            
            requests = requests.filter({$0.id != request.id})
            
        case .decline:
            firebaseManager.database
                .collection("friend_requests")
                .document(firebaseManager.auth.currentUser?.uid ?? "")
                .collection("requests_to_you")
                .document(request.uid)
                .delete()
            
            firebaseManager.database
                .collection("friend_requests")
                .document(request.uid)
                .collection("own_requests")
                .document(firebaseManager.auth.currentUser?.uid ?? "")
                .delete()
            
            requests = requests.filter({$0.id != request.id})
        }
    }
    
}
