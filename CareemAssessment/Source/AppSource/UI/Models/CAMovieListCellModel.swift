//
//  CAMovieListCellModel.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 22/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation

/// This is the DTO for the movie cell in CAMovieListViewController
struct CAMovieListCellModel {
    
    fileprivate let movie : CAMovie
    fileprivate let genres: CAGenresModel?
    
    init(_ movie :CAMovie, genres:CAGenresModel?) {
        self.movie = movie
        self.genres = genres
    }
    
    /// Returns movie poster url
    var moviePosterURL :URL? {
        get {
            guard let posterPath = movie.posterPath else {
                return URL(string: Constants.General.kEMPTY_STRING)
            }
            return URL(string: CAEndPoints.imageBase.url+PosterSizes.w185.rawValue+"/"+posterPath)
        }
    }
    
    /// Returns movie title
    var movieTitle :String {
        get {
            guard let title = movie.title else {
                return Constants.General.kEMPTY_STRING
            }
            return title
        }
    }
    
    /// Returns movie rating
    var movieRating :String {
        get {
            guard let rating = movie.voteAverage else {
                return Constants.General.kEMPTY_STRING
            }
            return String(rating)
        }
    }
    
    /// Returns movie release date
    var movieReleaseDate :String {
        get {
            guard let releaseDate = movie.releaseDate else {
                return Constants.General.kUNKNOWN_STRING
            }
            return Formatter.movieDisplayDateFormatter.string(from: releaseDate)
        }
    }
    
    /// Returns movie genres as a single string
    var movieGenres :String {
        get {
            guard let genresIds = movie.genreIds, genresIds.count > 0, let genres = genres else {
                return Constants.General.kUNKNOWN_STRING
            }
            return genres.getGenreForIDs(genresIds)
        }
    }
}
