//
//  TabBarViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 31.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        tabBar.barTintColor = UIColor.gray
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.black
        
        let item1 = LibraryViewController()
        item1.tabBarItem = UITabBarItem(title: "Library", image: UIImage(named: "Library"), tag: 0)
        
        let item2 = DictionaryViewController()
        item2.tabBarItem = UITabBarItem(title: "Dictionary", image: UIImage(named: "Dictionary"), tag: 0)
        
        self.viewControllers = [item1, item2]
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
}
