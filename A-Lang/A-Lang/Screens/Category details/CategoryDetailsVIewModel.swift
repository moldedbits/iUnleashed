//
//  CategoryDetailsVIewModel.swift
//  A-Lang
//
//  Created by Vishal Singh on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import UIKit

let kClosedCellHeight: CGFloat = 44.0
let kCloseCellDuration = 0.25
let kOpenCellHeight: CGFloat = 88.0
let kOpenCellDuration = 0.33

struct CellHeight {
    static let close: CGFloat = kClosedCellHeight // equal or greater foregroundView height
    static let open: CGFloat = kOpenCellHeight // equal or greater containerView height
}

struct CategoryDetailViewModel {

    var cellHeights: [CGFloat]!

    var title: String!
    var passages: [Passage]!
    var cellModels: [PassageOverviewCellModel]!

    init(with title: String, and passages: [Passage]) {
        self.title = title
        self.passages = passages
        cellHeights = (0..<passages.count).map { _ in CellHeight.close }
        self.cellModels = self.passages.map { PassageOverviewCellModel(with: $0) }

            //, andPassageText: "Some very very long text in spanish. This will be truncated. Some very very long text in spanish. This will be truncated. Some very very long text in spanish. This will be truncated. Some very very long text in spanish. This will be truncated.") }
    }

    static func dummy(with title: String) -> CategoryDetailViewModel {
        var passages = [Passage]()
        for _ in 0...7 {
            let passage = Passage(JSON: [:])!
            passage.displayName = BilingualText(JSON: [:])
            passage.difficulty = "easy"
            passages.append(passage)
        }

        return CategoryDetailViewModel(with: title, and: passages)
    }
}
