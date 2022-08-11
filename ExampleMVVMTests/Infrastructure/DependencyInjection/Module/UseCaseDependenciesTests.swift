//
//  UseCaseDependenciesTest.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 07/08/22.
//

@testable import ExampleMVVM

final class UseCaseDependenciesTests: DIModule {
    func register(container: DIContainerInterface) {
        container.register(asSingleton: true) {
            MockedSearchMoviesUseCase() as SearchMoviesUseCaseInterface
        }
    }
}
