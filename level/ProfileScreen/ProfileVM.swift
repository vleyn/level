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
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    func loadUserInfo() {
        nickName = UserCache.shared.nickname
    }
    
    func logOut() async throws {
        do {
            try await firebaseManager.logOut()
        } catch {
            
        }
        UserDefaults.standard.set(false, forKey: "isAuthorized")
        await MainActor.run {
            self.isLogout = true
        }
    }
}
