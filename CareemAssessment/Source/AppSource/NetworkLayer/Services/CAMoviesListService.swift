//  
//  CAMoviesListService.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation


import Foundation

/// Conform CAMovieListViewModel conforms to this protocol to fetch data
protocol CAMoviesListService: NetworkProtocol {}

extension CAMoviesListService {
    
    /// Fetches the genre list
    /// - Parameter success: success block returns CAGenresModel
    /// - Parameter failure: failure block returns ErrorModel and errorString
    func fetchGenres(success: ((CAGenresModel)->())?, failure: ((ErrorModel?,String?)->())?) {
        makeRequest(CAEndPoints.genre.url, .get, nil, Constants.General.DEFAULT_PARAMS, success: success, failure: failure)
    }
    
    /// Fetches the movies list
    /// - Parameter success: success block returns CAMoviesListModel
    /// - Parameter failure: failure block returns ErrorModel and errorString
    func fetchMovies(success: ((CAMoviesListModel)->())?, failure: ((ErrorModel?,String?)->())?) {
        makeRequest(CAEndPoints.trending.url, .get, nil, Constants.General.DEFAULT_PARAMS, success: success, failure: failure)
    }
    
    /// fetches the movies list for given genre id
    /// - Parameter genreID: genre id
    /// - Parameter success: success block returns CAMoviesListModel
    /// - Parameter failure: failure block returns ErrorModel and errorString
    func fetchMoviesForGenres(_ genreID:Int, success: ((CAMoviesListModel)->())?, failure: ((ErrorModel?,String?)->())?) {
        var params = [ Constants.General.kWITH_GENRES : String(genreID) ]
        params = params.merging(Constants.General.DEFAULT_PARAMS ) { $1 }
        makeRequest(CAEndPoints.trending.url, .get, nil, params, success: success, failure: failure)
    }
    
    /// fetches the page for page number provided
    /// - Parameter page: page number to fetch
    /// - Parameter success: success block returns CAMoviesListModel
    /// - Parameter failure: failure block returns ErrorModel and errorString
    func fetchMoviesForNextPage(_ page: Int, success: ((CAMoviesListModel)->())?, failure: ((ErrorModel?,String?)->())?) {
        var params = [ Constants.General.kPage : String(page) ]
        params = params.merging(Constants.General.DEFAULT_PARAMS ) { $1 }
        makeRequest(CAEndPoints.trending.url, .get, nil, params, success: success, failure: failure)
    }
}

