//
//  IntroViewController.swift
//  Pinterest
//
//  Created by Daval Cato on 10/24/21.
//

import UIKit
import Firebase
import SwiftGifOrigin
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth

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

class IntroViewController: UIViewController, GIDSignInDelegate, LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if error != nil {
            print(error as Any)
            return
            
        }
        
        showEmailAddress()

    }
    
    func showEmailAddress() {
        // access token
        let accessToken = AccessToken.current
        // safer method
        guard (accessToken?.tokenString) != nil else { return }
        
        // auth credentials
        let credentials = FacebookAuthProvider.credential(withAccessToken: (accessToken?.tokenString)!)
        
        // log into firebase here with user
        Auth.auth().signIn(with: credentials) { User, Error in
            if Error != nil {
                print("Something went wrong with our FB user: ", Error as Any)
                return
                
            }
            
            print("Successfully logged in with our user: ", User as Any)
        }
        
        GraphRequest(graphPath: "me", parameters: ["fields": "email, first_name, last_name, gender, picture"]).start { connection, Result, Error in
            if Error != nil {
                print("Failed to start graph request:", Error as Any)
                
            }
            
            print(Result as Any)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("User Logged Out")
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        print("Google Sign In didSignInForUser")
                  if let error = error {
                    print(error.localizedDescription)
                    return
                  }

                  guard let authentication = user.authentication else { return }
                  let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
              // When user is signed in
                  Auth.auth().signIn(with: credential, completion: { (user, error) in
                      let MainTabBarController = MainTabBarController()
                      self.present(MainTabBarController, animated: true, completion: nil)
                      
                  })
                }
    
    
    let gradientView: GradientView = {
        let v = GradientView()
        v.gradientLayer.gradient = (start: CGPoint(x: 0.5, y: 1), end: CGPoint(x: 0.5, y: 0))
        // Set the colors
        v.gradientLayer.colors = [UIColor(white: 1, alpha: 1).cgColor, UIColor(white: 1, alpha: 0)]
        
        return v
    }()
    
    let headerImgView: UIImageView = {
        let iv = UIImageView(image: UIImage.gifImageWithName("giphy"))

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
    
    let appleBtn: UIButton = {
        // loginBtn here
        let appleBtn = UIButton(type: .system)
        appleBtn.translatesAutoresizingMaskIntoConstraints = false
        appleBtn.setTitle("Continue with Apple", for: .normal)
        appleBtn.backgroundColor = UIColor.black
        appleBtn.setTitleColor(UIColor.white, for: .normal)
        appleBtn.contentEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 0,
            bottom: 13,
            right: 0)
        appleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                      weight: .bold)
        appleBtn.layer.cornerRadius = 15
        appleBtn.clipsToBounds = true
        appleBtn.addTarget(self, action: #selector(appleBtnAction), for: .touchUpInside)
        
        return appleBtn
    }()
    
    @objc func appleBtnAction(sender: UIButton!) {
        
        print("Button tapped")
    }
    
    let facebookBtn: UIButton = {
        // Creates facebook button and type downsize on button
        let facebookBtn = UIButton(type: .system)
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
        facebookBtn.setImage(UIImage(named: "logo-tab"), for: .normal)
        facebookBtn.imageView?.contentMode = .scaleAspectFit
        facebookBtn.tintColor = .red
        facebookBtn.imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -20,
            bottom: 0,
            right: 0)
        
        
        
        facebookBtn.addTarget(self, action: #selector(getFacebookUserInfo), for: .touchUpInside)
        
        return facebookBtn
    }()
    
    @objc func getFacebookUserInfo() {
        
        LoginManager().logIn(permissions: ["public_profile", "email"], from: self) { Result, Error in
            
            if Error != nil {
                print(" Custom Facebook Login failed:", Error!)
                return
                
            }
            
            self.showEmailAddress()
            
        }
        
        
        // check if user is signed in
//        if let token = AccessToken.current,
//                !token.isExpired {
//
//            let token = token.tokenString
//
//            // create request
//            let request = FBSDKLoginKit.GraphRequest(
//                graphPath: "/me",
//                parameters: ["fields": "email, name"],
//                tokenString: token,
//                version: nil,
//                httpMethod: .get)
//
//            // start request
//            request.start(completionHandler: {connection, result, error in
//                print("\(result)")
//            })
//
//                // User is logged in, do work such as go to next view controller.
//        }
//        else {
//
//            let loginButton = FBLoginButton()
//            self.loginButtonDidLogOut(loginButton)
//            loginButton.center = view.center
//            loginButton.delegate = self
//            // get permissions
//            loginButton.permissions = ["public_profile", "email"]
//
//            view.addSubview(loginButton)
//        }
        
        print("Button tapped")
    }
    
    let googleBtn: UIButton = {
        // loginBtn here and type downsize on button
        let googleBtn = UIButton(type: .system)
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
        
        googleBtn.setImage(UIImage(named: "logo-tab"), for: .normal)
        googleBtn.imageView?.contentMode = .scaleAspectFit
        googleBtn.tintColor = .red
        googleBtn.imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -35,
            bottom: 0,
            right: 0)
        
        
        googleBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        
        return googleBtn
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
        
//        present(MainTabBarController(), animated: false, completion: nil)
    }
    
    // Add the buttons to a stack view
    lazy var btnStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.distribution = .fillEqually
        s.alignment = .fill
        s.spacing = 9
        s.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        s.addArrangedSubview(appleBtn)
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






