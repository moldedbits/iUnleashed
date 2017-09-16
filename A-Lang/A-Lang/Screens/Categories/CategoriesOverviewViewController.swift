//
//  CategoriesOverviewViewController.swift
//  A-Lang
//
//  Created by Vishal Singh on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import expanding_collection
import  SVProgressHUD

class CategoriesOverviewViewController: ExpandingViewController {

    var viewModel: CategoriesViewModel!

    convenience init(with viewModel: CategoriesViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    var pageControl: UIPageControl!

    override func viewDidLoad() {
        itemSize = CGSize(width: ThemeManager.cardSize, height: ThemeManager.cardSize * 1.33)
        super.viewDidLoad()
        
        configureCollectionView()
        configurePageControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }

    private func configureCollectionView() {
        guard let collectionView = collectionView else { return }
        collectionView.register(CategoryOverviewCell.nib(), forCellWithReuseIdentifier: String(describing: CategoryOverviewCell.self))
        addGesture(to: collectionView)
    }

    private func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: view.bounds.width / 4, y: view.bounds.height - 50, width: view.bounds.width / 2, height: 25))
        pageControl.numberOfPages = viewModel.categoryModels.count
        pageControl.currentPageIndicatorTintColor = ThemeManager.ThemeColor.whiteDarkContrast
        pageControl.pageIndicatorTintColor = ThemeManager.ThemeColor.whiteDark
        view.addSubview(pageControl)
        pageControl.isUserInteractionEnabled = false
    }

    private func gotoDetailScreen() {
        let selectedCategory = viewModel.categories[currentIndex]
        if let passages = selectedCategory.passages {
            // this should be the case always here
            let viewModel = CategoryDetailViewModel(with: selectedCategory.name ?? "", and: passages)
            let detailScreen = CategoryDetailTableViewController(with: viewModel)
            self.pushToViewController(detailScreen)
        } else {
            let indexPath = IndexPath(item: currentIndex, section: 0)
            guard let cell = collectionView?.cellForItem(at: indexPath) as? CategoryOverviewCell else { return }

            getDataFromAPI(forCell: cell, atIndexPath: indexPath, andShouldPushToDetailScreen: true)
        }
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
            gotoDetailScreen()
        } else {
            if let passages = viewModel.categories[indexPath.row].passages {
                cell.cellIsOpen(!cell.isOpened)
                cell.setNumberOfPassages(passages.count)
            } else {
                getDataFromAPI(forCell: cell, atIndexPath: indexPath)
            }
        }
    }

    private func getDataFromAPI(forCell cell: CategoryOverviewCell, atIndexPath indexPath: IndexPath, andShouldPushToDetailScreen shouldPushToDetailScreen: Bool = false) {
        SVProgressHUD.show()
        APIManager.shared.getPassagesForCategory(viewModel.categories[indexPath.row].name ?? "") { passages in
            SVProgressHUD.dismiss()
            cell.setNumberOfPassages(passages.count)
            self.viewModel.categories[indexPath.row].passages = passages
            self.viewModel.categoryModels[indexPath.row].passagesCount = passages.count
            cell.cellIsOpen(!cell.isOpened)
            if shouldPushToDetailScreen {
                let selectedCategory = self.viewModel.categories[indexPath.row]
                let viewModel = CategoryDetailViewModel(with: selectedCategory.name ?? "", and: passages)
                let detailScreen = CategoryDetailTableViewController(with: viewModel)
                self.pushToViewController(detailScreen)
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = currentIndex
        view.backgroundColor = ThemeManager.gradientColor(with: .diagonal, and: view.bounds, andColors: viewModel.categoryModels[currentIndex].type.gradientColors)
    }
}

/// MARK: Gesture
extension CategoriesOverviewViewController {

    fileprivate func addGesture(to view: UIView) {
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        upGesture.direction = .up

        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        downGesture.direction = .down

        view.addGestureRecognizer(upGesture)
        view.addGestureRecognizer(downGesture)
    }

    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell  = collectionView?.cellForItem(at: indexPath) as? CategoryOverviewCell else { return }
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            gotoDetailScreen()
        }

        let open = sender.direction == .up
        cell.cellIsOpen(open)
        viewModel.categoryModels[indexPath.row].isOpen = cell.isOpened
    }
}
