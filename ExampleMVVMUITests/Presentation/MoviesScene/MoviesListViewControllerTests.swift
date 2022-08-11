//
//  MoviesListViewControllerTests.swift
//  MoviesListViewControllerTests
//
//  Created by Daniel Sunarjo on 05.08.19.
//

import XCTest

final class MoviesListViewControllerTests: XCTestCase {
    // NOTE: for UI tests to work the keyboard of simulator must be on.
    // Keyboard shortcut COMMAND + SHIFT + K while simulator has focus
    
    var app: XCUIApplication!
    
    override func setUp() {
        app = .init()
        app.launch()
    }
    
    func testFirstRenderOfMovieListViewController() {
        let tableIsFound: Bool = app.tables["MoviesListViewControllerTable"].waitForExistence(timeout: 3)
        
        XCTAssertTrue(tableIsFound)
    }
}
