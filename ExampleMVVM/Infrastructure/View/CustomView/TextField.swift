//
//  TextField.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 09/08/22.
//

import UIKit

final class TextField: UITextField {
    class State {
        var text: String?
        var textFieldDidChange: ((String?) -> Void)?
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
        text = _state.text
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        _state.textFieldDidChange?(textField.text)
    }
}
