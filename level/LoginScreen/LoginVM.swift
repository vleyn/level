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
            print(try await firebaseManager.login(email: email, password: password))
        } catch {
            print(error.localizedDescription)
        }
    }
}
