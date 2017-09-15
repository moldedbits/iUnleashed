//
//  Category.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Category: Codable {
    
    var identifier: [CategoryIdentifier]?
    
    enum CodingKeys: String, CodingKey {
        case identifier
    }
}
