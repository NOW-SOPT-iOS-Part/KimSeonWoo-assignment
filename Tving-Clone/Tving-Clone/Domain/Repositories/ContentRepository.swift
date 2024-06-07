//
//  ContentRepository.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 6/7/24.
//

import Foundation

protocol ContentRepository {
    func getMovieInfo(completion: @escaping (Result<[Content], Error>) -> Void)
    func getDetailInfo(code: String, completion: @escaping (Result<ContentDetail, Error>) -> Void)
}
