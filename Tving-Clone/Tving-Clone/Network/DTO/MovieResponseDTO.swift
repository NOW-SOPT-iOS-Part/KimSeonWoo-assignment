//
//  MovieResponseDTO.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 5/8/24.
//
import Foundation

struct MovieResponseDTO: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let rnum, rank, rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCd, movieNm, openDt, salesAmt: String
    let salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt, showCnt: String
    
    enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew
        case movieCd = "movieCd"
        case movieNm = "movieNm"
        case openDt, salesAmt, salesShare, salesInten, salesChange, salesAcc, audiCnt, audiInten, audiChange, audiAcc, scrnCnt, showCnt
    }
}

enum RankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}

extension MovieResponseDTO {
    func toDomain() -> [Content] {
        var mainDataModels: [Content] = []
        
        var tempData: [ContentData] = []
        for (index, boxOfficeData) in boxOfficeResult.dailyBoxOfficeList.enumerated() {
            let mainData = ContentData(image: "poster4",
                title: boxOfficeData.movieNm,
                maker: boxOfficeData.movieCd,
                subTitle: boxOfficeData.movieCd,
                ratio: boxOfficeData.movieCd
            )
            tempData.append(mainData)
            
            if (index + 1) % 8 == 0 || index == boxOfficeResult.dailyBoxOfficeList.count - 1 {
                let mainDataModel = Content(data: tempData)
                mainDataModels.append(mainDataModel)
                tempData.removeAll()
            }
        }
        
        while mainDataModels.count < 6 {
            mainDataModels.append(contentsOf: mainDataModels)
        }
        
        mainDataModels = Array(mainDataModels.prefix(6))
        
        return mainDataModels
    }
}
