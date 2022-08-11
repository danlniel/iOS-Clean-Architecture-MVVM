//
//  Observable.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 16.02.19.
//

import Foundation

final class Observable<Value> {
    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }
    
    var value: Value {
        didSet { notifyObservers() }
    }
    private var observers: [Observer<Value>] = []
    
    init(_ value: Value) {
        self.value = value
    }
    
    func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        observers.append(.init(observer: observer, block: observerBlock))
        observerBlock(value)
    }
    
    func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    
    private func notifyObservers() {
        for observer in observers {
            DispatchQueue.main.async { observer.block(self.value) }
        }
    }
}
