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
        // this code fixes the tabBar color
        let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
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
            feedNavController,
            generateNavControllers(title: "Notifications", image: UIImage(named: "notifications-tab")!),
            generateNavControllers(title: "Saved", image: UIImage(named: "profile-tab")!)
        
        ]
    }
    // generate fake navigation controllers
    func generateNavControllers(title: String, image: UIImage) -> UINavigationController {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        // created the navController
        let navController = UINavigationController(rootViewController: vc)
        // setup attributes
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.gray
        
        ], for: .selected)
        return navController
        
    }
    
}





