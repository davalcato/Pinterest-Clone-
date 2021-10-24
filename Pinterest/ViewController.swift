//
//  ViewController.swift
//  Pinterest
//
//  Created by Daval Cato on 10/24/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        // loginBtn here
        let loginBtn = UIButton()
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.setTitle("Log In", for: .normal)
        loginBtn.backgroundColor = UIColor.white
        loginBtn.setTitleColor(UIColor.gray, for: .normal)
        loginBtn.contentEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 0,
            bottom: 13,
            right: 0)
        loginBtn.layer.cornerRadius = 15
        loginBtn.clipsToBounds = true
        
        view.addSubview(loginBtn)
        
        // loginBtn constraits
        loginBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                         constant: 35).isActive = true
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loginBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }


}

