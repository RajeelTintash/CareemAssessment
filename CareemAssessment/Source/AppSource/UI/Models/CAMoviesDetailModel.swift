//
//  CAMoviesDetailModel.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 23/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation

/// This is the DTO for CAMovieDetailViewController populates the backdrop url, overview and movie detail cell DTO
struct CAMoviesDetailModel {
    fileprivate let movie   :CAMovie
    fileprivate let genres  : CAGenresModel?
    
    init(_ movie :CAMovie, genres:CAGenresModel?) {
        self.movie  = movie
        self.genres = genres
    }
    
    /// Returns backdrop url
    var movieBackDropURL :URL? {
        get {
            guard let backDropPath = movie.backdropPath else {
                return URL(string: Constants.General.kEMPTY_STRING)
            }
            
            return URL(string: CAEndPoints.imageBase.url+BackDropSizes.w780.rawValue+"/"+backDropPath)
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
    
    /// Returns the movie detail cell DTO for movie detail cell
    var movieDetailCellModel :CAMovieDetailCellModel {
        get {
            return CAMovieDetailCellModel(movie, genres: genres)
        }
    }
    
    /// Returns movie overview for overview cell
    var movieOverView :String {
        get {
            guard let overView = movie.overview else {
                return Constants.General.kEMPTY_STRING
            }
            return overView
        }
    }
}
