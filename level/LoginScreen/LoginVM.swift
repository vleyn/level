//
//  LoginVM.swift
//  level
//
//  Created by Владислав Мазуров on 14.06.23.
//

import Foundation
import Firebase
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
            
    @Published var isPresented = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    func login() {
        
        guard !email.isEmpty && !password.isEmpty else {
            errorText = ApplicationErrors.emptyFields.errorText
            return
        }
        
        Task {
            do {
                let user = try await firebaseManager.login(email: email, password: password)
                let userInfo = try await firebaseManager.databaseReadUser(uid: user.uid)
                UserCache.shared.saveInfo(user: userInfo)
                UserDefaults.standard.set(user.uid, forKey: "uid")
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
