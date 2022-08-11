//
//  MovieDTO.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 27/07/22.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String?
    let genre: MovieGenre?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    
    enum MovieGenre: String, Decodable {
        case adventure
        case scienceFiction = "science_fiction"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case genre
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
}
