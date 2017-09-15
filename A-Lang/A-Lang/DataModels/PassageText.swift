//
//  PassageText.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct PassageText: Codable {
    
    var english: String?
    var spanish: String?
    
    enum CodingKeys: String, CodingKey {
        case english
        case spanish
    }
}
