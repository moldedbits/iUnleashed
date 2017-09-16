//
//  PassageDetailViewModel.swift
//  A-Lang
//
//  Created by Saurabh Gupta on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct PassageDetailViewModel {
    var passageText: String!
    var sentences: [BilingualText]!
    var passage: Passage!
    
    init(with passage: Passage) {
//        passageText = passage.text
//        sentences = passage.sentences
    }
    
}
