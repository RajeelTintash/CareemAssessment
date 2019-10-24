//
//  CAMovieTableViewCell.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 22/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import UIKit

class CAMovieTableViewCell: UITableViewCell {

    static let cellResueIdentifier                      = "CAMovieTableViewCell"
    @IBOutlet private weak var moviePosterImageView     : UIImageView!
    @IBOutlet private weak var movieTitleLabel          : UILabel!
    @IBOutlet private weak var movieRatingLabel         : UILabel!
    @IBOutlet private weak var movieReleaseDateLabel    : UILabel!
    @IBOutlet private weak var movieGenresLabel         : UILabel!
    
    /// Populates the cell UI elements when set
    var movieCellModel :CAMovieListCellModel! {
        didSet {
            movieTitleLabel.text        = movieCellModel.movieTitle
            movieRatingLabel.set(image: #imageLiteral(resourceName: "yellowStar"), with: movieCellModel.movieRating)
            movieReleaseDateLabel.text  = movieCellModel.movieReleaseDate
            movieGenresLabel.text       = movieCellModel.movieGenres
            guard let url               = movieCellModel.moviePosterURL else {
                return
            }
            moviePosterImageView.setImageFromCacheOrDownload(url, placeholderImage: #imageLiteral(resourceName: "moviePlaceholder"))
        }
    }
}
