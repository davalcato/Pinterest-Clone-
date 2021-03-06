//
//  MainTabBarController.swift
//  Pinterest
//
//  Created by Daval Cato on 11/13/21.
//

import UIKit
import AppTrackingTransparency

@available(iOS 15.0, *)
class MainTabBarController: UITabBarController, UIScrollViewDelegate, UITabBarControllerDelegate, UITableViewDelegate {
    
//    @available(iOS 13.0, *)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        self.tabBar.tintColor = .red
        
        
//        scrollViewer.delegate = self
        // this code fixes the tabBar color
        let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        tabBar.clipsToBounds = true
        
        // track user button
        let button = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: 200,
            height: 50))
        view.addSubview(button)
        button.center = view.center
        button.tintColor = .blue
//        button.setTitle("Get Permission", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        setupViewController()
    }
    
    // tap button
    @objc func didTapButton() {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .notDetermined:
                break
            case .restricted:
                break
            case .denied:
                print("Denied access")
                break
            case .authorized:
                print("Allowed")
                break
            @unknown default:
                break
            }
        }
        print("Tap button")
    }
    
//    private func createSpinnerFooter() -> UIView {
//        let footerView = UIView(frame: CGRect(
//            x: 0,
//            y: 0,
//            width: view.frame.size.width,
//            height: 100))
//        
//        let spinner = UIActivityIndicatorView()
//        spinner.center = footerView.center
//        footerView.addSubview(spinner)
//        spinner.startAnimating()
//        
//        return footerView
//        
//    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Did scroll")
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













