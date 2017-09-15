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

    var viewModel: CategoriesViewModel!

    convenience init(with viewModel: CategoriesViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        itemSize = CGSize(width: ThemeManager.cardSize, height: ThemeManager.cardSize * 1.33)
        super.viewDidLoad()
        
        APIManager.shared.getPassageQuestions(for: "0", in: "four")
        collectionView?.register(CategoryOverviewCell.nib(), forCellWithReuseIdentifier: String(describing: CategoryOverviewCell.self))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = ThemeManager.ThemeColor.categoryOverviewBackground
    }
}

extension CategoriesOverviewViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryOverviewCell.self), for: indexPath) as! CategoryOverviewCell
        cell.configure(with: viewModel.categoryModels[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryOverviewCell else { return }

        if cell.isOpened {
            let vc = CategoryDetailTableViewController()
            pushToViewController(vc)
        } else {
            cell.cellIsOpen(!cell.isOpened)
            APIManager.shared.getPassagesForCategory(viewModel.categories[indexPath.row].name ?? "") { passages in
                cell.setNumberOfPassages(passages.count)
            }
        }
    }
}
