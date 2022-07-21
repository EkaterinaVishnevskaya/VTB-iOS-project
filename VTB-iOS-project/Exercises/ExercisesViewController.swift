//
//  ExercisesTableViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская on 13.07.2022.
//  Copyright © 2022 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class ExercisesViewController: UIViewController {
    enum Exercises {
        static let TestEngRus = "Test Eng -> Rus"
        static let TestRusEng = "Test Rus -> Eng"
        static let InsertLetter = "Insert letter"
        static let TranslateWord = "Traslate word"
    }
    
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
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.Locals.cellID)
    }
    
    private func loadData() {
        
        exercisesTypes = [Exercises.TestEngRus, Exercises.TestRusEng, Exercises.InsertLetter, Exercises.TranslateWord]
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let router = ExercisesRouter()
        router.viewController = self
        switch indexPath.row {
        case 0:
            router.navigateToStartExerciseViewController(type: Exercises.TestEngRus)
        case 1:
            router.navigateToStartExerciseViewController(type: Exercises.TestRusEng)
        case 2:
            router.navigateToStartExerciseViewController(type: Exercises.InsertLetter)
        case 3:
            router.navigateToStartExerciseViewController(type: Exercises.TranslateWord)
        default:
            return
        }
    }
    }
    


// MARK: - UICollectionViewDelegateFlowLayout
extension ExercisesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-40, height: ExerciseCollectionViewCell.Locals.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
