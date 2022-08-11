//
//  MoviesListViewModel.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 01.10.18.
//

import Foundation

protocol MoviesListViewModelInterface {
    var state: MoviesListViewModelState { get }
    var actions: MovieListActionsInterface { get }
    func fetch()
    func reset()
}

final class MoviesListViewModelState {
    let items: Observable<[Movie]> = .init([])
    let newItems: Observable<[Movie]> = .init([])
    let error: Observable<NetworkError> = .init(.unknown)
    var currentPage: Int = 0
    var hasNextPage: Bool = true
    fileprivate var nextPage: Int {
        currentPage + 1
    }
    
    func add(movies: [Movie]) {
        newItems.value = movies
        items.value.append(contentsOf: movies)
    }
}

final class MoviesListViewModel: MoviesListViewModelInterface {
    @Injected
    private var searchMoviesUseCase: SearchMoviesUseCaseInterface
    @Injected
    var actions: MovieListActionsInterface
    var state: MoviesListViewModelState
    
    // MARK: - Init

    init() {
        state = .init()
    }
    
    func fetch() {
        guard state.hasNextPage else { return }
        let request: MoviesRequest = .init(query: "earth", page: state.nextPage)
        searchMoviesUseCase.fetchMoviesList(
            request: request,
            completion: { [weak self] result in
                guard let ws = self else { return }
                switch result {
                case .success(let info):
                    ws.state.currentPage = info.page
                    guard !info.movies.isEmpty else {
                        ws.state.hasNextPage = false
                        return
                    }
                    ws.state.add(movies: info.movies)
                case .failure(let error):
                    ws.state.error.value = error
                }
            }
        )
    }
    
    func reset() {
        state.hasNextPage = true
        state.currentPage = 0
        state.items.value = []
        state.newItems.value = []
    }
}
