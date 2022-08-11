//
//  MovieViewItem.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 30/07/22.
//

import UIKit

final class MovieViewItem: TVItem {
    class State {
        var titleText: String = ""
        var movieImageUrl: String = ""
        var onTapButton: (() -> Void)?
    }
    private var state: State = .init()
    
    private lazy var titleLabel: UILabel = .init()
    private lazy var movieImage: ImageView = .init()
    private lazy var button: Button = .init()
    private let containerMargin: Margin = .init(top: 8, bottom: 8, left: 8, right: 8)
    private let movieImageSize: CGSize = .init(width: 100, height: 100)
    private let imageToLabelSpace: CGFloat = 8
    
    convenience init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String? = nil, stateClosure: (State) -> ()) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        stateClosure(state)
        setupView()
    }
    
    override func setupLayout(tableViewSize: TableViewSize) {
        super.setupLayout(tableViewSize: tableViewSize)
        renderImageView()
        renderLabel()
        renderButton()
    }
    
    override func heightCell() -> CGFloat {
        max(titleLabel.frame.height, movieImage.frame.height) + containerMargin.totalHeight
    }
    
    private func setupView() {
        addSubview(movieImage)
        addSubview(titleLabel)
        addSubview(button)
    }
    
    private func renderImageView() {
        guard let movieImageUrl: URL = .init(string: state.movieImageUrl) else { return }
        movieImage.frame = .init(
            x: containerMargin.left, y: containerMargin.top, width: movieImageSize.width, height: movieImageSize.height
        )
        movieImage.load(url: movieImageUrl)
    }
    
    private func renderLabel() {
        titleLabel.text = state.titleText
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        let titleLabelWidth: CGFloat = frame.width - containerMargin.totalWidth - movieImage.frame.width - imageToLabelSpace
        let titleLabelHeight: CGFloat = state.titleText.height(width: titleLabelWidth, font: titleLabel.font)
        titleLabel.frame.size = .init(width: titleLabelWidth, height: titleLabelHeight)
        titleLabel.frame.origin.y = containerMargin.top
        titleLabel.outsideTrailing(to: movieImage, space: imageToLabelSpace)
    }
    
    private func renderButton() {
        button.frame.size = .init(width: bounds.width, height: heightCell())
        button.setup() { buttonState in
            buttonState.onTapButton = { [weak self] in
                self?.state.onTapButton?()
            }
        }
        bringSubviewToFront(button)
    }
}
