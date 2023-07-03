//
//  GameDetailsVM.swift
//  level
//
//  Created by Владислав Мазуров on 28.06.23.
//

import Foundation

final class GameDetailsViewModel: ObservableObject {
    
    private let apiManager: ApiProviderProtocol = ApiManager()
    
    @Published var gameInfo: GameDetail?
    @Published var isAlert = false
    @Published var isViewed = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    func getGameInfo(id: Int) async {
        do {
            let data = try await apiManager.gameDetailsRequest(id: id)
            await MainActor.run {
                gameInfo = data
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
}
