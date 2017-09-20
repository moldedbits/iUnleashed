//
//  Option.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Option: Codable {
    
    var identifier: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier
    }
}
