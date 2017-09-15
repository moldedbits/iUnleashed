//
//  Category.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import ObjectMapper

class Category: Mappable {
    
    var name: String?
    var passages: [Passage]?
    
    required convenience init?(map : Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        passages <- map["passages"]
    }
}
