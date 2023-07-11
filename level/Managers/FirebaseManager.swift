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
    var storage: Storage { get }
    var ref: DatabaseReference { get }
    func signUpEmail(email: String, password: String) async throws -> User
    func login(email: String, password: String) async throws -> User
    func logOut() async throws
    func databaseWrite(user: UserModel)
    func databaseEdit(user: UserModel)
    func databaseRead(uid: String) async throws -> UserModel
    func databaseSaveImage(image: UIImage?) async throws
    func getAllUsers() async throws -> [ChatUser]
}

class FirebaseManager: FirebaseProtocol {
    
    let auth = Auth.auth()
    let database = Firestore.firestore()
    let storage = Storage.storage()
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
    
    func databaseWrite(user: UserModel) {

        let user = UserModel(uid: user.uid, nickname: user.nickname, email: user.email, avatar: user.avatar, bio: user.bio, wishList: user.wishList)
            do {
                try database.collection("Users").document(user.uid).setData(from: user)
            } catch {
                print("Error write user")
            }
        }
    
    func databaseEdit(user: UserModel) {
        
        let dataBaseUser = database.collection("Users").document(user.uid)
        dataBaseUser.updateData([DatabaseConstants.nickname : user.nickname,
                                 DatabaseConstants.email : user.email,
                                 DatabaseConstants.avatar : user.avatar,
                                 DatabaseConstants.bio : user.bio,
                                 DatabaseConstants.uid : user.uid,
                                 DatabaseConstants.wishList: user.wishList
                                ])
    }
    
    func databaseRead(uid: String) async throws -> UserModel  {
        try await database.collection("Users").document(uid).getDocument(as: UserModel.self)
    }
    
    func databaseSaveImage(image: UIImage?) async throws {
        let uid = auth.currentUser?.uid ?? ""
        let ref = storage.reference(withPath: uid)
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData)
        let url = try await ref.downloadURL()
        self.attachUserImageUrl(uid: uid, url: url)
    }
    
    private func attachUserImageUrl(uid: String, url: URL) {
        let user = database.collection("Users").document(uid)
        user.updateData([DatabaseConstants.avatar : url.absoluteString])
    }
    
    func getAllUsers() async throws -> [ChatUser] {
            
        var users: [ChatUser] = []
            
        let collection = try await database.collection("Users").getDocuments()
            collection.documents.forEach { document in
                let user = ChatUser(data: document.data())
                if user.uid != auth.currentUser?.uid {
                    users.append(user)
                }
            }
            return users
        }
}
