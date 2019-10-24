
//  
//  ErrorModel.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation

struct ErrorModel: Codable {
    let statusMessage           :String
    let statusCode              :String
    
    enum CodingKeys: String, CodingKey {
        case statusMessage      = "status_message"
        case statusCode         = "status_code"
    }
}
