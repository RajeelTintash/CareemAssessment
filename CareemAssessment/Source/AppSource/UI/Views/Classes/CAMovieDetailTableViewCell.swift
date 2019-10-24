//
//  CAMovieDetailTableViewCell.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 23/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import UIKit

class CAMovieDetailTableViewCell: UITableViewCell {
    static let cellResueIdentifier                          = "CAMovieDetailTableViewCell"
    
    @IBOutlet private weak var movieTitleLabel          : UILabel!
    @IBOutlet private weak var movieRatingLabel         : UILabel!
    @IBOutlet private weak var movieReleaseDateLabel    : UILabel!
    @IBOutlet private weak var movieGenresLabel         : UILabel!
    @IBOutlet private weak var movieLanguageLabel       : UILabel!
    
    /// When set populates the cell ui with DTO
    var model :CAMovieDetailCellModel! {
        didSet {
            movieRatingLabel.set(image: #imageLiteral(resourceName: "yellowStar"), with: model.movieRating)
            movieTitleLabel.text        = model.movieTitle
            movieGenresLabel.text       = model.movieGenres
            movieLanguageLabel.text     = model.movieLanguage
            movieReleaseDateLabel.text  = model.movieReleaseDate
        }
    }
}
