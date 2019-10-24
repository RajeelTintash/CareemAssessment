//
//  CAModelTester.swift
//  CareemAssessmentTests
//
//  Created by Rajeel Amjad on 24/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import XCTest
@testable import CareemAssessment

class CAModelTester: XCTestCase {
    var movieListModel : CAMoviesListModel!
    var movie          : CAMovie!
    var genre          : Genre!
    
    override func setUp() {
        // Creating models
        movie = CAMovie(popularity: 2.0, id: 1, video: nil, voteCount: 32, voteAverage: 100, title: "My Movie", releaseDate: Date(), originalLanguage: "en", originalTitle: nil, genreIds: [1,2,3], backdropPath: nil, adult: nil, overview: "Some overview", posterPath: "somePAth")
        movieListModel = CAMoviesListModel(page: 1, totalResults: 2, totalPages: 22, movies: [movie])
        genre = Genre(id: 1, name: "sadds")
        super.setUp()
    }

    override func tearDown() {
        // Clean up
        movie = nil
        movieListModel  = nil
        genre = nil
        super.tearDown()
    }
    
    /// Tests movie detail cell DTO
    func testMovieDetailCellModel() {
        
        // 1. given
        let testMovieDetailCellModel = CAMovieDetailCellModel(movie,genres: CAGenresModel(genres: [genre]))
        
        // 2. Then
        
        XCTAssertNotNil(testMovieDetailCellModel.movieGenres,"Movie genres are Nil")
        XCTAssertNotNil(testMovieDetailCellModel.movieLanguage,"Movie language is Nil")
        XCTAssertNotNil(testMovieDetailCellModel.movieRating,"Movie rating is Nil")
        XCTAssertNotNil(testMovieDetailCellModel.movieReleaseDate,"Movie releaseDate is Nil")
        XCTAssertNotNil(testMovieDetailCellModel.movieTitle,"Movie title is Nil")
    }
    
    /// Test movie detail DTO
    func testMovieDetailModel() {
        
        // 1. given
        let testMovieDetailModel = CAMoviesDetailModel(movie,genres: CAGenresModel(genres: [genre]))
        
        // 2. Then
        
        XCTAssertNil(testMovieDetailModel.movieBackDropURL,"Movie backdrop is not nil")
        XCTAssertNotNil(testMovieDetailModel.movieOverView,"Movie overview is Nil")
        XCTAssertNotNil(testMovieDetailModel.movieTitle,"Movie title is Nil")
        XCTAssertNotNil(testMovieDetailModel.movieDetailCellModel,"Movie detailcell model is Nil")
    }
    
    /// Test movie list cell DTO
    func testMovieCellModel() {
        
        // 1. given
        let testMovieCellModel = CAMovieListCellModel(movie,genres: CAGenresModel(genres: [genre]))
        
        // 2. Then
        
        XCTAssertNotNil(testMovieCellModel.movieGenres,"Movie genres are Nil")
        XCTAssertNotNil(testMovieCellModel.moviePosterURL,"Movie poster is Nil")
        XCTAssertNotNil(testMovieCellModel.movieTitle,"Movie title is Nil")
        XCTAssertNotNil(testMovieCellModel.movieRating,"Movie rating is Nil")
        XCTAssertNotNil(testMovieCellModel.movieReleaseDate,"Movie release date is Nil")
    }
}

