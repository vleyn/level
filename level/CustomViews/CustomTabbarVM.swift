//
//  CustomTabbarVM.swift
//  level
//
//  Created by Vlad on 23.06.23.
//

import Foundation

final class CustomTabbarViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    
    func cacheUser() async {
        
        let uid = firebaseManager.auth.currentUser?.uid ?? ""
        do {
            let user = try await firebaseManager.databaseRead(uid: uid)
            await MainActor.run {
                let userCache = UserModel(uid: uid, nickname: user.nickname, email: user.email, avatar: user.avatar, bio: user.bio)
                UserCache.shared.saveInfo(user: userCache)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
