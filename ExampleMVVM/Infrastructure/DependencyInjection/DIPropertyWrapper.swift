//
//  DIPropertyWrapper.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 26/07/22.
//

@propertyWrapper
struct Injected<Component> {
    let wrappedValue: Component
    
    init() {
        self.wrappedValue = DIContainer.instance.resolve()
    }
}
