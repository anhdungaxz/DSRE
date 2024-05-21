//
//  AppDelegate.swift
//  DSRE
//
//  Created by anhdungaxz on 03/29/2024.
//  Copyright (c) 2024 anhdungaxz. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import DSRE

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        DSRE.share.initialize(apiKey: "abc", clientId: "abc")
        let navi = UINavigationController(rootViewController: LoginViewController())
        navi.isNavigationBarHidden = true
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
           handleIncomingURL(url)
           return true
       }
    
    func handleIncomingURL(_ url: URL) {
        print("Đã nhận được URL: \(url)")
        if let host = url.host, host == "loginSSO" {
            if let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems {
                let phone = queryItems.first?.value
                let vc = HomeViewController()
                vc.loginPhone = phone
                let navi = UINavigationController(rootViewController: vc)
                navi.isNavigationBarHidden = true
                window?.rootViewController = navi
            }
        }
        
    }
}

