//
//  DisplayName.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import ObjectMapper

class DisplayName: Mappable {
    
    var english: String?
    var spanish: String?
    
    required convenience init?(map : Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        english <- map["english"]
        spanish <- map["spanish"]
    }
}
