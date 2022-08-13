//
//  AppDelegate.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 6.08.2022.
//

import UIKit
import SideMenu
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemMint
            appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MarkerFelt-Thin", size: 22)!,
                                              NSAttributedString.Key.foregroundColor: UIColor.white]
            
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().layer.shadowOpacity = 1
            
        }
        UINavigationBar.appearance().backItem?.backBarButtonItem?.tintColor = .green
        UILabel.appearance().font = UIFont(name: "MarkerFelt-Thin", size: 16)



        return true
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

