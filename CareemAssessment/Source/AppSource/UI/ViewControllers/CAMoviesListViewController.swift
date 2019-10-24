//  
//  CAMoviesListViewController.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation
import UIKit

class CAMoviesListViewController : UIViewController {
    
    var viewModel                                           = CAMoviesListViewModel()
    @IBOutlet private weak var tableView                    : UITableView!
    
    @IBOutlet private weak var datePickerBottomConstraint   : NSLayoutConstraint!
    @IBOutlet private weak var datePicker                   : CADatePickerView!
    
    @IBOutlet private weak var genrePickerBottomConstraint  : NSLayoutConstraint!
    @IBOutlet private weak var genrePicker                  : CAGenrePickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}


extension CAMoviesListViewController {
    
    /// Sets the view title nav buttons and calls other setup functions
    fileprivate func setupView() {
        self.title = "Movies"
        navigationItem.rightBarButtonItem   = UIBarButtonItem(title: "Date Filter", style: .plain, target: self, action:#selector(dateFilterPressed))
        navigationItem.leftBarButtonItem    = UIBarButtonItem(title: "Genre Filter", style: .plain, target: self, action:#selector(genreFilterPressed))
        setupPickerCallBacks()
        setUpViewModel()
    }
    
    /// Registers tableview cell, sets up view model call backs and calls api
    fileprivate func setUpViewModel() {
        viewModel.registerCellsForTableView(tableView: tableView)
        viewModel.fetchGenres()
        
        viewModel.success = { [weak self] in
            self?.reloadTableView()
        }
        
        viewModel.failure = { [weak self] error in
            self?.displayError(error)
        }
    }
    
    /// Setup the genre and date picker along with their callbacks
    fileprivate func setupPickerCallBacks() {
        datePicker.cancelPressed = { [weak self] in
            self?.hideDatePicker()
        }
        
        datePicker.donePressed = { [weak self] date in
            self?.navigationItem.rightBarButtonItem?.title = "Clear Filter"
            self?.viewModel.filterMoviesBasedOnDate(date)
            self?.hideDatePicker()
        }
        
        genrePicker.cancelPressed = { [weak self] in
            self?.hideGenrePicker()
        }
        
        genrePicker.donePressed = { [weak self] selectedRow in
            self?.navigationItem.leftBarButtonItem?.title = "Clear Filter"
            self?.viewModel.filterBasedOnGenres(selectedRow)
            self?.hideGenrePicker()
        }
    }
}


extension CAMoviesListViewController {
    
    
    /// Displays and alert view on main thread in case their is an error adds a retry button to refetch the api
    /// - Parameter errorString: error string to display in the alert
    fileprivate func displayError(_ errorString: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] (action) in
                self?.viewModel.fetchGenres()
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    /// Reloads the tableview on main thread
    fileprivate func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

//MARK:- UITableView DataSource
extension CAMoviesListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: CAMovieTableViewCell.cellResueIdentifier) as? CAMovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = viewModel.movieList[indexPath.row]
        movieCell.movieCellModel = CAMovieListCellModel(movie, genres: viewModel.genres)
        return movieCell
    }
}

//MARK:- UITableView Delegate
extension CAMoviesListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movieList.count - 1 {
            viewModel.fetchMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movieList[indexPath.row]
        let movieDetail = CAMoviesDetailModel(movie, genres: viewModel.genres)
        guard let movieDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CAMoviesDetailViewController") as? CAMoviesDetailViewController else { return }
        movieDetailViewController.viewModel.model = movieDetail
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

//MARK:- Date Filter
extension CAMoviesListViewController {
    
    /// Date filter button pressed. Clears filter if already filtering and hides any other picker showing
    @objc func dateFilterPressed() {
        if viewModel.isFilteringGenre {
            viewModel.clearFilters()
            navigationItem.leftBarButtonItem?.title = "Genre Filter"
        }
        genrePickerBottomConstraint.constant = -260
        if viewModel.isFilteringDate {
            viewModel.clearFilters()
            navigationItem.rightBarButtonItem?.title = "Date Filter"
            return
        }
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.datePickerBottomConstraint.constant = 0
            self?.view.layoutIfNeeded()
        })
    }
    
    /// Hides the date picker
    func hideDatePicker() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, animations: { [weak self] in
                self?.datePickerBottomConstraint.constant = -260
                self?.view.layoutIfNeeded()
            })
        }
    }
}

//MARK:- Genre Filter
extension CAMoviesListViewController {
    
    
    /// Genre filter button pressed. Clears filter if already filtering and hides any other picker showing
    @objc func genreFilterPressed() {
        if viewModel.isFilteringDate {
            viewModel.clearFilters()
            navigationItem.rightBarButtonItem?.title = "Date Filter"
        }
        datePickerBottomConstraint.constant = -260
        if viewModel.isFilteringGenre {
            viewModel.clearFilters()
            navigationItem.leftBarButtonItem?.title = "Genre Filter"
            return
        }
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.genrePickerBottomConstraint.constant = 0
            self?.view.layoutIfNeeded()
        })
        guard let genre = viewModel.genres else {
            hideGenrePicker()
            return
        }
        genrePicker.setGenres(genre.genres)
        genrePicker.genrePicker.reloadAllComponents()
    }
    
    /// Hides genre picker
    func hideGenrePicker() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, animations: { [weak self] in
                self?.genrePickerBottomConstraint.constant = -260
                self?.view.layoutIfNeeded()
            })
        }
    }
}
