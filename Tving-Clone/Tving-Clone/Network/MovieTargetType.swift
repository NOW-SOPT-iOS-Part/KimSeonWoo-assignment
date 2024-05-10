//
//  MovieTargetType.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 5/8/24.
//

import Foundation

import Moya

let BaseURL = Bundle.main.infoDictionary?["BASE_URL"] as! String
let APIKey = Bundle.main.infoDictionary?["API_KEY"] as! String

enum MovieTargetType {
    case getMovieData(itemPerPage: String)
}

extension MovieTargetType: TargetType {
    

    var baseURL: URL {
        return URL(string: BaseURL)!
    }
    
    var path: String {
        switch self {
        case .getMovieData(let itemPerPage):
            return "/boxoffice/searchDailyBoxOfficeList"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovieData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMovieData:
            return .requestParameters(parameters:
                                        ["key":APIKey, "targetDt":"20240501", "itemPerPage": "8"]
            , encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMovieData(let itemPerPage):
           return ["Content-Type": "application/json"]
        }
    }
}

