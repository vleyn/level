//
//  RawgApi.swift
//  level
//
//  Created by Владислав Мазуров on 7.06.23.
//

import Foundation
import Moya

enum ApiRequests {
    case fullGameListRequest(page: Int)
    case genreGameListRequest(page: Int, genres: Int)
    case gameDetailsRequest(id: Int)
    case getGameGenresRequest
    case gameTrailersRequest(id: Int)
    case gameNewRequest
}

extension ApiRequests: TargetType {
    
    var baseURL: URL {
        switch self {
        case .genreGameListRequest, .gameDetailsRequest, .getGameGenresRequest, .gameTrailersRequest, .fullGameListRequest:
            guard let url = URL(string: "https://api.rawg.io/api/") else {
                fatalError("Wrong API url")
            }
            return url
        case .gameNewRequest:
            guard let url = URL(string: "https://6498c7099543ce0f49e24deb.mockapi.io/api/") else {
                fatalError("Wrong API url")
            }
            return url
        }
    }
        
    var path: String {
        switch self {
        case .genreGameListRequest, .fullGameListRequest:
            return "games"
        case .gameDetailsRequest(let id):
             return "games/\(id)"
        case .getGameGenresRequest:
            return "genres"
        case .gameTrailersRequest(let id):
            return "games/\(id)/movies"
        case .gameNewRequest:
            return "level/news"
        }
    }

    var method: Moya.Method {
        .get
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
            
        switch self {
            case .genreGameListRequest(let page, let genres):
                params["page"] = page
                params["genres"] = genres
                params["key"] = returnApi
            case .gameDetailsRequest, .getGameGenresRequest, .gameTrailersRequest:
                params["key"] = returnApi
            case .fullGameListRequest(let page):
                params["page"] = page
                params["key"] = returnApi
            case .gameNewRequest:
                return params
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
