//
//  PassageTableViewCell.swift
//  A-Lang
//
//  Created by Saurabh Gupta on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import ActiveLabel

class PassageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var passageTextLabel: ActiveLabel!
    
    func configure(with model: PassageDetailViewModel) {
        passageTextLabel.text = model.passageText
    }
}
