//
//  PinterestCell.swift
//  Pinterest
//
//  Created by Daval Cato on 12/18/21.
//

import UIKit

class PinterestCell: UICollectionViewCell {
    
    weak var navigationController: UINavigationController?
    
    // declare here
    let mainImgView: UIImageView = {
        let iv = UIImageView()
        // setup properties
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    // more button
    lazy var moreImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "more")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.lightGray
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moreImgViewAction)))
      
        return iv
    }()
    // not executing this code everytime a class is instantiated
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.pinterestCell = self
        return launcher
    }()
    
    @objc func moreImgViewAction() {
        //show menu
        settingsLauncher.showSettings()
        
    }
    class MenuViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .systemRed
            title = "Welcome"
        }
    }
    // view controller
    func showControllerForSetting(setting: Setting) {
//        menuViewController?.navigationItem.title = setting.name
        // push a viewController onto the stack
        let navigationController = UINavigationController()
        let menuViewController = UINavigationController(rootViewController: MenuViewController())
        navigationController.navigationItem.title = setting.name
        navigationController.navigationBar.tintColor = UIColor.white
        window?.rootViewController = navigationController
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add constraints
        backgroundColor = .clear
        
        addSubview(mainImgView)
        addSubview(moreImgView)
        
        mainImgView.constraint(
            top: topAnchor,
            left: leftAnchor,
            bottom: moreImgView.topAnchor,
            right: rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0)
        
        moreImgView.constraint(
            top: nil,
            left: nil,
            bottom: bottomAnchor,
            right: rightAnchor,
            topConstant: 10,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 15,
            heightConstant: 15)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UINavigationController {
    var rootViewController : UIViewController? {
        return self.viewControllers.first
    }
}








