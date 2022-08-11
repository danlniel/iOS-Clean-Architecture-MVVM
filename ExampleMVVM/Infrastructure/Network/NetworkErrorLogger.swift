//
//  NetworkErrorLogger.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 27/07/22.
//

import Foundation

protocol NetworkErrorLoggerInterface {
    func log(request: URLRequest)
    func log(responseData data: Data?)
    func log(error: Error)
}

final class NetworkErrorLogger: NetworkErrorLoggerInterface {
    func log(request: URLRequest) {
        print("------------------------------")
        print("request: \(request.url!)")
        print("headers: \(request.allHTTPHeaderFields!)")
        print("method: \(request.httpMethod!)")
        if let httpBody: Data = request.httpBody,
           let result: Any = try? JSONSerialization.jsonObject(with: httpBody, options: []),
           let resultDict = result as? [String: AnyObject] {
            printForDebug("body: \(resultDict.description)")
        } else if let httpBody: Data = request.httpBody,
                  let resultString: String = .init(data: httpBody, encoding: .utf8) {
            printForDebug("body: \(resultString)")
        }
        print("------------------------------")
    }

    func log(responseData data: Data?) {
        guard let _data: Data = data,
              let dataDict = try? JSONSerialization.jsonObject(with: _data) as? [String: Any]
        else { return }
        printForDebug("responseData: \(dataDict.description)")
    }

    func log(error: Error) {
        printForDebug("responseError: \(error)")
    }
    
    private func printForDebug(_ string: String) {
        #if DEBUG
        print(string)
        #endif
    }
}
