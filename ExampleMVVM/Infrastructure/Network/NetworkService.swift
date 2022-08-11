//
//  NetworkService.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 01.10.18.
//

import Foundation

protocol NetworkServiceInterface {
    typealias CompletionHandler<T> = (Result<T, NetworkError>) -> Void
    
    @discardableResult
    func request<T: Decodable>(
        endpoint: Requestable, completion: @escaping CompletionHandler<T>
    ) -> URLSessionTask?
}

final class NetworkService {
    @Injected
    private var sessionManager: NetworkSessionManagerInterface
    @Injected
    private var logger: NetworkErrorLoggerInterface
    @Injected
    private var apiConfigurator: ApiConfiguratorInterface
    
    private func convertNetworkError(data: Data?, urlResponse: URLResponse?, error: Error) -> NetworkError {
        if let urlResponse = urlResponse as? HTTPURLResponse {
            return .error(statusCode: urlResponse.statusCode, data: data)
        }
        let code: URLError.Code = .init(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
    
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder, completion: CompletionHandler<T>) {
        do {
            guard let data = data else {
                throw NetworkError.nilData
            }
            let decodeResult: T = try decoder.decode(data)
            completion(.success(decodeResult))
        } catch NetworkError.nilData {
            completion(.failure(.nilData))
        } catch {
            completion(.failure(.parsing(error)))
        }
    }
}

extension NetworkService: NetworkServiceInterface {
    func request<T: Decodable>(
        endpoint: Requestable, completion: @escaping CompletionHandler<T>
    ) -> URLSessionTask? {
        guard let urlRequest = try? endpoint.urlRequest(with: apiConfigurator.activeEnvironment()) else {
            completion(.failure(.urlGeneration))
            return nil
        }
        logger.log(request: urlRequest) // Log url request
        let urlSessionTask = sessionManager.request(urlRequest) { [weak self] data, urlResponse, error in
            guard let ws = self else { return }
            if let _error = error {
                let networkError: NetworkError = ws.convertNetworkError(data: data, urlResponse: urlResponse, error: _error)
                completion(.failure(networkError))
                return
            }
            ws.decode(data: data, decoder: endpoint.responseDecoder, completion: completion)
        }
        return urlSessionTask
    }
}
