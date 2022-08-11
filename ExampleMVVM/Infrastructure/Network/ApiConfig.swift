//
//  ServiceConfig.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 01.10.18.
//

import Foundation

protocol ApiConfigInterface {
    var baseUrl: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

struct ApiConfig: ApiConfigInterface {
    let baseUrl: URL
    let headers: [String: String]
    let queryParameters: [String: String]
    
    init(baseUrl: URL,
         headers: [String: String] = [:],
         queryParameters: [String: String] = [:]) {
        self.baseUrl = baseUrl
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
