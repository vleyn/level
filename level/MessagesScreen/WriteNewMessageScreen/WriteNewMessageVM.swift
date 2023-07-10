//
//  WriteNewMessageVM.swift
//  level
//
//  Created by Vlad on 23.06.23.
//

import Foundation

final class WriteNewMessageViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    @Published var users: [ChatUser] = []
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
}


