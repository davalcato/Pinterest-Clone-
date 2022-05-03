//
//  SettingsLauncher.swift
//  Pinterest
//
//  Created by Daval Cato on 5/3/22.
//

import UIKit

class SettingsLauncher: NSObject {
    // show menu
    let blackView = UIView()
    
     func showSettings() {
        if let window = UIApplication.shared.windows.first {
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        // dismiss blackview
        blackView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(handleDismiss)))
        
            // Add has a subview to viewController view
            window.addSubview(blackView)
            blackView.frame = window.frame
        // this calls blackview to screen
        blackView.alpha = 0
        // animate the black view onto screen
        UIView.animate(
            withDuration: 0.5) {
            self.blackView.alpha = 1
            }
            print("Button tapped")
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(
            withDuration: 0.5) {
            self.blackView.alpha = 0
        }
    }
    override init() {
        super.init()
        
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}
