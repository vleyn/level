//
//  RawgApi.swift
//  level
//
//  Created by Владислав Мазуров on 7.06.23.
//

import Foundation
import Moya

enum RawgAPI {
    case fullGameListRequest(page: Int)
    case gameDetailsRequest(id: Int)
}

extension RawgAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .fullGameListRequest, .gameDetailsRequest:
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
        }
    }

    var method: Moya.Method {
        .get
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
            
        switch self {
            case .fullGameListRequest(let page):
                params["page"] = page
                params["key"] = returnApi
            case .gameDetailsRequest:
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
