//
//  LoginViewController.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 13/08/22.
//

import Foundation

final class LoginViewController: TableViewController {
    static func create() -> LoginViewController {
        .init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTVItems()
    }
    
    private func generateTVItems() {
        tvPresenter.add(items: [
            createImageTVItem(),
            createNameTextField()
        ])
        reloadData()
    }
    
    private func createImageTVItem() -> TVItemInterface {
        ImageTVItem { viewState in
            viewState.imageURL = URL(
                string: "https://static.vecteezy.com/system/resources/previews/003/297/247/original/3d-product-dummy-luxury-background-free-vector.jpg"
            )
            viewState.height = 500
        }
    }
    
    private func createNameTextField() -> TVItemInterface {
        TextFieldTVItem { viewState in
            viewState.text = "Dummy text"
            viewState.height = 40
            viewState.margin = .init(top: 8, bottom: 8, left: 8, right: 8)
            viewState.textFieldDidChange = { text in
                debugPrint(text ?? "")
            }
        }
    }
    
    private func reloadData() {
        tableView.reloadData()
    }
}
