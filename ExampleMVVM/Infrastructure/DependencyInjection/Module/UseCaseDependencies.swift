//
//  UseCaseDependencies.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 26/07/22.
//

final class UseCaseDependencies: DIModule {
    func register(container: DIContainerInterface) {
        container.register() {
            SearchMoviesUseCase() as SearchMoviesUseCaseInterface
        }
    }
}
