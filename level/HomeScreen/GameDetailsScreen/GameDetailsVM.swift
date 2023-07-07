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
    
    func getAdditionalInfo(id: Int) async {
        do {
            let data = try await apiManager.gameDetailsRequest(id: id)
            await MainActor.run {
                additionalInfo = data
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
    
    func getGameTrailer(id: Int) async {
        do {
            let data = try await apiManager.gameTrailersRequest(id: id)
            await MainActor.run {
                gameTrailers = data
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
}
