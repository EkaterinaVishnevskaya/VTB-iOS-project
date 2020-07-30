//
//  WordCell.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 29.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//


import UIKit

class WordTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    enum Locals {
        static let cellID = "wordcell"
        static let cellHeight: CGFloat = 100
    }
    
    // MARK: - Properties
    
    var wordLabel: UILabel!
    var translationLabel: UILabel!
    var viewModel: WordModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(with: viewModel)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        addAndConfigureWordLabel()
        addAndConfigureTranslationLabel()
        setConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - UI
    private func addAndConfigureWordLabel() {
        wordLabel = UILabel()
        wordLabel.textColor = .white
        wordLabel.backgroundColor = .black
        wordLabel.lineBreakMode = .byWordWrapping
        wordLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wordLabel)
    }
    
    private func addAndConfigureTranslationLabel() {
        translationLabel = UILabel()
        translationLabel.textColor = .white
        translationLabel.backgroundColor = .black
        translationLabel.lineBreakMode = .byWordWrapping
        translationLabel.numberOfLines = 3
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(translationLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            wordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            wordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            wordLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            translationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            translationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            translationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 5),
        ])
    }
    // MARK: - Private
    
    private func updateContent(with viewModel: WordModel) {
        wordLabel.text = viewModel.word
        translationLabel.text = viewModel.translation
    }
}
