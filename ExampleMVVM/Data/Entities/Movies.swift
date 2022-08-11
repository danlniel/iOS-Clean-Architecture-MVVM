//
//  MoviesDTO.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 27/07/22.
//

struct Movies: Decodable {
    let page: Int
    let totalPages: Int
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
    }
}
