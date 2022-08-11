//
//  SearchMoviesUseCase.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 22.02.19.
//

import Foundation

protocol SearchMoviesUseCaseInterface {
    func fetchMoviesList(
        request: MoviesRequest,
        completion: @escaping (Result<Movies, NetworkError>) -> Void
    )
}

final class SearchMoviesUseCase: SearchMoviesUseCaseInterface {
    @Injected
    private var moviesRepository: MoviesRepositoryInterface
    
    func fetchMoviesList(
        request: MoviesRequest,
        completion: @escaping (Result<Movies, NetworkError>) -> Void
    ) {
        moviesRepository.fetchMoviesList(
            request: request,
            completion: completion
        )
    }
}
