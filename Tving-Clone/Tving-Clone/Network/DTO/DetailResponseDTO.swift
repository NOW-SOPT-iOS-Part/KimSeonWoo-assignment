//
//  MovieDetailDTO.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 5/10/24.
//

import Foundation

struct DetailResponseDTO: Codable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
    let source: String
}

struct MovieInfo: Codable {
    let movieCd, movieNm, movieNmEn, showTm: String
    let prdtYear, openDt, prdtStatNm, typeNm: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Crew]
    let actors: [Crew]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]

    enum CodingKeys: String, CodingKey {
        case movieCd, showTm
        case movieNm, movieNmEn, prdtYear, openDt, prdtStatNm, typeNm, nations, genres, directors, actors, showTypes, companys, audits
    }
}

struct Crew: Codable {
    let peopleNm, peopleNmEn: String
    let cast: String?
    let castEn: String?
}

struct Audit: Codable {
    let auditNo, watchGradeNm: String
}

struct Company: Codable {
    let companyCd, companyNm, companyNmEn, companyPartNm: String
}

struct Genre: Codable {
    let genreNm: String
}

struct Nation: Codable {
    let nationNm: String
}

struct ShowType: Codable {
    let showTypeGroupNm, showTypeNm: String
}

extension DetailResponseDTO {
    func toDomain() -> ContentDetail {
        let movieInfo = self.movieInfoResult.movieInfo

        let title = movieInfo.movieNm
        let openDt = movieInfo.openDt
        let directors = movieInfo.directors.first?.peopleNm ?? ""
        let actors = movieInfo.actors.first?.peopleNm ?? ""
        let audits = movieInfo.audits.first?.auditNo ?? ""
        let companys = movieInfo.companys.first?.companyNm ?? ""

        return ContentDetail(
            title: title,
            openDt: openDt,
            directors: directors,
            actors: actors,
            audits: audits,
            companys: companys
        )
    }
}
