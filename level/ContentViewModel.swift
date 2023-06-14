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
    
    @Published var email: String = "dobby@mail.ru"
    @Published var password: String = "123456"
    
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
    
    func signUpEmail() async {
        do {
            print(try await firebaseManager.signUpEmail(email: email, password: password))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func login() async {
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
    
    func databaseWrite() async {
        await firebaseManager.databaseWrite(name: "Vlad", surname: "Leyn", nickname: "vleyn", email: "ruuwuu@mail.ru", avatar: "avatar", uid: "12345")
    }
    
    func databaseRead() async throws {
        print(try await firebaseManager.databaseRead(uid: "12345"))
    }
    
    func currentLoginnedUser() {
        print(firebaseManager.currentLoginnedUser()?.email)
    }
}
