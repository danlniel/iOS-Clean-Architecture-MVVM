//
//  AppDelegate.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 01.10.18.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appNavigation: AppNavigationInterface = AppNavigation.instance
    let diManager: DIManagerInterface = DIManager()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppAppearance.setupAppearance()
        diManager.register()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appNavigation.createRootNavigationScreen()
        window?.makeKeyAndVisible()
    
        return true
    }
}
