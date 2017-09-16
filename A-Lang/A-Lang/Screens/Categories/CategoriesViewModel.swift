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
        categoryModels = self.categories.map { CategoryOverviewCellModel(with: $0) }
    }

    static func dummy() -> CategoriesViewModel {
        var categories = [Category]()
        for name in ["Relationships", "Travel", "Work", "Introduction", "Unknown"] {
            let category = Category(JSON: [:])!
            category.name = name
            categories.append(category)
        }

        return CategoriesViewModel(with: categories)
    }
}
