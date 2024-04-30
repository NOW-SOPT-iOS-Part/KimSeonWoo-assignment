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
    var title: String? = ""
    var maker: String? = ""
    var subTitle: String? = ""
    var ratio: String? = ""
}

extension MainDataModel {
    static func dummy() -> [MainDataModel] {
        [
            MainDataModel(data: [
                MainData(image: .poster1),
                MainData(image: .poster2),
                MainData(image: .poster3),
            ]),
            MainDataModel(data: [
                MainData(image: .poster1, title: "ddddddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster3, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster1, title: "dddd"),
                MainData(image: .poster1, title: "dddd"),
                MainData(image: .poster1, title: "dddd"),
            ]),
            MainDataModel(data: [
                MainData(image: .logo, title: "dddd", maker: "dddd", subTitle: "dddd", ratio: "dddd"),
                MainData(image: .logo, title: "dddd", maker: "dddd", subTitle: "dddd", ratio: "dddd"),
                MainData(image: .logo, title: "dddd", maker: "dddd", subTitle: "dddd", ratio: "dddd"),
                MainData(image: .logo, title: "dddd", maker: "dddd", subTitle: "dddd", ratio: "dddd"),
                MainData(image: .logo, title: "dddd", maker: "dddd", subTitle: "dddd", ratio: "dddd"),
                MainData(image: .logo, title: "dddd", maker: "dddd", subTitle: "dddd", ratio: "dddd"),
            ]),
            MainDataModel(data: [
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
            ]),
            MainDataModel(data: [
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .logo, title: "dddd"),
                MainData(image: .logo, title: "dddd"),
                MainData(image: .logo, title: "dddd"),
                MainData(image: .logo, title: "dddd"),
                MainData(image: .logo, title: "dddd"),
                MainData(image: .logo, title: "dddd"),
            ]),
            MainDataModel(data: [
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .poster2, title: "dddd"),
                MainData(image: .logo, title: "dddd"),
            ])
        ]
    }
}
