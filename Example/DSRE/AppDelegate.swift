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
import CleverTapSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    var loginPhone: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        CleverTap.setDebugLevel(2)
        IQKeyboardManager.shared.enable = true
        DSRE.share.initialize(apiKey: "abc", clientId: "abc")
        let navi = UINavigationController(rootViewController: LoginViewController())
        navi.isNavigationBarHidden = true
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        application.registerForRemoteNotifications()
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
           handleIncomingURL(url)
           return true
       }
    
    func handleIncomingURL(_ url: URL) {
        print("Đã nhận được URL: \(url)")
        if let host = url.host, host == "loginSSO" {
            if (loginPhone ?? "").isEmpty {
                let vc = LoginViewController()
                vc.isLoginChild = true
                let navi = UINavigationController(rootViewController: vc)
                navi.isNavigationBarHidden = true
                window?.rootViewController = navi
                window?.makeKeyAndVisible()
            } else {
                if let navi = window?.rootViewController as? UINavigationController {
                    if let homeViewController = navi.viewControllers.first(where: { $0 is HomeViewController }) as? HomeViewController {
                                    // Đã tìm thấy HomeViewController
                        homeViewController.alertLoginChild()
                                }
                }
            }
        }
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        print("APNS Token: " + deviceTokenString)
        CleverTap.sharedInstance()?.setPushToken(deviceToken)
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: notification.request.content.userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.userInfo)
        CleverTap.sharedInstance()?.handleNotification(withData: response.notification.request.content.userInfo)
        completionHandler()
        
    }


}

