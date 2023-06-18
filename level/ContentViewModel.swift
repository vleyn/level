//
//  ContentViewModel.swift
//  level
//
//  Created by Владислав Мазуров on 7.06.23.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    private let moyaManager: ApiProviderProtocol = ApiManager()
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    
//    @Published var email: String = "dobby@mail.ru"
//    @Published var password: String = "123456"
    
    func getGameList(page: Int, genres: Int) async {
        do {
            let data = try await moyaManager.fullGameListRequest(page: page, genres: genres)
            print(data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getGameData(id: Int) async {
        do {
            let data = try await moyaManager.gameDetailsRequest(id: id)
            print(data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getGameGenres() async {
        do {
            let genres = try await moyaManager.getGameGenresRequest()
            print(genres)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signUp(email: String, password: String) async {
        do {
            print(try await firebaseManager.signUpEmail(email: email, password: password))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func login(email: String, password: String) async {
        do {
            print(try await firebaseManager.login(email: email, password: password))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func logOut() async {
        do {
            try await firebaseManager.logOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func databaseWrite(nickName: String, email: String, avatar: String, uid: String) {
        firebaseManager.databaseWrite(nickname: nickName, email: email, avatar: avatar, uid: uid)
    }
    
    func databaseRead(uid: String) async throws {
        print(try await firebaseManager.databaseRead(uid: uid))
    }
    
    func currentLoginnedUser() {
//        print(firebaseManager.currentLoginnedUser()?.email)
    }
}
