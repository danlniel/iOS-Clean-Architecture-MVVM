//
//  ImageView.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 31/07/22.
//

import UIKit

final class ImageView: UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image: UIImage = .init(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
