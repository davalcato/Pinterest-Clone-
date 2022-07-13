//
//  SettingsLauncher.swift
//  Pinterest
//
//  Created by Daval Cato on 5/3/22.
//

import UIKit

// matching the setting icons with the labels
class Setting: NSObject {
    // create variables
    let name: String
    let imageName: String
    // initialize the property names
    init(name: String, imageName: String) {
        // name we pass in
        self.name = name
        // imagename that is passed in
        self.imageName = imageName
    }
}
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
    // construct and array of cell rolls
    let cellId = "cellId"
    // create viable
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        return [Setting(name: "Settings", imageName: "settings"), Setting(name: "Terms & privacy policy", imageName: "privacy"), Setting(name: "Send Feedback", imageName: "feedback"), Setting(name: "Help", imageName: "help"), Setting(name: "Switch Account", imageName: "switch"), Setting(name: "Cancel", imageName: "cancel")]
    }()
    
    // dismiss menu
    var pinterestCell: PinterestCell?
    
    func showSettings() {
        // presents entire menu
        if let window = UIApplication.shared.windows.first {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            // dismiss blackview
            blackView.addGestureRecognizer(UITapGestureRecognizer(
                target: self,
                action: #selector(handleDismiss)))
            
            // Add has a subview to viewController view
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            // hard coded height turned dynamic by rolls height
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            // frame of collectioView
            collectionView.frame = CGRect(
                x: 0,
                y: window.frame.height,
                width: window.frame.width,
                height: height)
            // stop settings cell from scrolling 
            collectionView.isScrollEnabled = false
            
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
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // down cast setting
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        // tell the cell what the images need to be
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    // extend the cells along the horizon axis
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // roll height
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    // fix settings image icon spacing gap
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // tap to transition from cell collection to different page
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // get the settings
//        let setting = settings[indexPath.item]
//        print(setting.name)
        
        // animate with duration
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut) {
            
            self.blackView.alpha = 0
            // this dismisses the collectionView back to the bottom
            if let window = UIApplication.shared.windows.first {
                self.collectionView.frame = CGRect(
                    x: 0,
                    y: window.frame.height,
                    width: self.collectionView.frame.width,
                    height: self.collectionView.frame.height)
            }
            
        } completion: { Bool in
            // pass the setting variable to showControllerForSetting
            let setting = self.settings[indexPath.item]
            if setting.name != "Cancel" {
//                // presents the new viewController on dismissal
            self.pinterestCell?.showControllerForSetting(setting: setting)
//
            }
        }
    }
    
    override init() {
        super.init()
                collectionView.dataSource = self
                collectionView.delegate = self
        // register cell here
                collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}
