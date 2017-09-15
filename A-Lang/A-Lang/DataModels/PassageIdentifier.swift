//
//  PassageIdentifier.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct PassageIdentifier: Codable {
    var difficulty: String?
    var displayName: DisplayName?
    
    
    enum CodingKeys: String, CodingKey {
        
        case difficulty
        case displayName = "display_name"
    }
}
