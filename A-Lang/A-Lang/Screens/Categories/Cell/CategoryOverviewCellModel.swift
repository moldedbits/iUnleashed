//
//  CategoryOverviewCellModel.swift
//  A-Lang
//
//  Created by Vishal Singh on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

struct CategoryOverviewCellModel {

    var name: String!
    var type: CategoryOverviewType!

    init(with category: Category) {
        name = category.name
        type = CategoryOverviewType(rawValue: name) ?? CategoryOverviewType.unknown
    }
}

enum CategoryOverviewType: String {

    case travel
    case relationship
    case introduction
    case work
    case unknown

    var image: UIImage {
        switch self {
        case .travel: return #imageLiteral(resourceName: "travel")
        default: return UIImage()
        }
    }

    var textColor: UIColor {
        return ThemeManager.contrastColor(of: frontAndBackColor.0)
    }

    var frontAndBackColor: (UIColor, UIColor) {
        return (ThemeManager.ThemeColor.categoryOverviewFront, ThemeManager.ThemeColor.categoryOverviewBack)
    }

    var gradientColors: [UIColor] {
        return ThemeManager.extractColorsFrom(image)
    }
}
