//
//  Button.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 06/08/22.
//

import UIKit

final class Button: UIButton {
    class State {
        var title: String = ""
        var onTapButton: (() -> Void)?
    }
    private let _state: State = .init()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(stateClosure: (State) -> Void) {
        stateClosure(_state)
        setupView()
    }
    
    private func setupView() {
        setTitle(_state.title, for: .normal)
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc private func buttonPressed() {
        _state.onTapButton?()
    }
}
