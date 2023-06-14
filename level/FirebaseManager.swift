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
    func databaseWrite(name: String, surname: String, nickname: String, email: String, avatar: String, uid: String) async
    func databaseRead(uid: String) async throws -> UserModel
    func currentLoginnedUser() -> User?
}

class FirebaseManager: FirebaseProtocol {
    
    let firebaseAuth = Auth.auth()
    let database = Firestore.firestore()
    let ref = Database.database().reference()
    
    func signUpEmail(email: String, password: String) async throws -> User {
        try await Auth.auth().createUser(withEmail: email, password: password).user
    }
    
    func login(email: String, password: String) async throws -> User {
        try await Auth.auth().signIn(withEmail: email, password: password).user
    }
    
    func logOut() async throws {
        try firebaseAuth.signOut()
    }
    
    func databaseWrite(name: String, surname: String, nickname: String, email: String, avatar: String, uid: String) async {
        
        let user = UserModel(name: name, surname: surname, nickname: nickname, email: email, avatar: avatar)
        
        do {
           try database.collection("Users").document(uid).setData(from: user)
        } catch {
            print("Error write user")
        }
    }
    
    func databaseRead(uid: String) async throws -> UserModel  {
        try await database.collection("Users").document(uid).getDocument(as: UserModel.self)
    }
    
    //MARK: - Debug
    func currentLoginnedUser() -> User? {
        firebaseAuth.currentUser
    }
}
