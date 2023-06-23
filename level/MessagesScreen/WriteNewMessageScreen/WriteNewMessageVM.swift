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
    
    func getAllUsers() async {
        do {
            let users = try await firebaseManager.getAllUsers()
            await MainActor.run {
                self.users = users
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}

