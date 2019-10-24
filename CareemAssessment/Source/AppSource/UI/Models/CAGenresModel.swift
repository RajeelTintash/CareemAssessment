//
//  CAGenresModel.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 22/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation

struct CAGenresModel    : Codable {
    let genres          : [Genre]
    
    func getGenreForIDs(_ genreIds:[Int]) -> String {
        var genresString    = Constants.General.kEMPTY_STRING
        
        let genreIdSet      = Set(genreIds.lazy.map{$0})
        let filteredArray   = genres.filter{genreIdSet.contains($0.id)}
        
        let genreNameSet    = Set(filteredArray.lazy.map{$0.name})
        let genreArray      = Array(genreNameSet)
        
        genresString        = genreArray.joined(separator:", ")
        return genresString
    }
}

struct Genre    : Codable {
    let id      : Int
    let name    : String
}
