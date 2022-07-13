//
//  ExercisesTableViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская on 13.07.2022.
//  Copyright © 2022 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class ExercisesViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var exercisesTypes: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        loadData()
    }
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Configurations
    
    private func setCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout ()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.Locals.cellID)
    }
    
    private func loadData() {
        
        exercisesTypes = ["Test Eng To Rus", "Test Rus To Eng", "Traslate Rus to Eng"]
    }
}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension ExercisesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercisesTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.Locals.cellID, for: indexPath) as? ExerciseCollectionViewCell else {
            fatalError()
        }
        cell.viewModel = exercisesTypes[indexPath.row]
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ExercisesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: ExerciseCollectionViewCell.Locals.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
