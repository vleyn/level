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
    
    func loadUserInfo() async {
        do {
            guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
            let user = try await firebaseManager.databaseRead(uid: uid)
            await MainActor.run {
                nickName = user.nickname
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func logOut() async throws {
        try await firebaseManager.logOut()
        self.isLogout = true
    }
}
