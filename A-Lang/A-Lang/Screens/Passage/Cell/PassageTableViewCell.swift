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

    @IBOutlet weak var passageTextLabel: ActiveLabel! //{
//        didSet {
//            passageTextLabel.enabledTypes = [.url]
//            passageTextLabel.handleURLTap() { url in
//            }
//        }
//    }
    
    func configure(with model: PassageDetailsCellModel?) {
        passageTextLabel.text = model?.passageText
        createTappableSentences(model?.sentences)
    }
    
    func createTappableSentences(_ sentences: [BilingualText]?) {
        guard let sentences = sentences else { return }
        for sentence in sentences {
            let customURL = ActiveType.custom(pattern: "\(sentence.spanish ?? "")")
            passageTextLabel.enabledTypes = [.mention, .hashtag, .url, customURL]
            
//            passageTextLabel.text = sentence.spanish ?? ""
            passageTextLabel.customColor[customURL] = UIColor.purple
            passageTextLabel.customSelectedColor[customURL] = UIColor.green
            passageTextLabel.handleCustomTap(for: customURL) { element in
                print("Custom type tapped: \(element)")
            }
        }
    }
}
