//
//  MovieDetailViewModel.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 06/08/22.
//

protocol MovieDetailViewModelInterface {
    var state: MovieDetailViewModelState { get }
    func setup(movieTitle: String)
}

final class MovieDetailViewModelState {
    var movieTitle: Observable<String> = .init("")
}

final class MovieDetailViewModel: MovieDetailViewModelInterface {
    var state: MovieDetailViewModelState
    
    // MARK: - Init

    init() {
        state = .init()
    }
    
    func setup(movieTitle: String) {
        state.movieTitle.value = movieTitle
    }
}
