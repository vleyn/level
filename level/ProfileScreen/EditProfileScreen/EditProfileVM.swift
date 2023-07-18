//
//  EditProfileVM.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import Foundation
import Kingfisher
import SwiftUI
import Combine

final class EditProfileViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    
    @Published var showImagePicker = false
    @Published var image: UIImage?
    @Published var avatar = ""
    @Published var nickname = ""
    @Published var email = ""
    @Published var bio = ""
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    func getUserInfo() {
        nickname = UserCache.shared.nickname
        email = UserCache.shared.email
        bio = UserCache.shared.bio
        avatar = UserCache.shared.avatar
    }
    
    func saveChanges() {
        
        Task {
            let uid = firebaseManager.auth.currentUser?.uid ?? ""
            let changedUser = UserModel(uid: uid, nickname: nickname, email: email, avatar: avatar, bio: bio, wishList: UserCache.shared.wishListId, purchasedGames: UserCache.shared.purchasedGamesId)
            firebaseManager.databaseEdit(user: changedUser)
            do {
                try await firebaseManager.databaseSaveImage(image: image)
                let fetchedUser = try await firebaseManager.databaseReadUser(uid: uid)
                let user = UserModel(uid: uid, nickname: nickname, email: email, avatar: fetchedUser.avatar, bio: bio, wishList: UserCache.shared.wishListId, purchasedGames: UserCache.shared.purchasedGamesId)
                UserCache.shared.saveInfo(user: user)
                await MainActor.run {
                    avatar = fetchedUser.avatar
                }
            } catch {
                await MainActor.run {
                    errorText = error.localizedDescription
                }
            }
        }
    }
}
