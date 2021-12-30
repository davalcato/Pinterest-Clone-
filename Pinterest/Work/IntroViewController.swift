//
//  IntroViewController.swift
//  Pinterest
//
//  Created by Daval Cato on 10/24/21.
//

import UIKit
import SwiftGifOrigin
import GoogleSignIn

class GradientLayer: CAGradientLayer {
    var gradient: (start: CGPoint, end: CGPoint)? {
        didSet {
            startPoint = gradient?.start ?? CGPoint.zero
            endPoint = gradient?.end ?? CGPoint.zero
        }
    }
}

class GradientView: UIView {
    override public class var layerClass: Swift.AnyClass {
        return GradientLayer.self
    }
}

protocol GradientProvider {
    associatedtype GradientViewType
}

extension GradientProvider where Self: UIView {
    var gradientLayer: Self.GradientViewType {
        return layer as! Self.GradientViewType
    }
    
}

extension UIView: GradientProvider {
    typealias GradientViewType = GradientLayer
    
}

class IntroViewController: UIViewController, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    
    let gradientView: GradientView = {
        let v = GradientView()
        v.gradientLayer.gradient = (start: CGPoint(x: 0.5, y: 1), end: CGPoint(x: 0.5, y: 0))
        // Set the colors
        v.gradientLayer.colors = [UIColor(white: 1, alpha: 1).cgColor, UIColor(white: 1, alpha: 0)]
        
        return v
    }()
    
    let headerImgView: UIImageView = {
        let iv = UIImageView(image: UIImage.gifImageWithName("giphy.gif"))

        return iv

    }()
    
    let logoImgView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "logo"))
        iv.layer.zPosition = 1
        
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
        //  when tapped takes the user to MainTabBarController
        loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        
        
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
        emailBtn.addTarget(self, action: #selector(emailBtnAction), for: .touchUpInside)
        
        return emailBtn
    }()
    
    @objc func emailBtnAction(sender: UIButton!) {
        
        print("Button tapped")
    }
    
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
        facebookBtn.addTarget(self, action: #selector(facebookBtnAction), for: .touchUpInside)
        
        return facebookBtn
    }()
    
    @objc func facebookBtnAction(sender: UIButton!) {
        
        print("Button tapped")
    }
    
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
        googleBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        
        return googleBtn
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
        
      print("Button tapped")
    }
    
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
        // telling the instance that is the prompt to sign in
        GIDSignIn.sharedInstance().presentingViewController = self
        
        view.backgroundColor = .white

        setupElements()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        btnStackView.heightAnchor.constraint(equalToConstant: (loginBtn.frame.height * 3) + 10).isActive = true
    }
    
    @objc func loginBtnTapped() {
        present(MainTabBarController(), animated: false, completion: nil)
        
    }
    
    func setupElements() {
        view.addSubview(loginBtn)
        view.addSubview(btnStackView)
        view.addSubview(welcomeLbl)
        view.addSubview(logoImgView)
        
        headerImgView.addSubview(gradientView)
        view.addSubview(headerImgView)
        
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
        
        headerImgView.constraint(
            top: nil,
            left: view.leftAnchor,
            bottom: welcomeLbl.topAnchor,
            right: view.rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0)

        gradientView.constraint(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: headerImgView.bottomAnchor,
            right: view.rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0)
        
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




