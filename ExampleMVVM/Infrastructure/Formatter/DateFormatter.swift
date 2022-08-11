//
//  DateFormatter.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 02/08/22.
//

import Foundation

struct DefaultDateFormatter {
    func dateFormatter() -> DateFormatter {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }
}
