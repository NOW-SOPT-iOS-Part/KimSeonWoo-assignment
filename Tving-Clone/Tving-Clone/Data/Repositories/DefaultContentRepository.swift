//
//  DefaultContentRepository.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 6/7/24.
//

import Foundation
import Moya

final class DefaultContentRepository {
    
    private let contentDataSource: ContentDataSource

    init(contentDataSource: ContentDataSource) {
        self.contentDataSource = contentDataSource
    }
}

extension DefaultContentRepository: ContentRepository {
    func getMovieInfo(completion: @escaping (Result<[Content], any Error>) -> Void) {
        contentDataSource.getMovieInfo(completion: completion)
    }
    
    func getDetailInfo(code: String, completion: @escaping (Result<ContentDetail, any Error>) -> Void) {
        contentDataSource.getDetailInfo(code: code, completion: completion)
    }
}
