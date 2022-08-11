//
//  LoadingView.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 28/03/2020.
//

import UIKit

protocol LoadingViewInterface {
    func show()
    func hide()
}

final class LoadingView: LoadingViewInterface {
    static let instance: LoadingViewInterface = LoadingView()
    
    private var spinner: UIActivityIndicatorView?

    func show() {
        DispatchQueue.main.async {
            guard self.spinner == nil, let window = UIApplication.shared.keyWindow else { return }
            let spinnerFrame: CGRect = window.bounds
            let spinner: UIActivityIndicatorView = .init(frame: spinnerFrame)
            spinner.backgroundColor = .black.withAlphaComponent(0.2)
            spinner.style = .whiteLarge
            self.spinner = spinner
            
            window.addSubview(spinner)
            spinner.startAnimating()
        }
    }

    func hide() {
        DispatchQueue.main.async {
            guard let spinner = self.spinner else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.spinner = nil
        }
    }
}
