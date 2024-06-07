//
//  TabBarItem.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/29/24.
//

import UIKit

enum TabBarItem: CaseIterable {
    case home, soon, search, timeline
}

extension TabBarItem {
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .soon:
            return "공계예정"
        case .search:
            return "검색"
        case .timeline:
            return "기록"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .soon:
            return UIImage(systemName: "video")
        case .search:
            return UIImage(systemName: "magnifyingglass")
        case .timeline:
            return UIImage(systemName: "book")
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")
        case .soon:
            return UIImage(systemName: "video.fill")
        case .search:
            return UIImage(systemName: "magnifyingglass.fill")
        case .timeline:
            return UIImage(systemName: "book.fill")
        }
    }
    
    func changedViewController(mainContentViewModel: MainContentViewModel) -> UIViewController {
        switch self {
        case .home:
            return MainViewController(mainContentViewModel: mainContentViewModel)
        case .soon, .search, .timeline:
            return LoginViewController() 
        }
    }
}
