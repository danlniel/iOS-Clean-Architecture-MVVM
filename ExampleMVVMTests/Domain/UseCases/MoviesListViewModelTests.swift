//
//  SearchMoviesUseCaseTests.swift
//  CodeChallengeTests
//
//  Created by Daniel Sunarjo on 01.10.18.
//

import XCTest
@testable import ExampleMVVM

class SearchMoviesUseCaseTests: XCTestCase {
    var sut: MoviesListViewModel!
    lazy var mockedSearchMoviesUseCase: MockedSearchMoviesUseCase = {
        let useCase: SearchMoviesUseCaseInterface = DIContainer.instance.resolve()
        return useCase as! MockedSearchMoviesUseCase
    }()
    
    override class func setUp() {
        DIManagerTests().register()
    }
    
    override func setUp() {
        sut = .init()
    }
    
    func testFetch_whenCompletionIsSuccess_andTheResultIsNotEmpty() {
        let mockResponse: Movies = .init(
            page: 1,
            totalPages: 5,
            movies: [
                .init(
                    id: 0,
                    title: nil,
                    genre: .none,
                    posterPath: nil,
                    overview: nil,
                    releaseDate: nil
                )
            ]
        )
        sut.state.hasNextPage = true
        
        sut.fetch()
        mockedSearchMoviesUseCase.paramFetchMoviesList.completion?(.success(mockResponse))
        
        XCTAssertEqual(sut.state.currentPage, 1)
        XCTAssertEqual(sut.state.items.value.count, 1)
        XCTAssertEqual(sut.state.newItems.value.count, 1)
    }
    
    func testFetch_whenCompletionIsSuccess_andTheResultIsEmpty() {
        let mockResponse: Movies = .init(
            page: 1,
            totalPages: 5,
            movies: []
        )
        sut.state.hasNextPage = true
        
        sut.fetch()
        mockedSearchMoviesUseCase.paramFetchMoviesList.completion?(.success(mockResponse))
        
        XCTAssertFalse(sut.state.hasNextPage)
    }
    
    func testFetch_whenCompletionIsError() {
        sut.state.hasNextPage = true
        
        sut.fetch()
        mockedSearchMoviesUseCase.paramFetchMoviesList.completion?(.failure(.unknown))
        
        XCTAssertEqual(sut.state.error.value, .unknown)
    }
    
    func testReset() {
        sut.reset()
        
        XCTAssertTrue(sut.state.hasNextPage)
        XCTAssertEqual(sut.state.currentPage, 0)
        XCTAssertTrue(sut.state.items.value.isEmpty)
        XCTAssertTrue(sut.state.newItems.value.isEmpty)
    }
}
