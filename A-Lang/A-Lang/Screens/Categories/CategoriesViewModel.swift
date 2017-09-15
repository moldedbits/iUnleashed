//
//  CategoriesViewModel.swift
//  A-Lang
//
//  Created by Vishal Singh on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation

struct CategoriesViewModel {

    var categories: [Category]!
    var categoryModels: [CategoryOverviewCellModel]!

    init(with categories: [Category]) {
        self.categories = categories
        categoryModels = categories.map { CategoryOverviewCellModel(with: $0) }
    }
}
