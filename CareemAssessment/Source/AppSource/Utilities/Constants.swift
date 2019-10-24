//  
//  Constants.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation

struct Constants {
    private init(){}
}

extension Constants {
    struct General {
        private init(){}
        static let API_KEY          = "b6f0b46a702ab3c3eb00dc63e3323372"
        
        static let kEMPTY_STRING    = ""
        static let kUNKNOWN_STRING  = "Unknown"
        
        static let kAPI_Key         = "api_key"
        static let kPage            = "page"
        static let kLanguage        = "language"
        static let kWITH_GENRES     = "with_genres"
        static let DEFAULT_PARAMS    = [
                                        Constants.General.kAPI_Key: Constants.General.API_KEY,
                                        Constants.General.kLanguage: NSLocale.preferredLanguages[0] as String
                                    ]
    }
}

/// Api end points
enum CAEndPoints : String {
    case base       = "http://api.themoviedb.org/3"
    case trending   = "/movie/popular"
    case genre      = "/genre/movie/list"
    
    /// - Source:  https://api.themoviedb.org/3/configuration?api_key=b6f0b46a702ab3c3eb00dc63e3323372
    case imageBase  = "http://image.tmdb.org/t/p/"
    
    /// Returns url string based on endpoint , appends base url if necessary
    var url : String {
        get {
            switch self {
            case .trending:
                return CAEndPoints.base.rawValue+self.rawValue
            case .genre:
                return CAEndPoints.base.rawValue+self.rawValue
            default:
                return self.rawValue
            }
        }
    }
}
