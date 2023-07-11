//
//  UserWishListVM.swift
//  level
//
//  Created by Владислав Мазуров on 11.07.23.
//

import Foundation
import SwiftUI

final class UserWishListViewModel: ObservableObject {
    
    private let moyaManager: ApiProviderProtocol = ApiManager()
    private let firebaseManager: FirebaseProtocol = FirebaseManager()

    var wishListIds: [Int] = []
    @Published var wishListGames: [GameDetail] = []
    
    func fetchWishList() async {
        await MainActor.run {
            wishListGames = []
        }
        do {
            let currentUser = try await firebaseManager.databaseReadUser(uid: firebaseManager.auth.currentUser?.uid ?? "")
            await MainActor.run {
                wishListIds = currentUser.wishList
            }
        } catch {
            
        }
        for id in wishListIds {
            do {
                let game = try await moyaManager.gameDetailsRequest(id: id)
                await MainActor.run {
                    withAnimation {
                        wishListGames.append(game)
                    }
                }
            } catch {
                
            }
        }
    }
}
