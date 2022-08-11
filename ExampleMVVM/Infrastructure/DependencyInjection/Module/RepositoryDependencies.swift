//
//  RepositoryDependencies.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 31/07/22.
//

final class RepositoryDependencies: DIModule {
    func register(container: DIContainerInterface) {
        container.register() {
            MoviesRepository() as MoviesRepositoryInterface
        }
    }
}
