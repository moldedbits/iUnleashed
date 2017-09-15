//
//  PassageCategory.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct PasssageCategory: Codable {
    
    var identifier: [PassageIdentifier]?
    
    enum CodingKeys: String, CodingKey {
        case identifier
    }
}
