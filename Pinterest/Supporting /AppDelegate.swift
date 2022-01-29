//
//  AppDelegate.swift
//  Pinterest
//  brettnoper80@gmail.com used for Firebase console




//  Created by Daval Cato on 10/24/21.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FirebaseAuth


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        FBSDKCoreKit.ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        GIDSignIn.sharedInstance()?.clientID = "865210992068-i18lunlsgbvrebc5ijror22hlidpbvcn.apps.googleusercontent.com"
        // know when the user signed in with Google
//        GIDSignIn.sharedInstance()?.delegate = self
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        return true
    }
    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//
//        print("Google Sign In didSignInForUser")
//                  if let error = error {
//                    print(error.localizedDescription)
//                    return
//                  }
//
//                  guard let authentication = user.authentication else { return }
//                  let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
//              // When user is signed in
//                  Auth.auth().signIn(with: credential, completion: { (user, error) in
//                    if let error = error {
//                      print("Login error: \(error.localizedDescription)")
//                      return
//                    }
//                  })
//                }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        ApplicationDelegate.shared.application(
                    app,
                    open: url,
                    sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
//        GIDSignIn.sharedInstance().handle(url,
//                                          sourceApplication: options,
//                                          [UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//                    annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
        return GIDSignIn.sharedInstance().handle(url)

    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

