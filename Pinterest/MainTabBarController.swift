//
//  MainTabBarController.swift
//  Pinterest
//
//  Created by Daval Cato on 11/13/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = UIColor.gray
        
        tabBar.barTintColor = UIColor.white
        tabBar.clipsToBounds = true
    }
}




