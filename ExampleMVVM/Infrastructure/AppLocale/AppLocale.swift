//
//  AppLocale.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 02/08/22.
//

import Foundation

protocol AppLocaleInterface {
    func getString(key: String) -> String
}

final class AppLocale: AppLocaleInterface {
    func getString(key: String) -> String {
        NSLocalizedString(key, comment: "")
    }
}
