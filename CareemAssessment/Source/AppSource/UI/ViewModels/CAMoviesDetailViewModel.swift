//
//  CAMoviesDetailViewModel.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 23/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation
import UIKit
class CAMoviesDetailViewModel : CACellRegisterationProtocol {
    
    var model                   : CAMoviesDetailModel?
    
    /// Cell reuse identifiers of the tablview cells
    fileprivate let identifiers : [String] = [
        CAMovieBackDropTableViewCell.cellResueIdentifier,
        CAMovieDetailTableViewCell.cellResueIdentifier,
        CAMovieOverViewTableViewCell.cellResueIdentifier
    ]
    
    /// Registers xibs for tablview
    /// - Parameter tableView: tableview that needs the cells registered
    func registerCellsForTableView(tableView: UITableView?) {
        registerCellsTo(tableView: tableView, identifiers: identifiers)
    }
}
