//
//  DIManagerTest.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 07/08/22.
//

@testable import ExampleMVVM

final class DIManagerTests: DIManagerInterface {
    private var dependencies: [DIModule] = []
    private lazy var container: DIContainerInterface = DIContainer.instance
    
    func register() {
        registerDependencies()
        registerContainer()
    }
    
    private func registerDependencies() {
        dependencies = [
            CoreDependenciesTests(),
            UseCaseDependenciesTests(),
            ViewModelDependenciesTests()
        ]
    }
    
    private func registerContainer() {
        dependencies.forEach { diModule in
            diModule.register(container: container)
        }
    }
}
