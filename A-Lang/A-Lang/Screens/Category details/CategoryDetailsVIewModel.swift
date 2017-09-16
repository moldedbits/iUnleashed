//
//  CategoryDetailsVIewModel.swift
//  A-Lang
//
//  Created by Vishal Singh on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import UIKit

let kCloseCellHeight: CGFloat = 44.0
let kOpenCellHeight: CGFloat = 88.0

struct CellHeight {
    static let close: CGFloat = kCloseCellHeight // equal or greater foregroundView height
    static let open: CGFloat = kOpenCellHeight // equal or greater containerView height
}

struct CategoryDetailViewModel {

    var cellHeights: [CGFloat]!

    var title: String!
    var passages: [Passage]!

    init(with title: String, and passages: [Passage]) {
        self.title = title
        self.passages = passages
        cellHeights = (0..<passages.count).map { _ in CellHeight.close }
    }

    static func dummy(with title: String) -> CategoryDetailViewModel {
        var passages = [Passage]()
        for i in 0...7 {
            let passage = Passage(JSON: [:])!
            passage.displayName = BilingualText(JSON: [:])
            passage.difficulty = "easy"
            passages.append(passage)
        }

        return CategoryDetailViewModel(with: title, and: passages)
    }
}
