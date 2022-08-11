//
//  DictionaryExt.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 28/07/22.
//

import Foundation

extension Dictionary where Key == String {
    var queryString: String {
        return map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .emptyIfNil()
    }
}

extension Dictionary {
    func prettyPrint() -> String {
        guard let data: Data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
              let encodedString: String = .init(data: data, encoding: .utf8)
        else { return "" }
        return encodedString
    }
}
