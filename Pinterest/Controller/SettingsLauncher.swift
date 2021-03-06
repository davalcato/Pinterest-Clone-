//
//  SettingsLauncher.swift
//  Pinterest
//
//  Created by Daval Cato on 5/3/22.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // show menu
    let blackView = UIView()
    
    // Create local viable
    let collectionView: UICollectionView = {
        // layout
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
        
    }()
    // create cellId
    let cellId = "cellId"
    
    func showSettings() {
        if let window = UIApplication.shared.windows.first {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            // dismiss blackview
            blackView.addGestureRecognizer(UITapGestureRecognizer(
                target: self,
                action: #selector(handleDismiss)))
            
            // Add has a subview to viewController view
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            // change location of popup to bottom
            let height: CGFloat = 500
            let y = window.frame.height - height
            // frame of collectioView
            collectionView.frame = CGRect(
                x: 0,
                y: window.frame.height,
                width: window.frame.width,
                height: height)
            
            
            blackView.frame = window.frame
            // this calls blackview to screen
            blackView.alpha = 0
            
            // change duration of animation
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut,
                animations: {
                
                self.blackView.alpha = 1
                // setting the new frame of collectionView to animate
                self.collectionView.frame = CGRect(
                    x: 0,
                    y: y,
                    width: self.collectionView.frame.width,
                    height: self.collectionView.frame.height)
            },
                completion: nil)
            print("Button tapped")
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(
            withDuration: 0.5) {
            self.blackView.alpha = 0
            // this dismisses the collectionView back to the bottom
            if let window = UIApplication.shared.windows.first {
                self.collectionView.frame = CGRect(
                    x: 0,
                    y: window.frame.height,
                    width: self.collectionView.frame.width,
                    height: self.collectionView.frame.height)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    // extend the cells along the horizon axis
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    override init() {
        super.init()
                collectionView.dataSource = self
                collectionView.delegate = self
        // register cell here
                collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}
