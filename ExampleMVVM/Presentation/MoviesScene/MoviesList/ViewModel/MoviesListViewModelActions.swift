//
//  MoviesListViewModelActions.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 26/07/22.
//

import UIKit

protocol MovieListActionsInterface {
    func goToMovieDetail(movieTitle: String)
}

final class MovieListActions: MovieListActionsInterface {
    @Injected
    private var appNavigation: AppNavigationInterface
    
    func goToMovieDetail(movieTitle: String) {
        let currentScreen: UIViewController? = appNavigation.currentScreen()
        let movieDetailScreen: UIViewController = MovieDetailViewController.create(movieTitle: movieTitle)
        currentScreen?.present(movieDetailScreen, animated: true, completion: nil)
    }
}
