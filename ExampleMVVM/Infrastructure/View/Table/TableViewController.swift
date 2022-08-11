//
//  TableViewController.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 28/07/22.
//

import UIKit

class TableViewController: UIViewController {
    let tableView: UITableView
    let tvPresenter: TVPresenterInterface
    
    init() {
        tableView = .init()
        tvPresenter = TVPresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = tvPresenter
        tableView.dataSource = tvPresenter
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
}
