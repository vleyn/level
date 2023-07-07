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
    @Published var genres: [GenresResults] = []
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    @Published var currentPickedGenre: GenresResults?
    
    func getGameList(genres: GenresResults) async {
        do {
            let data = try await moyaManager.fullGameListRequest(page: currentPage, genres: genres.id ?? 0)
            if let games = data.results {
                await MainActor.run {
                    results = games
                    currentPickedGenre = genres
                }
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
    
    func getGameGenres() async {
        do {
            let genres = try await moyaManager.getGameGenresRequest()
            await MainActor.run {
                self.genres = genres.results ?? []
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
}
