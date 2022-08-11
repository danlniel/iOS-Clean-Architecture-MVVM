//
//  RawDataResponseDecoder.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 27/07/22.
//

import Foundation

final class RawDataResponseDecoder: ResponseDecoder {
    private enum CodingKeys: CodingKey {
        case `default`
    }
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context: DecodingError.Context = .init(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
            throw DecodingError.typeMismatch(T.self, context)
        }
    }
}
