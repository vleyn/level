//
//  CustomTabbarVM.swift
//  level
//
//  Created by Vlad on 23.06.23.
//

import Foundation

final class CustomTabbarViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    
    @Published var tabs = ["Home", "News", "Messenger", "Profile"]
    @Published var selectedTab = "Home"
    @Published var avatar = ""
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    func cacheUser() {
        
        Task {
            if let uid = firebaseManager.auth.currentUser?.uid, uid != "" {
                do {
                    let user = try await firebaseManager.databaseRead(uid: uid)
                    let userCache = UserModel(uid: uid, nickname: user.nickname, email: user.email, avatar: user.avatar, bio: user.bio)
                    UserCache.shared.saveInfo(user: userCache)

                    await MainActor.run {
                        avatar = userCache.avatar
                    }
                } catch {
                    await MainActor.run {
                        errorText = error.localizedDescription
                    }
                }
            }
        }
    }
}
