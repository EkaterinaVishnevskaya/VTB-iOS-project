//
//  CollectionViewCell.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 05.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//
import UIKit

final class BookCollectionViewCell: UICollectionViewCell{

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
        nameLabel = UILabel(frame: .zero)
        nameLabel.textColor = .white
        nameLabel.backgroundColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        coverImageView = UIImageView(frame: .zero)
        coverImageView.image = UIImage(contentsOfFile: "Book.png")
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        contentView.addSubview(coverImageView)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.cgColor
        NSLayoutConstraint.activate([coverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor), coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor), coverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor), nameLabel.leftAnchor.constraint(equalTo: coverImageView.leftAnchor, constant: 20)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    private func updateContent(viewModel: BookModel) {
        nameLabel.text = viewModel.name
    }
}

