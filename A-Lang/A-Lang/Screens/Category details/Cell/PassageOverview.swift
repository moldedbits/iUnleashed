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

    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var bottomArrowImageView: UIImageView!
    @IBOutlet weak var textPreviewLabel: UILabel!
    @IBOutlet weak var upwardsArrowImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        foregroundView.backgroundColor = ThemeManager.ThemeColor.categoryOverviewFront
        containerView.backgroundColor = ThemeManager.ThemeColor.categoryOverviewBack
    }

    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        return [0.33, 0.25][itemIndex]
    }

    func configure(with model: PassageOverviewCellModel) {
        foregroundView.backgroundColor = model.displayColor
        containerView.backgroundColor = model.previewBackgroundColor

        displayNameLabel.text = model.displayName
        displayNameLabel.textColor = model.displayNameTextColor

        textPreviewLabel.text = model.textPreview
        textPreviewLabel.textColor = model.previewTextColor

        bottomArrowImageView.image = ThemeManager.fontAwesomeImage(fontAwesome: .chevronDown, with: model.displayNameTextColor, andSize: bottomArrowImageView.bounds.size)
        upwardsArrowImageView.image = ThemeManager.fontAwesomeImage(fontAwesome: .chevronUp, with: model.previewTextColor, andSize: upwardsArrowImageView.bounds.size)
    }
}
