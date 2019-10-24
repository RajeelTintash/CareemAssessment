//
//  CAMovieBackDropTableViewCell.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 23/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import UIKit

class CAMovieBackDropTableViewCell: UITableViewCell {
    static let cellResueIdentifier                          = "CAMovieBackDropTableViewCell"
    
    @IBOutlet private weak var movieBackDropImageView       : UIImageView!
    
    /// When set populates backdrop image view
    var backDropURL : URL? {
        didSet {
            guard let backDropURL = backDropURL else {
                movieBackDropImageView.image = #imageLiteral(resourceName: "moviePlaceholder")
                return
            }
            movieBackDropImageView.setImageFromCacheOrDownload(backDropURL, placeholderImage: #imageLiteral(resourceName: "moviePlaceholder"))
        }
    }
}
