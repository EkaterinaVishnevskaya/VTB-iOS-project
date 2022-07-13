//
//  ExerciseCollectionViewCell.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская on 13.07.2022.
//  Copyright © 2022 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    
    enum Locals {
        static let cellID = "exercisecell"
        static let height: CGFloat = 50
    }
    
    // MARK: - Properties
    
    private var exerciseTitleLabel: UILabel!
    
    
    var viewModel: String? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            updateContent(viewModel: viewModel)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAndConfigureLabelView()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.cgColor
        setConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    private func updateContent(viewModel: String) {
        exerciseTitleLabel.text = viewModel
    }
    
    // MARK: -UI
    
    private func addAndConfigureLabelView () {
        exerciseTitleLabel = UILabel()
        exerciseTitleLabel.textColor = .white
        exerciseTitleLabel.backgroundColor = .black
        exerciseTitleLabel.font = .boldSystemFont(ofSize: 24)
        exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(exerciseTitleLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            exerciseTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            exerciseTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
    }
}
