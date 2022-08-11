//
//  DefaultMoviesRepository.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 01.10.18.
//
// **Note**: DTOs structs are mapped into Domains here, and Repository protocols does not contain DTOs

import Foundation

protocol MoviesRepositoryInterface {
    func fetchMoviesList(
        request: MoviesRequest,
        completion: @escaping (Result<Movies, NetworkError>) -> Void
    )
}

final class MoviesRepository: MoviesRepositoryInterface {
    @Injected
    private var networkService: NetworkServiceInterface
    
    func fetchMoviesList(
        request: MoviesRequest,
        completion: @escaping (Result<Movies, NetworkError>) -> Void
    ) {
        let endpoint = MovieEndpoints.getMovies(with: request)
        networkService.request(endpoint: endpoint, completion: completion)
    }
}
