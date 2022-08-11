//
//  ViewModelDependenciesTest.swift
//  ExampleMVVMTests
//
//  Created by Daniel Sunarjo on 08/08/22.
//

@testable import ExampleMVVM

final class ViewModelDependenciesTests: DIModule {
    func register(container: DIContainerInterface) {
        container.register(asSingleton: true) {
            MockedMovieListActions() as MovieListActionsInterface
        }
    }
}
