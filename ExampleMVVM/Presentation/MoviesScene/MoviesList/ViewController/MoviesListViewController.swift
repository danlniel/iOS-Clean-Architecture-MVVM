//
//  MoviesListViewController.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 01.10.18.
//

import UIKit

final class MoviesListViewController: TableViewController  {
    private enum AccessibilityIdentifier: String {
        case MoviesListViewControllerTable
    }
    
    @Injected
    private var viewModel: MoviesListViewModelInterface

    // MARK: - Lifecycle

    static func create() -> MoviesListViewController {
        .init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind(viewModel)
        listenTableView()
        fetch()
    }
    
    private func setup() {
        tableView.accessibilityIdentifier = AccessibilityIdentifier.MoviesListViewControllerTable.rawValue
    }
    
    private func fetch() {
        viewModel.fetch()
    }
    
    private func reloadData() {
        tableView.reloadData()
    }
    
    private func listenTableView() {
        tvPresenter.onCellWillDisplay = { [weak self] _, _, indexPath in
            guard let ws = self else { return }
            if indexPath == ws.tvPresenter.lastIndexPath() {
                ws.fetch()
            }
        }
    }

    private func bind(_ viewModel: MoviesListViewModelInterface) {
        viewModel.state.newItems.observe(on: self) { [weak self] movies in
            self?.addNewItems(movies: movies)
        }
    }
    
    private func addNewItems(movies: [Movie]) {
        let moviesItemView: [TVItemInterface] = movies.map { movie in
            createMovieTVItem(movieTitle: movie.title.emptyIfNil())
        }
        tvPresenter.add(items: moviesItemView)
        reloadData()
    }
    
    private func createMovieTVItem(movieTitle: String) -> TVItemInterface {
        MovieTVItem() { state in
            state.titleText = movieTitle
            state.onTapButton = { [weak self] in
                self?.viewModel.actions.goToMovieDetail(movieTitle: movieTitle)
            }
            state.margin = .init(top: 8, bottom: 8, left: 8, right: 8)
        }
    }
}
