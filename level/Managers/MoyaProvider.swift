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
    func genreGameListRequest(page: Int, genres: Int) async throws -> GameList
    func gameDetailsRequest(id: Int) async throws -> GameDetail
    func getGameGenresRequest() async throws -> GameGenres
    func gameTrailersRequest(id: Int) async throws -> Trailers
    func getNewsRequest() async throws -> [GameNews]
}

class ApiManager: ApiProviderProtocol {
    
    private let providerRawg = MoyaProvider<ApiRequests>()
    
    func fullGameListRequest(page: Int) async throws -> GameList {
        return try await withCheckedThrowingContinuation { continuation in
            providerRawg.request(.fullGameListRequest(page: page)) { result in
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
    
    func genreGameListRequest(page: Int, genres: Int) async throws -> GameList {
        return try await withCheckedThrowingContinuation { continuation in
            providerRawg.request(.genreGameListRequest(page: page, genres: genres)) { result in
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
    
    func getNewsRequest() async throws -> [GameNews] {
        return try await withCheckedThrowingContinuation { continuation in
            providerRawg.request(.gameNewRequest) { result in
                switch result {
                case .success(let response):
                    do {
                        let news = try response.map([GameNews].self)
                        continuation.resume(returning: news)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
