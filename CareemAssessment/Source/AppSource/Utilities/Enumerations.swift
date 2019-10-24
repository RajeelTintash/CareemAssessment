//  
//  Enumerations.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation

/// Http request type
enum RequestType : String {
    case get        = "GET"
    case post       = "POST"
    case put        = "PUT"
    case patch      = "PATCH"
    case delete     = "DELETE"
}

/// Poster aizes available from the configuration APi
/// - Source:  https://api.themoviedb.org/3/configuration?api_key=b6f0b46a702ab3c3eb00dc63e3323372
enum PosterSizes : String {
    case w92        = "w92"
    case w154       = "w154"
    case w185       = "w185"
    case w342       = "w342"
    case w500       = "w500"
    case w780       = "w780"
    case original   = "original"
}

/// Back drop sizes available from the configuration APi
/// - Source:  https://api.themoviedb.org/3/configuration?api_key=b6f0b46a702ab3c3eb00dc63e3323372
enum BackDropSizes : String {
    case w300       = "w300"
    case w780       = "w780"
    case w1280      = "w1280"
    case original   = "original"
}
