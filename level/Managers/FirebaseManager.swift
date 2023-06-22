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
    var auth: Auth { get }
    var database: Firestore { get }
    var ref: DatabaseReference { get }
    func signUpEmail(email: String, password: String) async throws -> User
    func login(email: String, password: String) async throws -> User
    func logOut() async throws
    func databaseWrite(nickname: String, email: String, avatar: String, bio: String, uid: String)
    func databaseEdit(uid: String, nickname: String, email: String, avatar: String, bio: String)
    func databaseRead(uid: String) async throws -> UserModel
}

class FirebaseManager: FirebaseProtocol {
    
    let auth = Auth.auth()
    let database = Firestore.firestore()
    let ref = Database.database().reference()
    
    func signUpEmail(email: String, password: String) async throws -> User {
        try await Auth.auth().createUser(withEmail: email, password: password).user
    }
    
    func login(email: String, password: String) async throws -> User {
        try await Auth.auth().signIn(withEmail: email, password: password).user
    }
    
    func logOut() async throws {
        try auth.signOut()
    }
    
    func databaseWrite(nickname: String, email: String, avatar: String, bio: String, uid: String) {

        let user = UserModel(uid: uid, nickname: nickname, email: email, avatar: avatar, bio: bio)
            do {
               try database.collection("Users").document(uid).setData(from: user)
            } catch {
                print("Error write user")
            }
        }
    
    func databaseEdit(uid: String, nickname: String, email: String, avatar: String, bio: String) {
        
        let users = database.collection("Users").document(uid)
        users.updateData(["nickname" : nickname,
                          "email" : email,
                          "avatar" : avatar,
                          "bio" : bio,
                          "uid" : uid ])
    }
    
    func databaseRead(uid: String) async throws -> UserModel  {
        try await database.collection("Users").document(uid).getDocument(as: UserModel.self)
    }
}
