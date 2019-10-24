//
//  CAMovieDetailCellModel.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 23/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation

/// This is the DTO for the movie detail cell in CAMovieDetailViewController
struct CAMovieDetailCellModel {
    
    fileprivate let movie : CAMovie
    fileprivate let genres: CAGenresModel?
    
    init(_ movie :CAMovie, genres:CAGenresModel?) {
        self.movie  = movie
        self.genres = genres
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
            guard let genresIds = movie.genreIds,
                genresIds.count > 0,
                let genres = genres else {
                return Constants.General.kUNKNOWN_STRING
            }
            return genres.getGenreForIDs(genresIds)
        }
    }
    
    /// Returns the movie language from locale display name
    var movieLanguage : String? {
        get {
            guard let movieLanguage = movie.originalLanguage else {
                return Constants.General.kEMPTY_STRING
            }
            let locale = NSLocale.current as NSLocale
            return locale.displayName(forKey: .languageCode, value: movieLanguage)
        }
    }
}
