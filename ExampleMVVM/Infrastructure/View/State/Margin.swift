//
//  Margin.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 30/07/22.
//

import CoreGraphics

struct Margin {
    let top: CGFloat
    let bottom: CGFloat
    let left: CGFloat
    let right: CGFloat
    
    var totalHeight: CGFloat {
        top + bottom
    }
    
    var totalWidth: CGFloat {
        left + right
    }
    
    init(top: CGFloat,
         bottom: CGFloat,
         left: CGFloat,
         right: CGFloat) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
    
    init() {
        self.init(top: 0, bottom: 0, left: 0, right: 0)
    }
}
