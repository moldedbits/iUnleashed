//
//  Question.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct Question: Codable {
    
    var answerText: String?
    var questionText: QuestionText?
    var options: [Option]?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case questionText = "question_text"
        case options
        case type
        case answerText = "answer_text"
    }
}
