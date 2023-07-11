//
//  SignUpVM.swift
//  level
//
//  Created by Владислав Мазуров on 14.06.23.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
            
    @Published var isPresented = false
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }

    func signUp() {
        
        guard password == confirmPassword else {
            errorText = ApplicationErrors.passwordsDontMatch.errorText
            return
        }
        
        guard !nickname.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty else {
            errorText = ApplicationErrors.emptyFields.errorText
            return
        }
        
        Task {
            do {
                let user = try await firebaseManager.signUpEmail(email: email, password: password)
                UserDefaults.standard.set(user.uid, forKey: "uid")
                let dataBaseUser = UserModel(uid: user.uid, nickname: nickname, email: email, avatar: "", bio: "", wishList: [])
                firebaseManager.databaseWrite(user: dataBaseUser)
                UserCache.shared.saveInfo(user: dataBaseUser)
                await MainActor.run {
                    self.isPresented = true
                }
            } catch {
                await MainActor.run {
                    errorText = error.localizedDescription
                }
            }
        }
    }
}
