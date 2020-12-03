//
//  AppDelegate.swift
//  GIF
//
//  Created by Pawan  on 14/10/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ImageGIFViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

