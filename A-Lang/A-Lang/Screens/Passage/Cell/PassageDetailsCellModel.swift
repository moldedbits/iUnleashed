//
//  PassageDetailsCellModel.swift
//  A-Lang
//
//  Created by Saurabh Gupta on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct PassageDetailsCellModel {
    
    var sentences: [BilingualText]!
    var passageText: String!
    
    init(with sentences: [BilingualText], andPassageText spanishText: String) {
        self.sentences = sentences
        passageText = spanishText
    }
}
