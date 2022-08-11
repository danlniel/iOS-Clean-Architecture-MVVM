//
//  UITableViewExt.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 30/07/22.
//

import UIKit

protocol TableViewSize {
    var size: CGSize { get }
}

extension UITableView: TableViewSize {
    var size: CGSize {
        frame.size
    }
}
