//
//  ViewModelDependencies.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 31/07/22.
//

final class ViewModelDependencies: DIModule {
    func register(container: DIContainerInterface) {
        container.register() {
            MoviesListViewModel() as MoviesListViewModelInterface
        }
        container.register() {
            MovieListActions() as MovieListActionsInterface
        }
        container.register() {
            MovieDetailViewModel() as MovieDetailViewModelInterface
        }
    }
}
