//
//  CategoryDetailTableViewController.swift
//  A-Lang
//
//  Created by Vishal Singh on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import expanding_collection

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
    }
}

extension CategoryDetailTableViewController {

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.passages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PassageOverview.self), for: indexPath)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellHeights[indexPath.row]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PassageOverview else {
            return
        }

        var duration = 0.0
        if viewModel.cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            viewModel.cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.33

            //TODO: Goto next screen
        } else {// close cell
            viewModel.cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.25
        }

        UIView.animate(withDuration: duration) {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? PassageOverview {
            cell.selectedAnimation(viewModel.cellHeights[indexPath.row] != CellHeight.close, animated: false, completion: nil)
        }
    }
}
