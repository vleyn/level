//
//  GameDetailsVM.swift
//  level
//
//  Created by Владислав Мазуров on 28.06.23.
//

import Foundation

final class GameDetailsViewModel: ObservableObject {
    
    private let apiManager: ApiProviderProtocol = ApiManager()
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    
    @Published var additionalInfo: GameDetail?
    @Published var gameTrailers: Trailers?
    @Published var isAlert = false
    @Published var isViewed = false
    @Published var isWhishList = false
    @Published var showBuyMenu = false
    @Published var disableBuyButton = false
    @Published var isHaveDebitCard = false
    @Published var imgURL = ""
    @Published var showImageViewer = false
    @Published var gameCost = Int.random(in: 10..<100)
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    var fullRating: String?
    
    func getAdditionalInfo(id: Int) async {
        do {
            let detailsData = try await apiManager.gameDetailsRequest(id: id)
            let trailerData = try await apiManager.gameTrailersRequest(id: id)
            await MainActor.run {
                additionalInfo = detailsData
                if let rating = detailsData.rating, let ratingTop = detailsData.ratingTop {
                    fullRating = "\(rating) / \(ratingTop) ★"
                }
                gameTrailers = trailerData
            }
            await fetchUserWishList()
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
    
    func addToWishList() {
        isWhishList.toggle()
        Task {
            do {
                var currentUser = try await firebaseManager.databaseReadUser(uid: firebaseManager.auth.currentUser?.uid ?? "")
                if isWhishList {
                    currentUser.wishList.append(additionalInfo?.id ?? 0)
                    if let additionalInfo {
                        UserCache.shared.wishListGames.append(additionalInfo)
                    }
                } else {
                    currentUser.wishList = currentUser.wishList.filter({$0 != additionalInfo?.id})
                    UserCache.shared.wishListId = currentUser.wishList.filter({$0 != additionalInfo?.id})
                    if let additionalInfo {
                        UserCache.shared.wishListGames = UserCache.shared.wishListGames.filter({$0.id != additionalInfo.id})
                    }
                }
                firebaseManager.databaseEdit(user: currentUser)
            } catch {
                await MainActor.run {
                    errorText = error.localizedDescription
                }
            }
        }
    }
    
    func fetchUserWishList() async {
        do {
            let currentUser = try await firebaseManager.databaseReadUser(uid: firebaseManager.auth.currentUser?.uid ?? "")
            await MainActor.run {
                isWhishList = currentUser.wishList.contains(where: {$0 == additionalInfo?.id})
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
    
    func buyGame() {
        Task {
            do {
                let uid = firebaseManager.auth.currentUser?.uid ?? ""
                var currentUserBalance = try await firebaseManager.databaseReadCards(uid: uid)
                var currentUser = try await firebaseManager.databaseReadUser(uid: uid)
                if currentUserBalance.balance > gameCost {
                    await MainActor.run {
                        showBuyMenu.toggle()
                        disableBuyButton = true
                    }
                    currentUserBalance.balance = currentUserBalance.balance - gameCost
                    firebaseManager.databaseWriteCard(card: currentUserBalance)
                    currentUser.purchasedGames.append(additionalInfo?.id ?? 0)
                    if let additionalInfo {
                        UserCache.shared.purchasedGames.append(additionalInfo)
                    }
                    firebaseManager.databaseEdit(user: currentUser)
                    await MainActor.run {
                        errorText = "You have successfully purchased the game!"
                    }
                } else {
                    await MainActor.run {
                        showBuyMenu.toggle()
                    }
                    await MainActor.run {
                        errorText = "Oops. Something went wrong. Check your card balance"
                    }
                }
            } catch {
                await MainActor.run {
                    errorText = error.localizedDescription
                }
            }
        }
    }
    
    func fetchUserCard() async {
        do {
            let currentUserBalance = try await firebaseManager.databaseReadCards(uid: firebaseManager.auth.currentUser?.uid ?? "")
            await MainActor.run {
                isHaveDebitCard = !currentUserBalance.cardNumber.isEmpty
            }
        } catch {
            await MainActor.run {
                errorText = "\(error.localizedDescription) or user dont have a card"
            }
        }
    }
}
