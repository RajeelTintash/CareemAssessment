//
//  CAApiTester.swift
//  CareemAssesmentTests
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import XCTest
@testable import CareemAssessment

class CAApiTester: XCTestCase {
    var movieListViewController : CAMoviesListViewController!
    
    override func setUp() {
//        Initialize view controller
        movieListViewController = CAMoviesListViewController()
        super.setUp()
    }

    override func tearDown() {
        // Cleanup
        movieListViewController = nil
        super.tearDown()
    }
    
    /// Test fetching of movieList
    func testFetchMoviesList() {
        // 1. given
        let viewModel = movieListViewController.viewModel
        let promise = expectation(description: "Success is triggered")
        
        // 2. when
        viewModel.fetchMovies()

        // 3. then
        viewModel.success = {
            promise.fulfill()
            XCTAssertNotNil(viewModel.movieList,"Movie List is Nil")
        }
        wait(for: [promise], timeout: 10)
    }
    
    /// Test fetch genres method
    func testFetchGenres() {
        // 1. given
        let viewModel = movieListViewController.viewModel
        let promise = expectation(description: "Success is triggered")
        
        // 2. when
        viewModel.fetchGenres()

        // 3. then
        viewModel.success = {
            promise.fulfill()
            XCTAssertNotNil(viewModel.genres,"Genre List is Nil")
            XCTAssertNotNil(viewModel.movieList,"Movie List is Nil")
        }
        wait(for: [promise], timeout: 10)
        
    }
    
    /// Tests  filtering by genre and makes sure the received array contains only the selcted genre
    func testFilterByGenres() {
        // 1. given
        let viewModel = movieListViewController.viewModel
        let promise = expectation(description: "Success is triggered")
        var isFetchingGenres = true
        
        // 2. when
        viewModel.fetchGenres()
        
        // 3. then
        viewModel.success = {
            if isFetchingGenres {
                isFetchingGenres = false
                viewModel.filterBasedOnGenres(0)
            } else {
                promise.fulfill()
                XCTAssertNotNil(viewModel.genres,"Genre List is Nil")
                XCTAssertNotNil(viewModel.movieList,"Movie List is Nil")
                viewModel.movieList.forEach { movie in
                    let genreIds = movie.genreIds
                    XCTAssertNotNil(genreIds,"Genre Ids is nil")
                    XCTAssertTrue(genreIds?.contains(28) ?? false, "Genres contain a wrong element")
                }
            }
            
        }
        wait(for: [promise], timeout: 10)
    }
}
