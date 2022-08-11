//
//  TVItem.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 28/07/22.
//

import UIKit

protocol TVItemInterface {
    var section: Int { get }
    func setupLayout(tableViewSize: TableViewSize)
    func asCell() -> UITableViewCell
    func heightCell() -> CGFloat
}

class TVItem: UITableViewCell, TVItemInterface {
    var section: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(tableViewSize: TableViewSize) {
        frame.size = tableViewSize.size
    }
    
    func asCell() -> UITableViewCell {
        self
    }
    
    func heightCell() -> CGFloat {
        0
    }
}
