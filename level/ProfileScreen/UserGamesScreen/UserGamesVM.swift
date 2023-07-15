//
//  UserGamesVM.swift
//  level
//
//  Created by Владислав Мазуров on 11.07.23.
//

import Foundation
import SwiftUI

final class UserGamesViewModel: ObservableObject {
    
//    private let moyaManager: ApiProviderProtocol = ApiManager()
//    private let firebaseManager: FirebaseProtocol = FirebaseManager()
//
//    var purchasedGamesIds: [Int] = []
//    @Published var purchasedGames: [GameDetail] = []
//
//    func fetchGameList() async {
//        await MainActor.run { purchasedGames = [] }
//
//        do {
//            let currentUser = try await firebaseManager.databaseReadUser(uid: firebaseManager.auth.currentUser?.uid ?? "")
//            await MainActor.run {
//                purchasedGamesIds = currentUser.purchasedGames
//            }
//        } catch {}
//
//        for id in purchasedGamesIds {
//            do {
//                let game = try await moyaManager.gameDetailsRequest(id: id)
//                await MainActor.run {
//                    purchasedGames.append(game)
//                }
//            } catch {}
//        }
//    }
}

