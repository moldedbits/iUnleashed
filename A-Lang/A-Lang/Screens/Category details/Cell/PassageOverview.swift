//
//  PassageOverview.swift
//  A-Lang
//
//  Created by Vishal Singh on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import FoldingCell

class PassageOverview: FoldingCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        foregroundView.backgroundColor = ThemeManager.ThemeColor.categoryOverviewFront
        containerView.backgroundColor = ThemeManager.ThemeColor.categoryOverviewBack
    }

    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        return [0.33, 0.25][itemIndex]
    }
    
}
