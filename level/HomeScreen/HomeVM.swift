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
    
    func getGameList(page: Int, genres: Int) async {
        do {
            var data = try await moyaManager.fullGameListRequest(page: page, genres: genres)
            if var games = data.results {
                results += games
            }
            print(results)
        } catch {
            print(error.localizedDescription)
        }
    }
}
