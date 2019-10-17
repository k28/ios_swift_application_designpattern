//
//  AppDelegate.swift
//  GithubClient
//
//  Created by kazuya on 2019/10/13.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            // SenceDelegateで行う
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            AppDelegate.setupWindow(window)
        }
        return true
    }
    
    class func setupWindow(_ window: UIWindow?) {
         window?.backgroundColor = .white
         window?.rootViewController = UINavigationController(rootViewController: TimeLineViewController())
         window?.makeKeyAndVisible()
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

