//
//  UIViewExt.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 31/07/22.
//

import UIKit

extension UIView {
    //MARK: - Inside view positioning helper
    func leading(to view: UIView, space: CGFloat) {
        var currentOrigin: CGPoint = frame.origin
        currentOrigin.x = view.frame.origin.x + space
        frame.origin = currentOrigin
    }
    
    func trailing(to view: UIView, space: CGFloat) {
        var currentOrigin: CGPoint = frame.origin
        currentOrigin.x = view.frame.origin.x + view.bounds.width - bounds.width - space
        frame.origin = currentOrigin
    }
    
    func top(to view: UIView, space: CGFloat) {
        var currentOrigin: CGPoint = frame.origin
        currentOrigin.y = view.frame.origin.y + space
        frame.origin = currentOrigin
    }
    
    func bottom(to view: UIView, space: CGFloat) {
        var currentOrigin: CGPoint = frame.origin
        currentOrigin.y = view.frame.origin.y + view.bounds.height - bounds.height - space
        frame.origin = currentOrigin
    }
    
    //MARK: - Outside view positioning helper
    func outsideLeading(to view: UIView, space: CGFloat) {
        var currentOrigin: CGPoint = frame.origin
        currentOrigin.x = view.frame.origin.x - bounds.width - space
        frame.origin = currentOrigin
    }
    
    func outsideTrailing(to view: UIView, space: CGFloat) {
        var currentOrigin: CGPoint = frame.origin
        currentOrigin.x = view.frame.origin.x + view.bounds.width + space
        frame.origin = currentOrigin
    }
    
    func outsideTop(to view: UIView, space: CGFloat) {
        var currentOrigin: CGPoint = frame.origin
        currentOrigin.y = view.frame.origin.y - bounds.height - space
        frame.origin = currentOrigin
    }
    
    func outsideBottom(to view: UIView, space: CGFloat) {
        var currentOrigin: CGPoint = frame.origin
        currentOrigin.y = view.frame.origin.y + view.bounds.height + space
        frame.origin = currentOrigin
    }
}
