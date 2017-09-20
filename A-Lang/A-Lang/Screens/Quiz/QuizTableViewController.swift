//
//  QuizTableViewController.swift
//  A-Lang
//
//  Created by Vishal Singh on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import SVProgressHUD

class QuizTableViewController: UITableViewController {

    var viewModel: QuizViewModel!

    convenience init(with viewModel: QuizViewModel) {
        self.init()

        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(pop))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submit))
        navigationItem.hidesBackButton = true
        title = "Quiz"
    }

    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }

    @objc func submit() {
        var correct = 0
        var max = 0
        for sectionModel in viewModel.sectionModels {
            max += 1
            if sectionModel.type == .subjective {
                guard let userAnswer = sectionModel.userAnswer, !userAnswer.isEmpty else { continue }
                if sectionModel.correctAnswer ?? "" == userAnswer {
                    correct += 1
                }
            } else {
                let userAnswer = (sectionModel.item.cellModels.filter { $0.isSelected }.first)?.item.text ?? ""
                if userAnswer == sectionModel.correctAnswer ?? "" {
                    correct += 1
                }
            }
        }
        presentAlert(alertTitle: "Score", alertMessage: "\(correct)/\(max)")
    }

    func configureTableView() {
        tableView.register(QuizMultipleChoiceCell.nib(), forCellReuseIdentifier: String(describing: QuizMultipleChoiceCell.self))
        tableView.register(QuizSubjectiveTableViewCell.nib(), forCellReuseIdentifier: String(describing: QuizSubjectiveTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(QuizQuestionCell.nib(), forHeaderFooterViewReuseIdentifier: String(describing: QuizQuestionCell.self))
        tableView.keyboardDismissMode = .onDrag
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionModels.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionModels[section].item.cellModels.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = viewModel.sectionModels[section]

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: QuizQuestionCell.self)) as! QuizQuestionCell
        headerView.contentView.backgroundColor = ThemeManager.ThemeColor.whiteDark
        headerView.questionLabel.text = model.item.questionText
        headerView.questionLabel.textColor = ThemeManager.ThemeColor.whiteDarkContrast

        return headerView
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44))

        return footerView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = viewModel.sectionModels[indexPath.section]
        if sectionModel.type == .multipleChoice {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuizMultipleChoiceCell.self), for: indexPath) as! QuizMultipleChoiceCell
            cell.configure(with: sectionModel.item.cellModels[indexPath.row])

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuizSubjectiveTableViewCell.self), for: indexPath) as! QuizSubjectiveTableViewCell
            cell.textView.text = viewModel.sectionModels[indexPath.section].userAnswer ?? ""
            cell.textViewEditingHandler = { text in
                self.viewModel.sectionModels[indexPath.section].userAnswer = text
            }
            cell.selectionStyle = .none

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for (row, model) in viewModel.sectionModels[indexPath.section].item.cellModels.enumerated() {
            model.isSelected = row == indexPath.row
        }
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
    }
}
