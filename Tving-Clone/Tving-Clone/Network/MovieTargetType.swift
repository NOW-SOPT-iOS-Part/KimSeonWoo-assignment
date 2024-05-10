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
    case getMovieData
    case getDetailData(code: String)
}

extension MovieTargetType: TargetType {
    

    var baseURL: URL {
        return URL(string: BaseURL)!
    }
    
    var path: String {
        switch self {
        case .getMovieData:
            return "/boxoffice/searchDailyBoxOfficeList"
        case .getDetailData(code: let code):
            return "/movie/searchMovieInfo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovieData:
            return .get
        case .getDetailData(code: let code):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMovieData:
            return .requestParameters(
                parameters:[
                    "key":APIKey,
                    "targetDt":"20240501",
                    "itemPerPage": "8"
                ],
                encoding: URLEncoding.default
            )
        case .getDetailData(code: let code):
            return .requestParameters(
                parameters:[
                    "key":APIKey,
                    "movieCd": code
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMovieData:
           return ["Content-Type": "application/json"]
        case .getDetailData(code: let code):
            return ["Content-Type": "application/json"]
        }
    }
}

