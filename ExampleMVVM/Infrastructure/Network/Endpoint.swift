//
//  Endpoint.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 01.10.18.
//

import Foundation

enum HTTPMethodType: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum BodyEncoding {
    case jsonSerializationData
    case stringEncodingAscii
}

enum RequestGenerationError: Error {
    case urlComponents
}

protocol Requestable {
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HTTPMethodType { get }
    var headerParameters: [String: String] { get }
    var queryParametersEncodable: Encodable? { get }
    var bodyParametersEncodable: Encodable? { get }
    var bodyEncoding: BodyEncoding { get }
    var responseDecoder: ResponseDecoder { get }
    
    func urlRequest(with apiConfig: ApiConfigInterface) throws -> URLRequest
}

final class Endpoint: Requestable {
    let path: String
    let isFullPath: Bool
    let method: HTTPMethodType
    let headerParameters: [String: String]
    let queryParametersEncodable: Encodable?
    let bodyParametersEncodable: Encodable?
    let bodyEncoding: BodyEncoding
    let responseDecoder: ResponseDecoder
    
    init(path: String,
         isFullPath: Bool = false,
         method: HTTPMethodType,
         headerParameters: [String: String] = [:],
         queryParametersEncodable: Encodable? = nil,
         bodyParametersEncodable: Encodable? = nil,
         bodyEncoding: BodyEncoding = .jsonSerializationData,
         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParameters = headerParameters
        self.queryParametersEncodable = queryParametersEncodable
        self.bodyParametersEncodable = bodyParametersEncodable
        self.bodyEncoding = bodyEncoding
        self.responseDecoder = responseDecoder
    }
    
    func urlRequest(with apiConfig: ApiConfigInterface) throws -> URLRequest {
        let url: URL = try generateURLQueries(with: apiConfig)
        var urlRequest: URLRequest = .init(url: url)
        var allHeaders: [String: String] = apiConfig.headers
        headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }
        /// Handle body parameters from encodable object
        if let bodyParameters: [String: Any] = try bodyParametersEncodable?.toDictionary(),
            !bodyParameters.isEmpty {
            urlRequest.httpBody = encodeBody(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
    
    private func generateURLQueries(with config: ApiConfigInterface) throws -> URL {
        var url: String = config.baseUrl.absoluteString.appending(path)
        if isFullPath {
            url = path
        }
        guard var urlComponents = URLComponents(string: url) else { throw RequestGenerationError.urlComponents }
        var urlQueryItems: [URLQueryItem] = []
        /// Handle query param from main api config
        config.queryParameters.forEach {
            urlQueryItems.append(.init(name: $0.key, value: $0.value))
        }
        /// Handle query param from endpoint
        if let queryParameters: [String: Any] = try queryParametersEncodable?.toDictionary() {
            queryParameters.forEach {
                urlQueryItems.append(.init(name: $0.key, value: "\($0.value)"))
            }
        }
        if !urlQueryItems.isEmpty {
            urlComponents.queryItems = urlQueryItems
        }
        guard let url: URL = urlComponents.url else { throw RequestGenerationError.urlComponents }
        return url
    }
    
    private func encodeBody(bodyParameters: [String: Any], bodyEncoding: BodyEncoding) -> Data? {
        switch bodyEncoding {
        case .jsonSerializationData:
            return try? JSONSerialization.data(withJSONObject: bodyParameters)
        case .stringEncodingAscii:
            return bodyParameters.queryString.data(using: .ascii)
        }
    }
}
