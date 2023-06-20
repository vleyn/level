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
    
    func login() async {
        do {
            let user = try await firebaseManager.login(email: email, password: password)
            let userInfo = try await firebaseManager.databaseRead(uid: user.uid)
            UserCache.shared.saveInfo(user: userInfo)
            UserDefaults.standard.set(user.uid, forKey: "uid")
            UserDefaults.standard.set(true, forKey: "isAuthorized")
            await MainActor.run {
                self.isPresented = true
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
