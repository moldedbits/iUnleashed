//
//  QuizSubjectiveTableViewCell.swift
//  A-Lang
//
//  Created by Vishal Singh on 17/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class QuizSubjectiveTableViewCell: UITableViewCell {

    var textViewEditingHandler: ((String) -> ())!
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.delegate = self
            textView.layer.borderColor = UIColor.flatPlum.cgColor
            textView.layer.borderWidth = 1
        }
    }
}

extension QuizSubjectiveTableViewCell: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        textViewEditingHandler(textView.text)
    }
}
