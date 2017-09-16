//
//  PassageOverviewCelllModel.swift
//  A-Lang
//
//  Created by Vishal Singh on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

struct PassageOverviewCellModel {

    var displayName: String!
    var textPreview: String!
    var difficulty: ThemeManager.PassageDifficulty!
    var displayNameTextColor: UIColor {
        return difficulty.color1Contrast
    }
    var displayColor: UIColor {
        return difficulty.color1
    }
    var previewTextColor: UIColor {
        return difficulty.color2Contrast
    }
    var previewBackgroundColor: UIColor {
        return difficulty.color2
    }

    init(with passage: Passage, andPassageText text: String) {
        displayName = passage.displayName?.english ?? " - - "
        textPreview = text
        difficulty = ThemeManager.PassageDifficulty(rawValue: passage.difficulty ?? "") ?? ThemeManager.PassageDifficulty.absoluteBeginner
    }
}

