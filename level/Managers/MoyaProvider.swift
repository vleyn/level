//
//  MoyaProvider.swift
//  level
//
//  Created by Владислав Мазуров on 7.06.23.
//

import Foundation
import Moya

protocol ApiProviderProtocol: AnyObject {
    func fullGameListRequest(page: Int, genres: Int) async throws -> GameList
    func gameDetailsRequest(id: Int) async throws -> GameDetail
    func getGameGenresRequest() async throws -> GameGenres
    func gameTrailersRequest(id: Int) async throws -> Trailers
}

class ApiManager: ApiProviderProtocol {
    
    private let providerRawg = MoyaProvider<RawgAPI>()
    
    func fullGameListRequest(page: Int, genres: Int) async throws -> GameList {
        return try await withCheckedThrowingContinuation { continuation in
            providerRawg.request(.fullGameListRequest(page: page, genres: genres)) { result in
                switch result {
                case .success(let response):
                    do {
                        let games = try response.map(GameList.self)
                        continuation.resume(with: .success(games))
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    func gameDetailsRequest(id: Int) async throws -> GameDetail {
        return try await withCheckedThrowingContinuation { continuation in
            providerRawg.request(.gameDetailsRequest(id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let gameData = try response.map(GameDetail.self)
                        continuation.resume(with: .success(gameData))
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    func getGameGenresRequest() async throws -> GameGenres {
        return try await withCheckedThrowingContinuation { continuation in
            providerRawg.request(.getGameGenresRequest) { result in
                switch result {
                case .success(let response):
                    do {
                        let genres = try response.map(GameGenres.self)
                        continuation.resume(with: .success(genres))
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    func gameTrailersRequest(id: Int) async throws -> Trailers {
        return try await withCheckedThrowingContinuation { continuation in
            providerRawg.request(.gameTrailersRequest(id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let trailers = try response.map(Trailers.self)
                        continuation.resume(with: .success(trailers))
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}
