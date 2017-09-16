//
//  PassageIdentifier.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import ObjectMapper

class Passage: Mappable {

    var categoryName: String!
    var difficulty: String?
    var displayName: BilingualText?
    
    required convenience init?(map : Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        difficulty <- map["difficulty"]
        displayName <- map["display_name"]
    }
}
