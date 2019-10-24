//  
//  CAMoviesListViewModel.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation
import UIKit
class CAMoviesListViewModel {
    // Data Models
    fileprivate var model                   : CAMoviesListModel?
    private(set) var genres                 : CAGenresModel?
    fileprivate var filteredMovies          : [CAMovie]?
    
    // Current page received from the api
    fileprivate var currentPage             = 0
    
    // Filter checks
    var isFilteringGenre    : Bool          = false
    var isFilteringDate     : Bool          = false
    
    // Api success and failure callbacks trigger view controller to reload or show error alert
    var failure                             : ((String)->())?
    var success                             : (()->())?
    
    /// gets movie list for the view controller based on filtering or not
    var movieList : [CAMovie] {
        get {
            let isFiltering = isFilteringDate || isFilteringGenre
            if isFiltering {
                guard let movies    = filteredMovies else { return [] }
                return movies
            } else {
                guard let movies    = model?.movies else { return [] }
                return movies
            }
        }
    }
    
    // Tableview cell resue identifier
    fileprivate let identifier = CAMovieTableViewCell.cellResueIdentifier
}

extension CAMoviesListViewModel : CACellRegisterationProtocol {
    
    /// Registers xibs for tablview
    /// - Parameter tableView: tableview that needs the cells registered
    func registerCellsForTableView(tableView: UITableView?) {
        registerCellsTo(tableView: tableView, identifiers: [identifier])
    }
}

extension CAMoviesListViewModel: CAMoviesListService {
    
    /// Fetches genres if successfull calls fetch data
    func fetchGenres() {
        fetchGenres(success: {[weak self] genres in
        self?.genres = genres
        self?.fetchMovies()
        }, failure: { [weak self]  (error, errorString) in
            self?.apiFailed(error, errorString: errorString)
        })
    }
    
    /// Fetch Movie list based on current page
    func fetchMovies() {
        if !isFilteringDate , !isFilteringGenre {
            let currentPageGreaterThanZero = ((currentPage + 1) < model?.totalPages ?? 00)
            if currentPage == 0 {
                fetchMovies(success: { [weak self] (modelObj) in
                    guard let self      = self else { return }
                    self.model          = modelObj
                    self.currentPage    = modelObj.page ?? 0
                    self.success?()
                }, failure: { [weak self]  (error, errorString) in
                    self?.apiFailed(error, errorString: errorString)
                })
            } else if currentPageGreaterThanZero {
                fetchMoviesForNextPage(currentPage + 1, success: { [weak self] (modelObj) in
                    guard let self      = self else { return }
                    self.model?.movies?.append(contentsOf: modelObj.movies ?? [])
                    self.currentPage    = modelObj.page ?? 0
                    self.success?()
                }, failure: { [weak self]  (error, errorString) in
                    self?.apiFailed(error, errorString: errorString)
                })
            }
        }
    }
}

//MARK:- Date Filtering
extension CAMoviesListViewModel {
    
    /// Filters movies based on date
    /// - Parameter date: Date selected from date picker
    func filterMoviesBasedOnDate(_ date:Date) {
        isFilteringDate     = true
        guard let movies    = model?.movies else {
            filteredMovies  = []
            success?()
            return
        }
        let dateWithTimeRemoved = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: date))
        filteredMovies = movies.filter{$0.releaseDate == dateWithTimeRemoved}
        success?()
    }
    
    /// Clears any applied filters
    func clearFilters() {
        isFilteringDate     = false
        isFilteringGenre    = false
        success?()
    }
    
    /// Calls api to fetch movies based on selected genre
    /// - Parameter selectedRow: Index path of selected row
    func filterBasedOnGenres(_ selectedRow:Int) {
        isFilteringGenre    = true
        guard let genreID   = genres?.genres[selectedRow].id else {
            filteredMovies  = []
            success?()
            return
        }
        fetchMoviesForGenres(genreID, success: {[weak self] modelObj in
            self?.filteredMovies = modelObj.movies
            self?.success?()
        }, failure: { [weak self]  (error, errorString) in
            self?.apiFailed(error, errorString: errorString)
        })
    }
}

extension CAMoviesListViewModel {
    
    /// Called when an api fails to let the viewcontroller display an alert
    /// - Parameter error: ErrorModel if an api call returned and error
    /// - Parameter errorString: general error string could be returned from network layer
    fileprivate func apiFailed(_ error:ErrorModel?, errorString:String?) {
        guard let error     = error else {
            guard let errorString = errorString else {
                 self.failure?("Api Error")
                return
            }
            self.failure?(errorString)
            return
        }
        self.failure?(error.statusMessage)
    }
}
