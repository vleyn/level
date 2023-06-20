//
//  ProfileVM.swift
//  level
//
//  Created by Владислав Мазуров on 16.06.23.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
            
    @Published var nickName = ""
    @Published var isLogout = false
    
    func loadUserInfo() {
        nickName = UserCache.shared.nickname
    }
    
    func logOut() async throws {
        try await firebaseManager.logOut()
        UserDefaults.standard.set(false, forKey: "isAuthorized")
        await MainActor.run {
            self.isLogout = true
        }
    }
}
