//
//  AppNavigation.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 03.03.19.
//

import UIKit

protocol AppNavigationInterface {
    func createRootNavigationScreen() -> UINavigationController
    func currentScreen() -> UIViewController?
}

final class AppNavigation: AppNavigationInterface {
    static let instance: AppNavigationInterface = AppNavigation()
    
    private var navigationController: UINavigationController?

    func createRootNavigationScreen() -> UINavigationController {
        // Can handle login flow from here
        let mainScreen: MoviesListViewController = .create()
        navigationController = UINavigationController(rootViewController: mainScreen)
        return navigationController!
    }
    
    func currentScreen() -> UIViewController? {
        var currentScreen: UIViewController? = navigationController
        while let newCurrentScreen = navigationController?.presentedViewController {
            currentScreen = newCurrentScreen
        }
        return currentScreen
    }
}
