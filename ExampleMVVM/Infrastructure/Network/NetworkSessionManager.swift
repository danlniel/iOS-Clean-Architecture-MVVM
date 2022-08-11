//
//  NetworkSessionManager.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 26/07/22.
//

import Foundation

// MARK: - Network Session Manager
// Note: If authorization is needed NetworkSessionManager can be implemented by using,
// for example, Alamofire SessionManager with its RequestAdapter and RequestRetrier.
// And it can be injected into NetworkService instead of default one.

protocol NetworkSessionManagerInterface {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask
}

final class NetworkSessionManager: NetworkSessionManagerInterface {
    func request(
        _ request: URLRequest,
        completion: @escaping CompletionHandler
    ) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
