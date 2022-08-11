//
//  AppConfiguration.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 25.02.19.
//

import Foundation

protocol ApiConfiguratorInterface {
    func activeEnvironment() -> ApiConfigInterface
}

final class ApiConfigurator: ApiConfiguratorInterface {
    private var environment: Environment = .production
    
    private lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    private var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
    private lazy var imagesBaseURL: String = {
        guard let imageBaseURL = Bundle.main.object(forInfoDictionaryKey: "ImageBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return imageBaseURL
    }()
    
    func activeEnvironment() -> ApiConfigInterface {
        switch environment {
        case .production:
            return ApiConfig(
                baseUrl: URL(string: apiBaseURL)!,
                queryParameters: ["api_key": apiKey,
                                  "language": NSLocale.preferredLanguages.first ?? "en"]
            )
        }
    }
}

extension ApiConfigurator {
    private enum Environment {
        case production
    }
}
