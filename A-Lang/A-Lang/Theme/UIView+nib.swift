//
//  UIView+nib.swift
//  A-Lang
//
//  Created by Vishal Singh on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

extension UIView {

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    class func loadFromNib() -> UIView? {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? UIView
    }
}
