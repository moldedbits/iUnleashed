//
//  CategoryIdentifier.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct CategoryIdentifier: Codable {
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        
        case name
    }
}
