//
//  ContentViewModel.swift
//  level
//
//  Created by Владислав Мазуров on 7.06.23.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    let moyaManager: ApiProviderProtocol = MoyaApiManager()
    
    func getListGames(page: Int) async throws -> GameList {
        try await moyaManager.fullGameListRequest(page: page)
    }
    
    func getGameData(id: Int) async throws -> GameDetail {
        try await moyaManager.gameDetailsRequest(id: id)
    }
    
}
