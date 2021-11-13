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
        
        setupViewController()
    }
    
    func setupViewController() {
        // for each the controller displayed
        let feedNavController = UINavigationController(rootViewController: FeedViewController())
        feedNavController.tabBarItem.title = "Home"
        feedNavController.tabBarItem.image = UIImage(named: "logo-unselected-tab")
        
        // so withRenderingMode doesn't overlay a color on the image
        feedNavController.tabBarItem.selectedImage = UIImage(named: "logo-tab")?.withRenderingMode(.alwaysOriginal)
        // title color
        feedNavController.tabBarItem.setTitleTextAttributes([
            // set the ns string
            NSAttributedString.Key.foregroundColor: UIColor.gray
        // when select title color is gray
        ], for: .selected)
        // setup viewcontrollers
        viewControllers = [
            feedNavController
        
        ]
    }
}



