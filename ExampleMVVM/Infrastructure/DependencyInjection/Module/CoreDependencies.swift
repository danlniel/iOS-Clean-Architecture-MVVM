//
//  CoreDependencies.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 31/07/22.
//

final class CoreDependencies: DIModule {
    func register(container: DIContainerInterface) {
        container.register() {
            NetworkService() as NetworkServiceInterface
        }
        container.register() {
            NetworkSessionManager() as NetworkSessionManagerInterface
        }
        container.register() {
            NetworkErrorLogger() as NetworkErrorLoggerInterface
        }
        container.register() {
            ApiConfigurator() as ApiConfiguratorInterface
        }
        container.register(asSingleton: true) {
            AppNavigation.instance as AppNavigationInterface
        }
    }
}
