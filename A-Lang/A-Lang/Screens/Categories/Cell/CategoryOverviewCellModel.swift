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
    var isOpen = false
    var type: CategoryOverviewType!

    init(with category: Category) {
        name = category.name
        type = CategoryOverviewType(rawValue: name) ?? CategoryOverviewType.unknown
    }
}

enum CategoryOverviewType: String {

    case travel = "Travel"
    case relationships = "Relationships"
    case introduction = "Introduction"
    case work = "Work"
    case unknown

    var image: UIImage {
        // TODO:- multiple images can be added for single category and random image can be picked
        switch self {
        case .travel: return #imageLiteral(resourceName: "travel")
        case .introduction: return #imageLiteral(resourceName: "introduction")
        case .work: return #imageLiteral(resourceName: "work")
        case .relationships: return #imageLiteral(resourceName: "relationships")
        default: return UIImage()
        }
    }

    var textColor: UIColor {
        return gradientColors.first ?? frontAndBackColor.1
    }

    var frontAndBackColor: (UIColor, UIColor) {
        return (ThemeManager.ThemeColor.categoryOverviewFront, ThemeManager.ThemeColor.categoryOverviewBack)
    }

    var gradientColors: [UIColor] {
        return ThemeManager.extractColorsFrom(image)
    }
}
