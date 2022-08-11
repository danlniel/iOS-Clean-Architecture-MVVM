//
//  DIBinding.swift
//  SwiftInjection
//
//  Created by Daniel Sunarjo on 26/07/22.
//

final class DIBinding {
	private let closure: () -> Any
    private let asSingleton: Bool
    private var singletonInstance: Any?
	
	init(closure: @escaping () -> Any, asSingleton: Bool) {
		self.closure = closure
		self.asSingleton = asSingleton
	}
    
    func provideInstance() -> Any {
        if asSingleton {
            if let singletonInstance = singletonInstance {
                return singletonInstance
            } else {
                let instance = closure()
                singletonInstance = instance
                return instance
            }
        } else {
            return closure()
        }
    }
}
