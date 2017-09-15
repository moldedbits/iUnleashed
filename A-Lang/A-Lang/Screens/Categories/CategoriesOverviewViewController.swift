//
//  CategoriesOverviewViewController.swift
//  A-Lang
//
//  Created by Vishal Singh on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import expanding_collection

class CategoriesOverviewViewController: ExpandingViewController {

    override func viewDidLoad() {
        itemSize = CGSize(width: ThemeManager.cardSize, height: ThemeManager.cardSize)
        super.viewDidLoad()

        collectionView?.register(CategoryOverviewCell.nib(), forCellWithReuseIdentifier: String(describing: CategoryOverviewCell.self))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = ThemeManager.ThemeColor.whiteDark
    }
}

extension CategoriesOverviewViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryOverviewCell.self), for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryOverviewCell else { return }

        cell.cellIsOpen(!cell.isOpened)
    }
}
