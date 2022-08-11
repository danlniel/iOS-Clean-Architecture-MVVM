//
//  DIManager.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 26/07/22.
//

protocol DIModule {
    func register(container: DIContainerInterface)
}

protocol DIManagerInterface {
    func register()
}

final class DIManager: DIManagerInterface {
    private var dependencies: [DIModule] = []
    private lazy var container: DIContainerInterface = DIContainer.instance
    
    func register() {
        registerDependencies()
        registerContainer()
    }
    
    private func registerDependencies() {
        dependencies = [
            CoreDependencies(),
            RepositoryDependencies(),
            UseCaseDependencies(),
            ViewModelDependencies()
        ]
    }
    
    private func registerContainer() {
        dependencies.forEach { diModule in
            diModule.register(container: container)
        }
    }
}
