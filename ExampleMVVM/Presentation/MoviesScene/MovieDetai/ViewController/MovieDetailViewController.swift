//
//  MovieDetailViewController.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 06/08/22.
//

import UIKit

final class MovieDetailViewController: TableViewController  {
    @Injected
    private var viewModel: MovieDetailViewModelInterface

    // MARK: - Lifecycle

    static func create(movieTitle: String) -> MovieDetailViewController {
        let vc: MovieDetailViewController = .init()
        vc.viewModel.setup(movieTitle: movieTitle)
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel)
    }
    
    private func reloadData() {
        tableView.reloadData()
    }

    private func bind(_ viewModel: MovieDetailViewModelInterface) {
        viewModel.state.movieTitle.observe(on: self) { [weak self] movieTitle in
            self?.generateTVItems(movieTitle: movieTitle)
        }
    }
    
    private func generateTVItems(movieTitle: String) {
        let movieDetailItem: TVItemInterface = createMovieDetalViewItem(titleText: movieTitle)
        tvPresenter.add(items: [movieDetailItem])
        reloadData()
    }
    
    private func createMovieDetalViewItem(titleText: String) -> TVItemInterface {
        MovieDetailTVItem() { state in
            state.titleText = titleText
            state.margin = .init(top: 8, bottom: 8, left: 8, right: 8)
        }
    }
}
