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

    @IBOutlet weak var passageTextLabel: ActiveLabel!
    
    func configure(with model: PassageDetailsCellModel?) {
        passageTextLabel.text = model?.passageText
    }
}
