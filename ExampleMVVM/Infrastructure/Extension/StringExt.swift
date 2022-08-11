//
//  StringExt.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 30/07/22.
//

import UIKit

extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect: CGSize = .init(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        return ceil(boundingBox.height)
    }
}

extension Optional where Wrapped == String {
    func emptyIfNil() -> String {
        if let stringValue: String = self {
            return stringValue
        }
        return ""
    }
}
