//
//  Question.swift
//  A-Lang
//
//  Created by sumit saini on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import ObjectMapper

class Question: Mappable {
    
    var answerText: String?
    var questionText: BilingualText?
    var options: [String]?
    var type: String?
    var questionType: QuestionType!
    
    required convenience init?(map : Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        answerText <- map["answer_text"]
        questionText <- map["question_text"]
        options <- map["options"]
        type <- map["type"]
        questionType = QuestionType(rawValue: type) ?? QuestionType.multipleChoice
    }
}
