//
//  HomeVM.swift
//  level
//
//  Created by Владислав Мазуров on 17.06.23.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    private let moyaManager: ApiProviderProtocol = ApiManager()

    @Published var results: [Results] = []
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    func getGameList(page: Int, genres: Int) async {
        do {
            let data = try await moyaManager.fullGameListRequest(page: page, genres: genres)
            if let games = data.results {
                await MainActor.run {
                    results += games
                }
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
}
