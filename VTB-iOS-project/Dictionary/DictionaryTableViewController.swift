//
//  DictionaryViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 29.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit
import Foundation

class DictionaryTableViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tableView: UITableView!
    private let searchController  = UISearchController(searchResultsController: nil)
    private var wordModels: [WordModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var filtredWordModels: [WordModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        setLayout()
        configureTableView()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.Locals.cellID)
    }
    
    private func loadData() {
        wordModels = DictionaryDataManager.dataManager.read()
    }
    
    private func setLayout() {
        setHeaderView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .gray
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setHeaderView() {
        let addButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addWord))
        addButton.tintColor = .black
        navigationItem.rightBarButtonItem = addButton
        
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Dictionary"
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        let searchBar = searchController.searchBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "search"
        searchBar.barTintColor = .gray
        searchBar.tintColor = .black
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = .white
            textfield.layer.cornerRadius = 10
            textfield.clipsToBounds = true
            textfield.layer.borderWidth = 0.5
            textfield.layer.borderColor = UIColor.black.cgColor
        }
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc private func addWord() {
        let alert = UIAlertController(title: "Enter word", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your word"
        })
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            guard let word = alert.textFields?.first?.text else {
                return
            }
            TranslationAPIManager.translationAPIManager.translateFromEngToRus(word: word, completion: {translation in
                if let translation = translation {
                    let model = WordModel(word: word, translation: translation)
                    DictionaryDataManager.dataManager.add(wordModel: model)
                    let queue = DispatchQueue.main
                    queue.async {
                        self.wordModels.append(model)
                    }
                } else {
                    return
                }
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DictionaryTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtredWordModels.count
        } else {
            return wordModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.Locals.cellID, for: indexPath) as? WordTableViewCell {
            cell.viewModel = isFiltering ? filtredWordModels[indexPath.row]:wordModels[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let router = DictionaryRouter()
        router.viewController = self
        router.navigateToWordDetailsViewController(word: wordModels[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            DictionaryDataManager.dataManager.delete(word: self.wordModels[indexPath.row].word)
            if self.isFiltering {
                self.wordModels.remove(at: self.wordModels.firstIndex(where: {wordmodel in
                    return wordmodel.word==self.filtredWordModels[indexPath.row].word
                }) ?? -1)
                self.filtredWordModels.remove(at: indexPath.row)
            } else {
                self.wordModels.remove(at: indexPath.row)
            }
        }
        
        delete.backgroundColor = .gray
        
        return [delete]
    }
    
}

// MARK: - UISearchControllerDelegate&UISearchResultsUpdating

extension DictionaryTableViewController: UISearchControllerDelegate {
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredWordModels = wordModels.filter() {wordmodel in
            return wordmodel.word.contains(searchText)
        }
    }
}

extension DictionaryTableViewController: UISearchResultsUpdating {
    
    func filterContentForSearchText(_ searchText: String) {
        filtredWordModels = wordModels.filter(){wordmodel in
            return wordmodel.word.lowercased().contains(searchText.lowercased()) || wordmodel.translation.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
