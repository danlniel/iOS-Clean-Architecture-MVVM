//
//  EncodableExt.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 01/08/22.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data: Data = try JSONEncoder().encode(self)
        let jsonDict: Any = try JSONSerialization.jsonObject(with: data)
        return jsonDict as? [String: Any]
    }
}
