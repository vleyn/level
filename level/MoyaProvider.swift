//
//  MoyaProvider.swift
//  level
//
//  Created by Владислав Мазуров on 7.06.23.
//

import Foundation
import Moya

protocol ApiProviderProtocol: AnyObject {
    func fullGameListRequest(page: Int) async throws -> GameList
    func gameDetailsRequest(id: Int) async throws -> GameDetail
}

class MoyaApiManager: ApiProviderProtocol {
    
    private let providerRawg = MoyaProvider<RawgAPI>()
    
    func fullGameListRequest(page: Int) async throws -> GameList {
        return try await withCheckedThrowingContinuation { continuation in
            providerRawg.request(.fullGameListRequest(page: page)) { result in
                switch result {
                case .success(let response):
                    print(response)
                    do {
                        let games = try response.map(GameList.self)
                        continuation.resume(with: .success(games))
                        print("success")
                        print(games)
                    } catch {
                        continuation.resume(throwing: error)
                        print("ne success")
                        print(error)
                    }
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                    print("failure")
                    
                }
            }
        }
    }
    
    func gameDetailsRequest(id: Int) async throws -> GameDetail {
        return try await withCheckedThrowingContinuation { continuation in
            providerRawg.request(.gameDetailsRequest(id: id)) { result in
                switch result {
                case .success(let response):
                    print(response)
                    do {
                        let gameData = try response.map(GameDetail.self)
                        continuation.resume(with: .success(gameData))
                        print("success")
                        print(gameData)
                    } catch {
                        continuation.resume(throwing: error)
                        print("ne success")
                        print(error)
                    }
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                    print("failure")
                }
            }
        }
    }
}
