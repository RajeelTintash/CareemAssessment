//
//  CAMovieOverViewTableViewCell.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 23/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import UIKit

class CAMovieOverViewTableViewCell: UITableViewCell {
    static let cellResueIdentifier                          = "CAMovieOverViewTableViewCell"
    
    @IBOutlet private weak var movieOverViewLabel           : UILabel!
    
    /// Populates the overview label when set
    var overView : String! {
        didSet {
            movieOverViewLabel.text = overView
        }
    }
}
