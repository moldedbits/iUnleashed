//
//  QuizMultipleChoiceCell.swift
//  A-Lang
//
//  Created by Vishal Singh on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class QuizMultipleChoiceCell: UITableViewCell {

    @IBOutlet weak var selectionButton: UIButton! {
        didSet {
            selectionButton.setImage(ThemeManager.fontAwesomeImage(fontAwesome: .dotCircleO, andSize: selectionButton.bounds.size), for: .selected)
            selectionButton.setImage(ThemeManager.fontAwesomeImage(fontAwesome: .circleO, andSize: selectionButton.bounds.size), for: .normal)
        }
    }
    @IBOutlet weak var optionLabel: UILabel!

    func configure(with model: QuizAnswerCellModel) {
        optionLabel.text = model.item.text
        selectionButton.isSelected = model.isSelected
    }
}
