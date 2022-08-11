//
//  MoviesRequest.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 22/03/2020.
//

import Foundation

struct MoviesRequest: Encodable {
    let query: String
    let page: Int
}
