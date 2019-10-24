//
//  CAMoviesDetailViewController.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 23/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import UIKit

class CAMoviesDetailViewController: UIViewController {

    @IBOutlet private weak var tableView    : UITableView!
    var viewModel                           = CAMoviesDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension CAMoviesDetailViewController {
    
    /// Sets the view title , registers the tablview xib and reloads the data
    fileprivate func setupView() {
        title = viewModel.model?.movieTitle ?? Constants.General.kEMPTY_STRING
        viewModel.registerCellsForTableView(tableView: tableView)
        reloadTableView()
    }
    
    /// Reloads the tableview on main thread
    fileprivate func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

//MARK:- UITableViewDataSource
extension CAMoviesDetailViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let backDropCell = tableView.dequeueReusableCell(withIdentifier: CAMovieBackDropTableViewCell.cellResueIdentifier) as? CAMovieBackDropTableViewCell else {
                return UITableViewCell()
            }
            backDropCell.backDropURL = viewModel.model?.movieBackDropURL
            return backDropCell
        case 1:
            guard let detailCell = tableView.dequeueReusableCell(withIdentifier: CAMovieDetailTableViewCell.cellResueIdentifier) as? CAMovieDetailTableViewCell else {
                return UITableViewCell()
            }
            detailCell.model = viewModel.model?.movieDetailCellModel
            return detailCell
            
        case 2:
            guard let overViewCell = tableView.dequeueReusableCell(withIdentifier: CAMovieOverViewTableViewCell.cellResueIdentifier) as? CAMovieOverViewTableViewCell else {
                return UITableViewCell()
            }
            overViewCell.overView = viewModel.model?.movieOverView
            return overViewCell
            
        default:
            return UITableViewCell()
        }
    }
}
