//
//  TextFieldTVItem.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 13/08/22.
//

import Foundation
import UIKit

final class TextFieldTVItem: TVItem {
    class State: BaseState {
        var text: String?
        var textFieldDidChange: ((String?) -> Void)?
    }
    private var state: State = .init()
    
    private lazy var textField: TextField = .init()
    
    convenience init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String? = nil, stateClosure: (State) -> ()) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        stateClosure(state)
        setupView()
    }
    
    override func setupLayout(tableViewSize: TableViewSize) {
        super.setupLayout(tableViewSize: tableViewSize)
        renderTextField()
    }
    
    override func heightCell() -> CGFloat {
        textField.bounds.height + state.margin.totalHeight
    }
    
    private func setupView() {
        contentView.addSubview(textField)
    }
    
    private func renderTextField() {
        textField.setup { viewState in
            viewState.text = state.text
            viewState.textFieldDidChange = state.textFieldDidChange
        }
        textField.frame = .init(
            x: state.margin.left,
            y: state.margin.top,
            width: textFieldWidth(),
            height: state.height
        )
    }
    
    private func textFieldWidth() -> CGFloat {
        frame.width - state.margin.totalWidth
    }
}
