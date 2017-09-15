//
//  PassageDetails.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct PassageDetails: Codable {
    
    var identifier: [PasssageDetailsCategory]?
    
    enum CodingKeys: String, CodingKey {
        case identifier
    }
}
