//
//  JSONResponseDecoder.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 27/07/22.
//

import Foundation

final class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder: JSONDecoder = .init()
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        try jsonDecoder.decode(T.self, from: data)
    }
}
