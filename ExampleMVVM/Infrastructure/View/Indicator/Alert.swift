//
//  Alertable.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 01.10.18.
//

import UIKit

protocol AlertInterface {
    func showAlert(
        vc: UIViewController,
        title: String,
        message: String,
        preferredStyle: UIAlertController.Style
    )
}

final class Alert: AlertInterface {
    private let okText: String = "OK"
    
    func showAlert(
        vc: UIViewController,
        title: String = "",
        message: String,
        preferredStyle: UIAlertController.Style = .alert
    ) {
        let alert: UIAlertController = .init(title: title, message: message, preferredStyle: preferredStyle)
        alert.addAction(.init(title: okText, style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
