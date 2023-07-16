//
//  WriteNewMessageVM.swift
//  level
//
//  Created by Vlad on 23.06.23.
//

import Foundation

final class WriteNewMessageViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    @Published var friends: [ChatUser] = []
    @Published var isAlert = false
    @Published var errorText = "" {
            didSet {
                isAlert = true
            }
        }
    
    func getAllUsers() async {
        do {
            let friends = try await firebaseManager.getUserFriends()
            await MainActor.run {
                self.friends = friends
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
}


