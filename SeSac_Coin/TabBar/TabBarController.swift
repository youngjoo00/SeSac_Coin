//
//  TabBarController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstTab = UINavigationController(rootViewController: TrendViewController())
        let firstTabBarItem = UITabBarItem(title: nil, image: UIImage(resource: .tabTrendInactive), tag: 0)
        firstTab.tabBarItem = firstTabBarItem
        
        let secondTab = UINavigationController(rootViewController: SearchViewController())
        let secondTabBarItem = UITabBarItem(title: nil, image: UIImage(resource: .tabSearchInactive), tag: 1)
        secondTab.tabBarItem = secondTabBarItem
        
        let thirdTab = UINavigationController(rootViewController: FavoriteViewController())
        let thirdTabBarItem = UITabBarItem(title: nil, image: UIImage(resource: .tabPortfolioInactive), tag: 2)
        thirdTab.tabBarItem = thirdTabBarItem
        
        let forthTab = UINavigationController(rootViewController: SettingViewController())
        let forthTabBarItem = UITabBarItem(title: nil, image: UIImage(resource: .tabUserInactive), tag: 3)
        forthTab.tabBarItem = forthTabBarItem
        
        self.viewControllers = [firstTab, secondTab, thirdTab, forthTab]
    }

}
