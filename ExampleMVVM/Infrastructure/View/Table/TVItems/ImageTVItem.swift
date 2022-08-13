//
//  ImageTVItem.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 13/08/22.
//

import Foundation
import UIKit

final class ImageTVItem: TVItem {
    class State: BaseState {
        var imageURL: URL?
    }
    private var state: State = .init()
    
    private lazy var customImageView: ImageView = .init()
    
    convenience init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String? = nil, stateClosure: (State) -> ()) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        stateClosure(state)
        setupView()
    }
    
    override func setupLayout(tableViewSize: TableViewSize) {
        super.setupLayout(tableViewSize: tableViewSize)
        renderImageView()
    }
    
    override func heightCell() -> CGFloat {
        state.height + state.margin.totalHeight
    }
    
    private func setupView() {
        contentView.addSubview(customImageView)
    }
    
    private func renderImageView() {
        guard let imageURL: URL = state.imageURL else { return }
        customImageView.frame = .init(
            x: state.margin.left,
            y: state.margin.top,
            width: imageWidth(),
            height: state.height
        )
        customImageView.load(url: imageURL)
    }
    
    private func imageWidth() -> CGFloat {
        frame.width - state.margin.totalWidth
    }
}
