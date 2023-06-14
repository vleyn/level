//
//  RawgApi.swift
//  level
//
//  Created by Владислав Мазуров on 7.06.23.
//

import Foundation
import Moya

//enum GameGenres {
//    case action
//    case indie
//    case adventure
//    case RPG
//    case strategy
//    case shooter
//    case casual
//    case simulation
//    case puzzle
//    case arcade
//    case platformer
//    case massivelyMultiplayer
//    case racing
//    case sports
//    case fighting
//    case family
//    case boardGames
//    case educational
//    case card
//    
//    var genreId: Int {
//        switch self {
//        case .action: return 4
//        case .indie: return 51
//        case .adventure: return 3
//        case .RPG: return 5
//        case .strategy: return 10
//        case .shooter: return 2
//        case .casual: return 40
//        case .simulation: return 14
//        case .puzzle: return 7
//        case .arcade: return 11
//        case .platformer: return 83
//        case .massivelyMultiplayer: return 59
//        case .racing: return 1
//        case .sports: return 15
//        case .fighting: return 6
//        case .family: return 19
//        case .boardGames: return 28
//        case .educational: return 34
//        case .card: return 17
//        }
//    }
//}

enum RawgAPI {
    case fullGameListRequest(page: Int, genres: Int)
    case gameDetailsRequest(id: Int)
    case getGameGenresRequest
}

extension RawgAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .fullGameListRequest, .gameDetailsRequest, .getGameGenresRequest:
            guard let url = URL(string: "https://api.rawg.io/api/") else {
                fatalError("Wrong API url")
            }
            return url
        }
    }
        
    var path: String {
        switch self {
        case .fullGameListRequest:
            return "games"
        case .gameDetailsRequest(let id):
             return "games/\(id)"
        case .getGameGenresRequest:
            return "genres"
        }
    }

    var method: Moya.Method {
        .get
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
            
        switch self {
            case .fullGameListRequest(let page, let genres):
                params["page"] = page
                params["genres"] = genres
                params["key"] = returnApi
            case .gameDetailsRequest, .getGameGenresRequest:
                params["key"] = returnApi
            }
            return params
    }
        
    var parameterEncoding: ParameterEncoding {
            URLEncoding.default
    }
        
    var task: Task {
        guard let params = parameters else {
            return .requestPlain
        }
        return .requestParameters(parameters: params, encoding: parameterEncoding)
    }
        
    var headers: [String : String]? {
        nil
    }
    
    var returnApi: String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Check info.plist file!")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let api = plist?.object(forKey: "rawgApiKey") as? String else {
            fatalError("no api key")
        }
        return api
    }
}
