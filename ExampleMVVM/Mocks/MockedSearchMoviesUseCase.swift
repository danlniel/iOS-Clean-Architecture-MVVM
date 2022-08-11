//
//  MockedSearchMoviesUseCase.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 07/08/22.
//

@testable import ExampleMVVM

final class MockedSearchMoviesUseCase: SearchMoviesUseCaseInterface {
    var paramFetchMoviesList: (
        request: MoviesRequest?, completion: ((Result<Movies, NetworkError>) -> Void)?
    )
    func fetchMoviesList(
        request: MoviesRequest,
        completion: @escaping (Result<Movies, NetworkError>) -> Void
    ) {
        paramFetchMoviesList.request = request
        paramFetchMoviesList.completion = completion
    }
}
