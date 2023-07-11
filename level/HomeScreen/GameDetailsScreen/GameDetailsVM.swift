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
                var currentUser = try await firebaseManager.databaseRead(uid: firebaseManager.auth.currentUser?.uid ?? "")
                if isWhishList {
                    currentUser.wishList.append(additionalInfo?.id ?? 0)
                    UserCache.shared.wishList.append(additionalInfo?.id ?? 0)
                } else {
                    currentUser.wishList = currentUser.wishList.filter({$0 != additionalInfo?.id})
                    UserCache.shared.wishList = currentUser.wishList.filter({$0 != additionalInfo?.id})
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
            let currentUser = try await firebaseManager.databaseRead(uid: firebaseManager.auth.currentUser?.uid ?? "")
            if currentUser.wishList.contains(where: {$0 == additionalInfo?.id}) {
                await MainActor.run {
                    isWhishList = true
                }
            } else {
                await MainActor.run {
                    isWhishList = false
                }
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
}
