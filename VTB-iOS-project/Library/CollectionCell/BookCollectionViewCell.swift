//
//  CollectionViewCell.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 05.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//
import UIKit

final class BookCollectionViewCell: UICollectionViewCell{
    
    // MARK: - Constants
    
    enum Locals {
        static let cellID = "cell"
        static let height: CGFloat = 150
    }

    // MARK: - Properties
    
    private var nameLabel: UILabel!
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
        addAndConfigureNameView()
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
        nameLabel.text = viewModel.name
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
    
    private func addAndConfigureNameView () {
        nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.backgroundColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
    }
    
    private func setConstraints() {
        // REVIEW: - По кодстайлу лучше переносить длинные строки на несколько строк
        NSLayoutConstraint.activate([
            coverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            coverImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 120)
        ])
    }
}
