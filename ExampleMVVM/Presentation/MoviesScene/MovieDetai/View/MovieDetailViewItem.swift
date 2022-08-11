//
//  MovieDetailViewItem.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 06/08/22.
//

import UIKit

final class MovieDetailViewItem: TVItem {
    class State {
        var titleText: String = ""
    }
    private var state: State = .init()
    
    private lazy var titleLabel: UILabel = .init()
    private let containerMargin: Margin = .init(top: 8, bottom: 8, left: 8, right: 8)
    
    convenience init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String? = nil, stateClosure: (State) -> ()) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        stateClosure(state)
        setupView()
    }
    
    override func setupLayout(tableViewSize: TableViewSize) {
        super.setupLayout(tableViewSize: tableViewSize)
        renderLabel()
    }
    
    override func heightCell() -> CGFloat {
        titleLabel.frame.height + containerMargin.totalHeight
    }
    
    private func setupView() {
        addSubview(titleLabel)
    }
    
    private func renderLabel() {
        titleLabel.text = state.titleText
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        let titleLabelWidth: CGFloat = frame.width - containerMargin.totalWidth
        let titleLabelHeight: CGFloat = state.titleText.height(width: titleLabelWidth, font: titleLabel.font)
        titleLabel.frame.size = .init(width: titleLabelWidth, height: titleLabelHeight)
        titleLabel.top(to: self, space: containerMargin.top)
        titleLabel.leading(to: self, space: containerMargin.left)
    }
}
