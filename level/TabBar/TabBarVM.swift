//
//  CustomTabbarVM.swift
//  level
//
//  Created by Vlad on 23.06.23.
//

import Foundation

final class TabBarViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    private let moyaManager: ApiProviderProtocol = ApiManager()

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
                    let user = try await firebaseManager.databaseReadUser(uid: uid)
                    for id in user.wishList {
                        UserCache.shared.wishListGames.append(try await moyaManager.gameDetailsRequest(id: id))
                    }
                    for id in user.purchasedGames {
                        UserCache.shared.purchasedGames.append(try await moyaManager.gameDetailsRequest(id: id))
                    }
                    let userCache = UserModel(uid: uid, nickname: user.nickname, email: user.email, avatar: user.avatar, bio: user.bio, wishList: user.wishList, purchasedGames: user.purchasedGames)
                    UserCache.shared.saveInfo(user: userCache)
                } catch {
                    await MainActor.run {
                        errorText = error.localizedDescription
                    }
                }
            }
        }
    }
}
