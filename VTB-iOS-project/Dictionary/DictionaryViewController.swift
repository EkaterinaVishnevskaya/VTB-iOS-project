//
//  DictionaryViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 29.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit
import Foundation

class DictinaryViewController: UIViewController {
    
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
    
    
    // MARK: - Configurations
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.Locals.cellID)
    }
    
    private func loadData() {
        wordModels = [WordModel(word: "one", translation: "один\nодин\nодин\nодин\nодин"), WordModel(word: "two", translation: "два"), WordModel(word: "three", translation: "три"), WordModel(word: "four", translation: "четыре"), WordModel(word: "five", translation: "пять"), WordModel(word: "six", translation: "шесть"), WordModel(word: "seven", translation: "семь"), WordModel(word: "eight", translation: "восемь"), WordModel(word: "nine", translation: "девять"), WordModel(word: "ten", translation: "десять")]
    }
    
    private func setLayout() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = . gray
        let headerView = setHeaderView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .gray
        view.addSubview(headerView)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func setHeaderView() -> UIView {
        let headerView = UIView()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let searchBar = searchController.searchBar
        searchBar.placeholder = "search"
        searchBar.barTintColor = .gray
        // searchBar.scopeBarButtonTitleTextAttributes(for: .normal)
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = .white
            textfield.layer.cornerRadius = 10
            textfield.clipsToBounds = true
            textfield.layer.borderWidth = 0.5
            textfield.layer.borderColor = UIColor.black.cgColor
        }
        if let cancelButton = searchBar.value(forKey: "cancelButton") as?  UIButton {
            cancelButton.setTitleColor(.white, for: .normal)
            cancelButton.setTitleColor(.lightGray, for: .selected)
            
        }
        headerView.addSubview(searchBar)
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Dictionary - Словарь"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        headerLabel.textColor = .black
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10)
        ])
        return headerView
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DictinaryViewController: UITableViewDelegate, UITableViewDataSource {
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
        guard editingStyle == .delete else {
            return
        }
        if isFiltering {
            wordModels.remove(at: wordModels.firstIndex(where: {wordmodel in
                return wordmodel.word==filtredWordModels[indexPath.row].word
            }) ?? -1)
            filtredWordModels.remove(at: indexPath.row)
        } else {
            wordModels.remove(at: indexPath.row)
        }
    }
}

// MARK: - UISearchControllerDelegate&UISearchResultsUpdating

extension DictinaryViewController: UISearchControllerDelegate {
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredWordModels = wordModels.filter(){wordmodel in
            return wordmodel.word.contains(searchText)
        }
    }
}

extension DictinaryViewController: UISearchResultsUpdating {
    
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
