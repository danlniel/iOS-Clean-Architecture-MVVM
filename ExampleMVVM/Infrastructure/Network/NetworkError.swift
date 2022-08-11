//
//  NetworkError.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 27/07/22.
//

import Foundation

enum NetworkError: Error, Equatable {
    case cancelled
    case error(statusCode: Int, data: Data?)
    case notConnected
    case urlGeneration
    case nilData
    case generic(Error)
    case parsing(Error)
    case unknown
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.cancelled, .cancelled):
            return true
        case let (.error(xStatusCode, xData), .error(yStatusCode,yData)):
            return xStatusCode == yStatusCode && xData == yData
        case (.notConnected, .notConnected):
            return true
        case (.urlGeneration, .urlGeneration):
            return true
        case (.nilData, .nilData):
            return true
        case let (.generic(xError), .generic(yError)):
            return xError.localizedDescription == yError.localizedDescription
        case let (.parsing(xError), .parsing(yError)):
            return xError.localizedDescription == yError.localizedDescription
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}

extension NetworkError {
    var isNotFound: Bool { return hasStatusCode(404) }
    
    private func hasStatusCode(_ code: Int) -> Bool {
        switch self {
        case let .error(errCode, _):
            return errCode == code
        default: return false
        }
    }
}
