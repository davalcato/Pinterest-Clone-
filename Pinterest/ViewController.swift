//
//  ViewController.swift
//  Pinterest
//
//  Created by Daval Cato on 10/24/21.
//

import UIKit

class ViewController: UIViewController {
    
    let logoImgView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "logo"))
        
        return iv
        
    }()
    
    let welcomeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome to Pinterest"
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        lbl.textColor = UIColor.gray
        lbl.textAlignment = .center
        
        return lbl
    }()
    
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
        emailBtn.setTitle("Continue with email", for: .normal)
        emailBtn.backgroundColor = UIColor.red
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
        facebookBtn.setTitle("Continue with Facebook", for: .normal)
        facebookBtn.backgroundColor = UIColor.blue
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
        googleBtn.setTitle("Continue with Google", for: .normal)
        googleBtn.backgroundColor = UIColor.green
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
    
    // Add the buttons to a stack view
    lazy var btnStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.distribution = .fillEqually
        s.alignment = .fill
        s.spacing = 9
        s.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        s.addArrangedSubview(emailBtn)
        s.addArrangedSubview(facebookBtn)
        s.addArrangedSubview(googleBtn)
        
        return s
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white

        setupElements()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        btnStackView.heightAnchor.constraint(equalToConstant: (loginBtn.frame.height * 3) + 10).isActive = true
    }
    
    func setupElements() {
        view.addSubview(loginBtn)
        view.addSubview(btnStackView)
        view.addSubview(welcomeLbl)
        view.addSubview(logoImgView)
        
        
        // loginBtn constraits
        loginBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                         constant: -35).isActive = true
        loginBtn.leftAnchor.constraint(equalTo: view.leftAnchor,
                                       constant: 20).isActive = true
        loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor,
                                       constant: -20).isActive = true
        
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        btnStackView.constraint(
            top: nil,
            left: view.leftAnchor,
            bottom: loginBtn.topAnchor,
            right: view.rightAnchor,
            topConstant: 0,
            leftConstant: 20,
            bottomConstant: 30,
            rightConstant: 20,
            widthConstant: 0,
            heightConstant: 0)
        
        welcomeLbl.constraint(
            top: nil,
            left: view.leftAnchor,
            bottom: btnStackView.topAnchor,
            right: view.rightAnchor,
            topConstant: 0,
            leftConstant: 20,
            bottomConstant: 30,
            rightConstant: 20,
            widthConstant: 0,
            heightConstant: 0)
        
        logoImgView.constraint(
            top: nil,
            left: nil,
            bottom: welcomeLbl.topAnchor,
            right: nil,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 10,
            rightConstant: 0,
            widthConstant: 140,
            heightConstant: 140)
        logoImgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
}

extension UIView {
    // table func
    func constraint(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat? = 0, leftConstant: CGFloat? = 0, bottomConstant: CGFloat? = 0, rightConstant: CGFloat? = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        if let top = top {
            constraints.append(topAnchor.constraint(equalTo: top,
                                                    constant: topConstant!))
        }
        if let left = left {
            constraints.append(leftAnchor.constraint(equalTo: left,
                                                    constant: leftConstant!))
        }
        if let bottom = bottom {
            constraints.append(bottomAnchor.constraint(equalTo: bottom,
                                                    constant: -bottomConstant!))
        }
        if let right = right {
            constraints.append(rightAnchor.constraint(equalTo: right,
                                                    constant: -rightConstant!))
        }
        if widthConstant > 0 {
            constraints.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        if heightConstant > 0 {
            constraints.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        constraints.forEach({$0.isActive = true})
    }
}

