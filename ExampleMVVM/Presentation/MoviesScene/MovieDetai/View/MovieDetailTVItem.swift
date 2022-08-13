//
//  MovieDetailTVItem.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 06/08/22.
//

import UIKit

final class MovieDetailTVItem: TVItem {
    class State: BaseState {
        var titleText: String = ""
    }
    private var state: State = .init()
    
    private lazy var titleLabel: UILabel = .init()
    
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
        titleLabel.frame.height + state.margin.totalHeight
    }
    
    private func setupView() {
        contentView.addSubview(titleLabel)
    }
    
    private func renderLabel() {
        titleLabel.text = state.titleText
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        let titleLabelWidth: CGFloat = frame.width - state.margin.totalWidth
        let titleLabelHeight: CGFloat = state.titleText.height(width: titleLabelWidth, font: titleLabel.font)
        titleLabel.frame.size = .init(width: titleLabelWidth, height: titleLabelHeight)
        titleLabel.top(to: self, space: state.margin.top)
        titleLabel.leading(to: self, space: state.margin.left)
    }
}
