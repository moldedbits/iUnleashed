//
//  ThemeManager.swift
//  A-Lang
//
//  Created by Vishal Singh on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import ChameleonFramework
import FontAwesome_swift

struct ThemeManager {

    static let cardSize = UIScreen.main.bounds.width / 1.5

    struct ThemeColor {
        static let whiteDark = FlatWhiteDark()
        static let whiteDarkContrast = ContrastColorOf(FlatWhiteDark(), returnFlat: true)

        static let redDark = FlatRedDark()
        static let redDarkContrast = ContrastColorOf(FlatRedDark(), returnFlat: true)

        static let brownDark = FlatBrownDark()

        static let yellowDark = FlatYellowDark()

        static let categoryOverviewBackground = FlatPlum()
        static let categoryOverviewBack = FlatLime()
        static let categoryOverviewFront = FlatSkyBlue()
    }

    struct AwesomeFont {
        static let addressCard = FontAwesome.addressCard
    }

    struct FontSize {
        static let verySmall = CGFloat(12.0)
        static let small = CGFloat(14.0)
        static let medium = CGFloat(16.0)
        static let normal = CGFloat(18.0)
        static let large = CGFloat(24.0)
        static let extraLarge = CGFloat(32.0)
    }

    static func fontAwesomeOfSize(_ size: CGFloat) -> UIFont {
        return UIFont.fontAwesome(ofSize: size)
    }

    static func stringFor(_ fontAwesome: FontAwesome) -> String {
        return String.fontAwesomeIcon(name: fontAwesome)
    }

    static func contrastColor(of color: UIColor) -> UIColor {
        return ContrastColorOf(color, returnFlat: true)
    }

    static func fontAwesomeImage(fontAwesome: FontAwesome, with color: UIColor = FlatTealDark(), andSize size: CGSize = CGSize(width: 100, height: 100)) -> UIImage {
        return UIImage.fontAwesomeIcon(name: fontAwesome, textColor: color, size: size)
    }

    static func gradientColor(with style: UIGradientStyle, and frame: CGRect, andColors colors: [UIColor]) -> UIColor {
        return UIColor(gradientStyle: style, withFrame: frame, andColors: colors)
    }

    static func extractColorsFrom(_ image: UIImage) -> [UIColor] {
        let averageColor = AverageColorFromImage(image)
        let contrastColor = ContrastColorOf(averageColor, returnFlat: true)

        return [contrastColor, averageColor]
    }
}
