//
//  ViewController.swift
//  Pinterest
//
//  Created by Daval Cato on 10/24/21.
//

import UIKit

class ViewController: UIViewController {
    
    let loginBtn: UIButton = {
        // loginBtn here
        let loginBtn = UIButton()
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.setTitle("Log In", for: .normal)
        loginBtn.backgroundColor = UIColor.lightGray
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.contentEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 0,
            bottom: 13,
            right: 0)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                      weight: .bold)
        loginBtn.layer.cornerRadius = 15
        loginBtn.clipsToBounds = true
        
        return loginBtn
    }()
    
    let emailBtn: UIButton = {
        // loginBtn here
        let emailBtn = UIButton()
        emailBtn.translatesAutoresizingMaskIntoConstraints = false
        emailBtn.setTitle("Log In", for: .normal)
        emailBtn.backgroundColor = UIColor.lightGray
        emailBtn.setTitleColor(UIColor.white, for: .normal)
        emailBtn.contentEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 0,
            bottom: 13,
            right: 0)
        emailBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                      weight: .bold)
        emailBtn.layer.cornerRadius = 15
        emailBtn.clipsToBounds = true
        
        return emailBtn
    }()
    
    let facebookBtn: UIButton = {
        // loginBtn here
        let facebookBtn = UIButton()
        facebookBtn.translatesAutoresizingMaskIntoConstraints = false
        facebookBtn.setTitle("Log In", for: .normal)
        facebookBtn.backgroundColor = UIColor.lightGray
        facebookBtn.setTitleColor(UIColor.white, for: .normal)
        facebookBtn.contentEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 0,
            bottom: 13,
            right: 0)
        facebookBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                      weight: .bold)
        facebookBtn.layer.cornerRadius = 15
        facebookBtn.clipsToBounds = true
        
        return facebookBtn
    }()
    
    let googleBtn: UIButton = {
        // loginBtn here
        let googleBtn = UIButton()
        googleBtn.translatesAutoresizingMaskIntoConstraints = false
        googleBtn.setTitle("Log In", for: .normal)
        googleBtn.backgroundColor = UIColor.lightGray
        googleBtn.setTitleColor(UIColor.white, for: .normal)
        googleBtn.contentEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 0,
            bottom: 13,
            right: 0)
        googleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                      weight: .bold)
        googleBtn.layer.cornerRadius = 15
        googleBtn.clipsToBounds = true
        
        return googleBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        

        setupElements()
    }
    
    func setupElements() {
        view.addSubview(loginBtn)
        // loginBtn constraits
        loginBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                         constant: -35).isActive = true
        loginBtn.leftAnchor.constraint(equalTo: view.leftAnchor,
                                       constant: 20).isActive = true
        loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor,
                                       constant: -20).isActive = true
        
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
    }


}

