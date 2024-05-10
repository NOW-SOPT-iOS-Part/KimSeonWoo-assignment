//
//  MainDataModel.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/28/24.
//

import UIKit

struct MainDataModel {
    let data: [MainData]
}

struct MainData {
    let image: UIImage
    var title: String
    var maker: String
    var subTitle: String
    var ratio: String
}

//extension MainDataModel {
//    static func dummy() -> [MainDataModel] {
//        [
//            MainDataModel(data: [
//                MainData(image: .poster1, title: "스트레인지 월드", subTitle: "괴물들의 세상"),
//                MainData(image: .poster2, title: "나일 강의 기적", subTitle: "영화"),
//                MainData(image: .poster1, title: "스트레인지 월드", subTitle: "괴물들의 세상"),
//                MainData(image: .poster2, title: "나일 강의 기적", subTitle: "영화"),
//                MainData(image: .poster3, title: "슬기로운 의사생활", maker: "드라마하우스", subTitle: "시즌 2", ratio: "8.2%"),
//                MainData(image: .poster1, title: "스트레인지 월드", subTitle: "괴물들의 세상"),
//                MainData(image: .poster2, title: "나일 강의 기적", subTitle: "영화"),
//                MainData(image: .poster3, title: "슬기로운 의사생활", maker: "드라마하우스", subTitle: "시즌 2", ratio: "8.2%")
//            ]),
//            MainDataModel(data: [
//                MainData(image: .poster1, title: "더 레전드"),
//                MainData(image: .poster2, title: "이상한 나라의 수학자", maker: "EBS", ratio: "7.5%"),
//                MainData(image: .poster3, title: "안녕? 과학"),
//                MainData(image: .poster2, title: "아는 형님", subTitle: "토크쇼"),
//                MainData(image: .poster2, title: "런닝맨", subTitle: "예능"),
//                MainData(image: .poster1, title: "구르미 그린 달빛", maker: "tvN", ratio: "9.1%"),
//                MainData(image: .poster1, title: "미스터 선샤인", maker: "tvN", ratio: "8.9%"),
//                MainData(image: .poster1, title: "스캐нд얼", maker: "tvN", ratio: "7.8%")
//            ]),
//            MainDataModel(data: [
//                MainData(image: .logo, title: "나 혼자 산다", maker: "MBC", subTitle: "예능", ratio: "8.5%"),
//                MainData(image: .logo, title: "인간시대", maker: "MBC", ratio: "7.2%"),
//                MainData(image: .logo, title: "오! 삼광빌라", maker: "KBS", ratio: "6.8%"),
//                MainData(image: .logo, title: "런닝맨", maker: "SBS", subTitle: "예능", ratio: "5.1%"),
//                MainData(image: .logo, title: "슬기로운 의사생활", maker: "tvN", ratio: "8.2%"),
//                MainData(image: .logo, title: "전지적 참견 시점", maker: "tvN", ratio: "7.9%")
//            ]),
//            MainDataModel(data: [
//                MainData(image: .poster2, title: "인셉션", maker: "크리스토퍼 놀란", subTitle: "액션/SF", ratio: "8.8"),
//                MainData(image: .poster2, title: "다크 나이트", maker: "크리스토퍼 놀란", subTitle: "액션/범죄", ratio: "9.0"),
//                MainData(image: .poster2, title: "인터스텔라", maker: "크리스토퍼 놀란", subTitle: "SF/모험", ratio: "8.6"),
//                MainData(image: .poster2, title: "더 프레식스", maker: "크리스토퍼 놀란", subTitle: "SF/스릴러", ratio: "7.5"),
//                MainData(image: .poster2, title: "덕구", maker: "류승완", subTitle: "코미디", ratio: "7.1"),
//                MainData(image: .poster2, title: "서복", maker: "이용주", subTitle: "드라마", ratio: "8.3"),
//                MainData(image: .poster2, title: "젠틀맨", maker: "가이리치", subTitle: "액션/범죄", ratio: "7.8"),
//                MainData(image: .poster2, title: "굿 펠라스", maker: "마틴 스코세이지", subTitle: "범죄", ratio: "8.7")
//            ]),
//            MainDataModel(data: [
//                MainData(image: .poster2, title: "어벤져스: 엔드게임", maker: "마블", subTitle: "액션/SF", ratio: "8.4"),
//                MainData(image: .poster2, title: "아이언맨", maker: "마블", subTitle: "액션/SF", ratio: "7.9"),
//                MainData(image: .logo, title: "스타트렉", maker: "파라마운트", subTitle: "SF", ratio: "8.1"),
//                MainData(image: .logo, title: "스타트렉: 피어레스", maker: "파라마운트", subTitle: "SF", ratio: "7.7"),
//                MainData(image: .logo, title: "탑건: 매버릭", maker: "파라마운트", subTitle: "액션", ratio: "8.5"),
//                MainData(image: .logo, title: "미션 임파서블", maker: "파라마운트", subTitle: "액션", ratio: "7.8"),
//                MainData(image: .logo, title: "트랜스포머", maker: "파라마운트", subTitle: "SF", ratio: "7.0"),
//                MainData(image: .logo, title: "아바타", maker: "파라마운트", subTitle: "SF", ratio: "7.9")
//            ]),
//            MainDataModel(data: [
//                MainData(image: .poster2, title: "범죄도시2", maker: "이상용", subTitle: "범죄/액션", ratio: "8.5"),
//                MainData(image: .poster2, title: "타짜", maker: "촐력구", subTitle: "범죄", ratio: "7.7"),
//                MainData(image: .poster2, title: "더 킹", maker: "한재림", subTitle: "범죄", ratio: "7.1"),
//                MainData(image: .poster2, title: "극한직업", maker: "이병헌", subTitle: "코미디", ratio: "8.9"),
//                MainData(image: .poster2, title: "신세계", maker: "박훈정", subTitle: "범죄", ratio: "7.8"),
//                MainData(image: .poster2, title: "암살", maker: "최동훈", subTitle: "액션", ratio: "7.6"),
//                MainData(image: .poster2, title: "도둑들", maker: "이원석", subTitle: "범죄", ratio: "7.1"),
//                MainData(image: .logo, title: "남산의 부장들", maker: "데인치화감독", subTitle: "코미디", ratio: "8.0")
//            ])
//        ]
//    }
//}
