//
//  HomeVM.swift
//  level
//
//  Created by Владислав Мазуров on 17.06.23.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    
    private let moyaManager: ApiProviderProtocol = ApiManager()

    let emptyScrollToString = "Empty"
    var currentPage: Int = 1
    @Published var tapToGenresButtonCount = 0
    @Published var genreResults: [Results] = []
    @Published var fullGameListResults: [Results] = []
    @Published var genres: [GenresResults] = []
    @Published var currentPickedGenre: GenresResults?
    @Published var allGenresPicked = true
    @Published var showSpinner = true
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    func getGameGenres() async {
        do {
            let genres = try await moyaManager.getGameGenresRequest()
            await MainActor.run {
                self.genres = genres.results ?? []
            }
            if let currentPickedGenre = currentPickedGenre {
                await getGameListByGenre(genres: currentPickedGenre)
            } else {
                await getFullGameList()
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
    
    func getGameListByGenre(genres: GenresResults) async {
        do {
            let data = try await moyaManager.genreGameListRequest(page: currentPage, genres: genres.id ?? 0)
            if let games = data.results {
                await MainActor.run {
                    allGenresPicked = false
                    showSpinner.toggle()
                    if genres.id != currentPickedGenre?.id {
                        genreResults.removeAll()
                        currentPage -= 1
                    }
                    currentPickedGenre = genres
                    genreResults += games
                    genreResults.removeLast()
                    currentPage += 1
                    showSpinner.toggle()
                }
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
    
    func getFullGameList() async {
        do {
            let data = try await moyaManager.fullGameListRequest(page: currentPage)
            if let games = data.results {
                await MainActor.run {
                    currentPickedGenre = nil
                    allGenresPicked = true
                    showSpinner.toggle()
                    fullGameListResults += games
                    currentPage += 1
                    showSpinner.toggle()
                }
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
    
}
