//
//  SignUpVM.swift
//  level
//
//  Created by Владислав Мазуров on 14.06.23.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    private let realmManager: RealmManagerProtocol = RealmManager()
            
    @Published var isPresented = false
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    func signUp() async {
        do {
            let user = try await firebaseManager.signUpEmail(email: email, password: password)
            UserDefaults.standard.set(user.uid, forKey: "uid")
            UserDefaults.standard.set(true, forKey: "isAuthorized")
            firebaseManager.databaseWrite(nickname: nickname, email: email, avatar: "", bio: "", uid: user.uid)
            let cachedUser = UserModel(nickname: nickname, email: email, avatar: "", bio: "")
            UserCache.shared.saveInfo(user: cachedUser)
            await MainActor.run {
                self.isPresented = true
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
