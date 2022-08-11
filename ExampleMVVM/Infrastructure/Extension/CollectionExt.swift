//
//  CollectionExt.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 29/07/22.
//

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
