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


@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )

        
        
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance()?.clientID = "865210992068-i18lunlsgbvrebc5ijror22hlidpbvcn.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // once user is signed in print out email
        print("User email: \(user.profile?.email ?? "No Email")")
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        ApplicationDelegate.shared.application(
                    app,
                    open: url,
                    sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
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

