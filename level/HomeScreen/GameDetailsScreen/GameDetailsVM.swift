//
//  GameDetailsVM.swift
//  level
//
//  Created by Владислав Мазуров on 28.06.23.
//

import Foundation

final class GameDetailsViewModel: ObservableObject {
    
    private let apiManager: ApiProviderProtocol = ApiManager()
    
    @Published var gameInfo: Results?
    @Published var additionalInfo: GameDetail?
    @Published var gameTrailers: Trailers?
    @Published var isAlert = false
    @Published var isViewed = false
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
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
}
