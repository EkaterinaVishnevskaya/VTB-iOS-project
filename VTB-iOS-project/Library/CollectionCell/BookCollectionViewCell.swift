//
//  CollectionViewCell.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 05.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

final class BookCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    enum Locals {
        static let cellID = "bookcell"
        static let height: CGFloat = 150
    }
    
    // MARK: - Properties
    
    private var titleLabel: UILabel!
    private var authorLabel: UILabel!
    private var coverImageView: UIImageView!
    
    
    var viewModel: BookModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            updateContent(viewModel: viewModel)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAndConfigureTitleView()
        addAndConfigureAuthorView()
        addAndConfigureCoverView()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.cgColor
        setConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    private func updateContent(viewModel: BookModel) {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        coverImageView.image = viewModel.cover
    }
    
    // MARK: -UI
    private func addAndConfigureCoverView () {
        coverImageView = UIImageView()
        coverImageView.image = UIImage(named: "Book")
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coverImageView)
    }
    
    private func addAndConfigureTitleView () {
        titleLabel = UILabel()
        titleLabel.textColor = .white
        //titleLabel.backgroundColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
    }
    
    private func addAndConfigureAuthorView () {
        authorLabel = UILabel()
        authorLabel.textColor = .lightGray
        authorLabel.backgroundColor = .black
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            coverImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 120),
            authorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 120),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
    }
}

