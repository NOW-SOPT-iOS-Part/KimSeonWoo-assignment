//
//  ContentDataSource.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 6/7/24.
//

import Foundation

import Moya

class ContentDataSource {
    private var movieProvider = MoyaProvider<MovieTargetType>(plugins: [MoyaLoggingPlugin()])
}

extension ContentDataSource {
    func getMovieInfo(completion: @escaping (Result<[Content], Error>) -> Void) {
        movieProvider.request(.getMovieData) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                do {
                    let networkResult = try self.judgeStatus(by: statusCode, data, MovieResponseDTO.self).toAppData()
                    completion(.success(networkResult))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDetailInfo(code: String, completion: @escaping (Result<ContentDetail, Error>) -> Void) {
        movieProvider.request(.getDetailData(code: code)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                do {
                    let networkResult = try self.judgeStatus(by: statusCode, data, DetailResponseDTO.self).toDomain()
                    completion(.success(networkResult))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) throws -> T {
        switch statusCode {
        case 200..<205:
            return try isValidData(data: data, T.self)
        case 400..<500:
            throw NetworkError.requestError
        case 500:
            throw NetworkError.serverError
        default:
            throw NetworkError.networkFailure
        }
    }
    
    private func isValidData<T: Codable>(data: Data, _ object: T.Type) throws -> T {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("⛔️ 디코딩 오류가 발생했습니다 ⛔️")
            throw NetworkError.decodingError
        }
        return decodedData
    }
}

enum NetworkError: Error {
    case requestError
    case serverError
    case networkFailure
    case decodingError
}
