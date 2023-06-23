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
//    
//    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
//    private var shouldDismissView = false {
//        didSet {
//            viewDismissalModePublisher.send(shouldDismissView)
//        }
//    }
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    
    @Published var showImagePicker = false
    @Published var image: UIImage?

    
    @Published var avatar = ""
    @Published var nickname = ""
    @Published var email = ""
    @Published var bio = ""
    
    func getUserInfo() {
        nickname = UserCache.shared.nickname
        email = UserCache.shared.email
        bio = UserCache.shared.bio
        avatar = UserCache.shared.avatar
    }
    
    func saveChanges() {
        
        Task {
            let uid = firebaseManager.auth.currentUser?.uid ?? ""
            firebaseManager.databaseEdit(uid: uid, nickname: nickname, email: email, avatar: avatar, bio: bio)
            do {
                try await firebaseManager.databaseSaveImage(image: image)
                let fetchedUser = try await firebaseManager.databaseRead(uid: uid)
                await MainActor.run {
                    let user = UserModel(uid: uid, nickname: nickname, email: email, avatar: fetchedUser.avatar, bio: bio)
                    UserCache.shared.saveInfo(user: user)
                    avatar = fetchedUser.avatar
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.shouldDismissView = true
//        }
    }
}
