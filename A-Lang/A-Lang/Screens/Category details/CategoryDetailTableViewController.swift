//
//  CategoryDetailTableViewController.swift
//  A-Lang
//
//  Created by Vishal Singh on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import expanding_collection
import SVProgressHUD

class CategoryDetailTableViewController: ExpandingTableViewController {

    var viewModel: CategoryDetailViewModel!

    convenience init(with viewModel: CategoryDetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerHeight = 236
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = viewModel.title
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(pop))
    }

    @objc func pop() {
        popTransitionAnimation()
    }

    func configureTableView() {
        tableView.register(PassageOverview.nib(), forCellReuseIdentifier: String(describing: PassageOverview.self))
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }

    fileprivate func getDataFromAPI(forCell cell: PassageOverview, atIndexPath indexPath: IndexPath, shouldOpen: Bool) {
        let selectedPassage = viewModel.passages[indexPath.row]
        SVProgressHUD.show()
        APIManager.shared.getPassageText(for: selectedPassage.id, inCategory: selectedPassage.categoryName) { bilingualText in
            SVProgressHUD.dismiss()
            self.viewModel.passages[indexPath.row].passageText = bilingualText
            self.viewModel.cellModels[indexPath.row].textPreview = bilingualText.spanish ?? "No information available"
            self.updateTableView(forCell: cell, atIndexPath: indexPath, shouldOpen: shouldOpen)
        }
    }

    fileprivate func updateTableView(forCell cell: PassageOverview, atIndexPath indexPath: IndexPath, shouldOpen: Bool) {
        viewModel.cellHeights[indexPath.row] = shouldOpen ? kOpenCellHeight : kClosedCellHeight
        cell.selectedAnimation(shouldOpen, animated: true, completion: nil)
        cell.configure(with: viewModel.cellModels[indexPath.row])
        UIView.animate(withDuration: (shouldOpen ? kOpenCellDuration : kCloseCellDuration)) {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}

extension CategoryDetailTableViewController {

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.cellModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PassageOverview.self), for: indexPath) as! PassageOverview
        cell.indexPath = indexPath
        cell.configure(with: viewModel.cellModels[indexPath.row]) { indexPath in
            guard let cell = tableView.cellForRow(at: indexPath) as? PassageOverview else { return }

            self.updateTableView(forCell: cell, atIndexPath: indexPath, shouldOpen: false)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellHeights[indexPath.row]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PassageOverview else {
            return
        }

        if viewModel.cellHeights[indexPath.row] == kClosedCellHeight { // open cell
            if let _ = viewModel.passages[indexPath.row].passageText {
                updateTableView(forCell: cell, atIndexPath: indexPath, shouldOpen: true)
            } else {
                getDataFromAPI(forCell: cell, atIndexPath: indexPath, shouldOpen: true)
            }
        } else {// close cell
            updateTableView(forCell: cell, atIndexPath: indexPath, shouldOpen: false)
            let passageDetailViewModel = PassageDetailViewModel(with: viewModel.passages[indexPath.row])
            let screen = PassageTableViewController(with: passageDetailViewModel)
            navigationController?.pushViewController(screen, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? PassageOverview {
            cell.selectedAnimation(viewModel.cellHeights[indexPath.row] != CellHeight.close, animated: false, completion: nil)
        }
    }
}
