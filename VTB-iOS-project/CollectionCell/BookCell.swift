//
//  CollectionViewCell.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 05.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//
import UIKit

final class BookCell: UICollectionViewCell{

    // MARK: - Properties
    
    private var nameLabel: UILabel!
    private var coverImage: UIImageView!
    
    
    var viewModel: BookModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(with: viewModel)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nameLabel = UILabel(frame: .zero)
        nameLabel.textColor = .white
        nameLabel.backgroundColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        coverImage = UIImageView(frame: .zero)
        coverImage.image = UIImage(contentsOfFile: "Book")
        coverImage.contentMode = .scaleAspectFit
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        contentView.addSubview(coverImage)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.cgColor
        NSLayoutConstraint.activate([coverImage.leftAnchor.constraint(equalTo: contentView.leftAnchor), coverImage.topAnchor.constraint(equalTo: contentView.topAnchor), coverImage.heightAnchor.constraint(equalTo: contentView.heightAnchor), nameLabel.leftAnchor.constraint(equalTo: coverImage.leftAnchor, constant: 20)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    private func updateContent(with viewModel: BookModel) {
        nameLabel.text = viewModel.name
    }
}

