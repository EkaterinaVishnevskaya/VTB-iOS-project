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
        
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
        
        let item1 = LibraryViewController()
        item1.tabBarItem = UITabBarItem(title: "Library", image: UIImage(named: "Library"), tag: 0)
        
        let item2 = DictionaryNavigationController(rootViewController: DictionaryTableViewController())
        item2.tabBarItem = UITabBarItem(title: "Dictionary", image: UIImage(named: "Dictionary"), tag: 0)
        
        let item3 = ExercisesNavigationController(rootViewController: ExercisesViewController())
        item3.tabBarItem = UITabBarItem(title: "Exercises", image: UIImage(named: "Exercises"), tag: 0)
        
        let item4 = UIViewController()
        item4.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "User"), tag: 0)
        
        self.viewControllers = [item1, item2, item3, item4]
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
}
