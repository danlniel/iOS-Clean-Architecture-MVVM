//
//  MockedMovieListActions.swift
//  ExampleMVVMTests
//
//  Created by Daniel Sunarjo on 08/08/22.
//

@testable import ExampleMVVM

final class MockedMovieListActions: MovieListActionsInterface {
    var paramGoToMovieDetail: (
        isCalled: Bool?, movieTitle: String?
    )
    func goToMovieDetail(movieTitle: String) {
        paramGoToMovieDetail.isCalled = true
        paramGoToMovieDetail.movieTitle = movieTitle
    }
}
