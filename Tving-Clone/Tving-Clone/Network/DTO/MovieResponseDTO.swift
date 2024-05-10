//
//  MovieResponseDTO.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 5/8/24.
//
import Foundation

// MARK: - Dto
struct MovieResponseDTO: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
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
    func toAppData() -> [MainDataModel] {
        var mainDataModels: [MainDataModel] = []
        
        var tempData: [MainData] = []
        for (index, boxOfficeData) in boxOfficeResult.dailyBoxOfficeList.enumerated() {
            let mainData = MainData(
                image: .poster4,
                title: boxOfficeData.movieNm,
                maker: boxOfficeData.salesChange,
                subTitle: boxOfficeData.salesAcc,
                ratio: boxOfficeData.rank
            )
            tempData.append(mainData)
            
            if (index + 1) % 8 == 0 || index == boxOfficeResult.dailyBoxOfficeList.count - 1 {
                let mainDataModel = MainDataModel(data: tempData)
                mainDataModels.append(mainDataModel)
                tempData.removeAll()
            }
        }
        
        return mainDataModels
    }
}
