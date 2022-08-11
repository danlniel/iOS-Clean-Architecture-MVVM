//
//  DIContainer.swift
//  SwiftInjection
//
//  Created by Daniel Sunarjo on 26/07/22.
//

protocol DIContainerInterface {
    func register<T>(asSingleton: Bool, module: @escaping () -> T)
    func register<T>(module: @escaping () -> T)
    func resolve<T>() -> T
}

final class DIContainer: DIContainerInterface {
    static let instance: DIContainerInterface = DIContainer()
    private var bindingDictionary: [String: DIBinding] = [:]
	
    func register<T>(asSingleton: Bool, module: @escaping () -> T) {
        let moduleKey: String = .init(describing: T.self)
        let binding: DIBinding = .init(
            closure: module,
            asSingleton: asSingleton
        )
        bindingDictionary[moduleKey] = binding
	}
    
    func register<T>(module: @escaping () -> T) {
        register(asSingleton: false, module: module)
    }
	
	func resolve<T>() -> T {
        let moduleKey: String = .init(describing: T.self)
        guard let diBinding: DIBinding = bindingDictionary[moduleKey] else { fatalError("No binding found for \(moduleKey)") }
        guard let providedInstance = diBinding.provideInstance() as? T else {
            fatalError("Failed to parse \(moduleKey) instance")
        }
		return providedInstance
    }
}
