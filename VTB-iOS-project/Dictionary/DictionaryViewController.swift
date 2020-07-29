//
//  DictionaryViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 29.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class DictinaryViewController: UIViewController {
    
    // MARK: - Properties

    var tableView: UITableView!
    private var wordModels: [WordModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        configureTableView()
        loadData()
        view.addSubview(tableView)
    }
    
    
    // MARK: - Configurations
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.Locals.cellID)
    }

    private func loadData() {
        wordModels = [WordModel(word: "one", translation: "один\nодин\nодин\nодин"), WordModel(word: "two", translation: "два"), WordModel(word: "three", translation: "три"), WordModel(word: "four", translation: "четыре"), WordModel(word: "five", translation: "пять"), WordModel(word: "six", translation: "шесть"), WordModel(word: "seven", translation: "семь"), WordModel(word: "eight", translation: "восемь"), WordModel(word: "nine", translation: "девять"), WordModel(word: "ten", translation: "десять")]
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DictinaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.Locals.cellID, for: indexPath) as? WordTableViewCell {
            cell.viewModel = self.wordModels[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WordTableViewCell.Locals.cellHeight
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            wordModels.remove(at: indexPath.row)
        }
    }
}

