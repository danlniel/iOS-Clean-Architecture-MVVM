//
//  TVSection.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 29/07/22.
//

protocol TVSectionInterface {
    var index: Int { get }
    var items: [TVItemInterface] { get set }
}

final class TVSection: TVSectionInterface {
    var index: Int = 0
    var items: [TVItemInterface] = []
    
    init(index: Int) {
        self.index = index
    }
}
