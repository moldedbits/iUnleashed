//
//  CategoryOverviewCell.swift
//  A-Lang
//
//  Created by Vishal Singh on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import expanding_collection

class CategoryOverviewCell: BasePageCollectionCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var customTitle: UILabel!
    @IBOutlet weak var numberOfPassagesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        customTitle.layer.shadowRadius = 2
        customTitle.layer.shadowOffset = CGSize(width: 0, height: 3)
        customTitle.layer.shadowOpacity = 0.2
    }

    func configure(with model: CategoryOverviewCellModel) {
        let backgroundColors = model.type.frontAndBackColor
        frontContainerView.backgroundColor = backgroundColors.0

        backgroundImageView.image = model.type.image

        customTitle.text = model.name
        customTitle.textColor = model.type.textColor

        numberOfPassagesLabel.textColor = model.type.gradientColors.last
        backContainerView.backgroundColor = model.type.gradientColors.first
    }
}
