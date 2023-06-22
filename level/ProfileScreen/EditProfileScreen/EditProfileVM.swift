//
//  EditProfileVM.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import Foundation
import Kingfisher

final class EditProfileViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    
    @Published var avatar = ""
    @Published var nickname = ""
    @Published var email = ""
    @Published var bio = ""
    
    func getUserInfo() {
        nickname = UserCache.shared.nickname
        email = UserCache.shared.email
        bio = UserCache.shared.bio
    }
    
    func saveChanges() {
        
        let uid = firebaseManager.auth.currentUser?.uid ?? ""
        
        firebaseManager.databaseEdit(uid: uid, nickname: nickname, email: email, avatar: avatar, bio: bio)
        
        let user = UserModel(uid: uid, nickname: nickname, email: email, avatar: avatar, bio: bio)
        UserCache.shared.saveInfo(user: user)
        
    }
}
