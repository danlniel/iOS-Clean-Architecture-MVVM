//
//  MovieEndpoints.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 01.10.18.
//

import Foundation

struct MovieEndpoints {
    static func getMovies(with moviesRequest: MoviesRequest) -> Endpoint {
        .init(
            path: "/3/search/movie/",
            method: .get,
            queryParametersEncodable: moviesRequest
        )
    }
}
