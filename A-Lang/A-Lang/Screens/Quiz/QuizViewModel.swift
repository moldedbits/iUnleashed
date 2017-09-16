//
//  QuizViewModel.swift
//  A-Lang
//
//  Created by Vishal Singh on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

struct QuizViewModel {

    var sectionModels: [QuizSectionModel] = []

    init(with questions: [Question]) {
        var sectionModels = [QuizSectionModel]()
        for question in questions {
            var cellModels = [QuizAnswerCellModel]()
            if question.questionType == .subjective {
                let item = QuizAnswerCellItem.subjective(text: "")
                let cellModel = QuizAnswerCellModel(with: item)
                cellModels.append(cellModel)
            } else if let options = question.options {
                for option in options {
                    let cellItem = QuizAnswerCellItem.multipleChoice(text: option)
                    let cellModel = QuizAnswerCellModel(with: cellItem)
                    cellModels.append(cellModel)
                }
            }
            let sectionItem = QuizSectionItem.question(question: question.questionText?.spanish ?? "- -", cellModels: cellModels)
            let sectionModel = QuizSectionModel(with: sectionItem, type: question.questionType)
            sectionModels.append(sectionModel)
        }

        self.sectionModels = sectionModels
    }
}

class QuizSectionModel {

    var item: QuizSectionItem!
    var type: QuestionType!
    var userAnswer: String?

    convenience init(with item: QuizSectionItem, type: QuestionType, answer: String? = nil) {
        self.init()

        userAnswer = answer
        self.item = item
        self.type = type
    }
}

enum QuizSectionItem {

    case question(question: String, cellModels: [QuizAnswerCellModel])

    var questionText: String {
        switch self {
        case let .question(question, _):
            return question
        }
    }

    var cellModels: [QuizAnswerCellModel] {
        switch self {
        case let .question( _, models):
            return models
        }
    }
}

class QuizAnswerCellModel {

    var isSelected: Bool = false
    var item: QuizAnswerCellItem!

    init(with item: QuizAnswerCellItem) {
        self.item = item
    }
}

enum QuizAnswerCellItem {

    case multipleChoice(text: String)
    case subjective(text: String)

    var text: String {
        switch self {
        case let .multipleChoice(text):
            return text
        case let .subjective(text):
            return text
        }
    }
}

enum QuestionType: String {

    case multipleChoice = "multiple_choice"
    case subjective = "free_text"
}
