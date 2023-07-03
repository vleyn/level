//
//  HomeVM.swift
//  level
//
//  Created by Владислав Мазуров on 17.06.23.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    private let moyaManager: ApiProviderProtocol = ApiManager()

    var currentPage: Int = 1
    @Published var results: [Results] = []
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    func getGameList(genres: Int) async {
        do {
            let data = try await moyaManager.fullGameListRequest(page: currentPage, genres: genres)
            if let games = data.results {
                await MainActor.run {
                    results += games
                    currentPage += 1
                }
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
}
