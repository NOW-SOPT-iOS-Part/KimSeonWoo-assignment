//
//  MovieService.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 5/8/24.
//

import Foundation

import Moya

final class MovieService {
    static let shared = MovieService()
    private var movieProvider = MoyaProvider<MovieTargetType>(plugins: [MoyaLoggingPlugin()])
    
    private init() {}
}

extension MovieService {
    func getMovieInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        movieProvider.request(.getMovieData) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, MovieResponseDTO.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getDetailInfo(code: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        movieProvider.request(.getDetailData(code: code)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, DetailResponseDTO.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    
    public func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        
        switch statusCode {
        case 200..<205:
            return isValidData(data: data, T.self)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    
    private func isValidData<T: Codable>(data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("⛔️ \(self)에서 디코딩 오류가 발생했습니다 ⛔️")
            return .pathErr
        }

        if let movieResponseDTO = decodedData as? MovieResponseDTO {
            let appData = movieResponseDTO.toAppData()
            return .success(appData as Any)
        } else if let detailResponseDTO = decodedData as? DetailResponseDTO {
            let appData = detailResponseDTO.toAppData()
            return .success(appData as Any)
        } else {
            return .pathErr
        }
    }
}


