//
//  FetchContentUseCase.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 6/7/24.
//

import Foundation

protocol ContentUseCase {
    func fetchContent(completion: @escaping (Result<[Content], Error>) -> Void)
    func fetchContentDetail(code: String, completion: @escaping (Result<ContentDetail, Error>) -> Void)
}

final class DefaultContentUseCase {

    private let repository: ContentRepository

    init(repository: ContentRepository) {
        self.repository = repository
    }
}

extension DefaultContentUseCase: ContentUseCase {
    func fetchContent(completion: @escaping (Result<[Content], any Error>) -> Void) {
        repository.getMovieInfo(completion: completion)
    }
    
    func fetchContentDetail(code: String, completion: @escaping (Result<ContentDetail, any Error>) -> Void) {
        repository.getDetailInfo(code: code, completion: completion)
    }
}
