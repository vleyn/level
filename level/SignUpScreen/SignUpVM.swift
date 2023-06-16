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
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    func signUp() async {
        do {
            print(try await firebaseManager.signUpEmail(email: email, password: password))
        } catch {
            print(error.localizedDescription)
        }
    }
}
