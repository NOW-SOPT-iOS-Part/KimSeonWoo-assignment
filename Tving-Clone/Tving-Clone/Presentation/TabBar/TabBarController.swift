//
//  TabBarController.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/29/24.
//

import UIKit
import SnapKit

final class TabBarController: UITabBarController {

    private var mainContentViewModel: MainContentViewModel
    
    init(mainContentViewModel: MainContentViewModel) {
        self.mainContentViewModel = mainContentViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItem()
        setStyle()
    }
    
    private func setStyle() {
        tabBar.backgroundColor = .gray5
        tabBar.tintColor = .red
        tabBar.barTintColor = .gray5
    }
    
    private func setTabBarItem() {
        var tabBarViewControllers: [UIViewController] = []
        
        for item in TabBarItem.allCases {
            let viewController = item.changedViewController(mainContentViewModel: mainContentViewModel)
            viewController.tabBarItem = UITabBarItem(title: item.title, image: item.image, selectedImage: item.selectedImage)
            tabBarViewControllers.append(viewController)
        }
        
        self.viewControllers = tabBarViewControllers
    }
}
