//
//  FirebaseManager.swift
//  level
//
//  Created by Владислав Мазуров on 11.06.23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FirebaseProtocol {
    func signUpEmail(email: String, password: String) async throws -> User
    func login(email: String, password: String) async throws -> User
    func logOut() async throws
    func currentLoginnedUser() -> User?
}

class FirebaseManager: FirebaseProtocol {
    
    let firebaseAuth = Auth.auth()
    let database = Firestore.firestore()
    
    func signUpEmail(email: String, password: String) async throws -> User {
        try await Auth.auth().createUser(withEmail: email, password: password).user
    }
    
    func login(email: String, password: String) async throws -> User {
        try await Auth.auth().signIn(withEmail: email, password: password).user
    }
    
    func logOut() async throws {
        try firebaseAuth.signOut()
    }
    
    //MARK: - Debug
    func currentLoginnedUser() -> User? {
        firebaseAuth.currentUser
    }
}
