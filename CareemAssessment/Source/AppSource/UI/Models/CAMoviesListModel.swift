//  
//  CAMoviesListModel.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation

struct CAMoviesListModel: Codable {
    let page                    : Int?
    let totalResults            : Int?
    let totalPages              : Int?
    var movies                  : [CAMovie]?
    
    enum CodingKeys: String, CodingKey {
        case page, totalResults, totalPages
        case movies             = "results"
    }
}

struct CAMovie: Codable {
    let popularity              : Double?
    let id                      : Int?
    let video                   : Bool?
    let voteCount               : Int?
    let voteAverage             : Double?
    let title                   : String?
    let releaseDate             : Date?
    let originalLanguage        : String?
    let originalTitle           : String?
    let genreIds                : [Int]?
    let backdropPath            : String?
    let adult                   : Bool?
    let overview                : String?
    let posterPath              : String?
}
