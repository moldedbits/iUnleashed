//
//  PasageTableViewController.swift
//  A-Lang
//
//  Created by Saurabh Gupta on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import SVProgressHUD

class PassageTableViewController: UITableViewController {
    
    var viewModel: PassageDetailViewModel!
    
    convenience init(with viewModel: PassageDetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        SVProgressHUD.show()
        APIManager.shared.getPassageSentences(for: viewModel.passage.id, in: viewModel.passage.categoryName) { sentences in
            SVProgressHUD.dismiss()
            self.viewModel.sentences = sentences
            self.viewModel.cellModel = PassageDetailsCellModel.init(with: sentences, andPassageText: self.viewModel.passage.passageText?.spanish ?? "")
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        configureNavigationItems()
    }
    
    func configureTableView() {
        tableView.register(PassageTableViewCell.nib(), forCellReuseIdentifier: String(describing: PassageTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
    
    func configureNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Take Quiz >", style: .plain, target: self, action: #selector(goToQuizScreen))
        title = viewModel.passage.displayName?.english
    }
    
    @objc func goToQuizScreen() {
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.cellModel == nil {
            return 0
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PassageTableViewCell.self), for: indexPath) as! PassageTableViewCell
        cell.configure(with: viewModel.cellModel)
        
        return cell
    }
}
