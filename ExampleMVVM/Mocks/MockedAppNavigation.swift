//
//  MockedAppNavigation.swift
//  ExampleMVVMTests
//
//  Created by Daniel Sunarjo on 08/08/22.
//

import UIKit
@testable import ExampleMVVM

final class MockedAppNavigation: AppNavigationInterface {
    var mockCreateRootNavigationScreenResult: UINavigationController = .init()
    func createRootNavigationScreen() -> UINavigationController {
        mockCreateRootNavigationScreenResult
    }
    
    var mockCurrentScreenResult: UIViewController?
    func currentScreen() -> UIViewController? {
        mockCurrentScreenResult
    }
}
