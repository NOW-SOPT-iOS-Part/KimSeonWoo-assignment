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

