//
//  ViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 29.06.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

protocol ViewControllerInput {
    func dataLoaded()
}

class LibraryViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cellID = "cell"
        static let height: CGFloat = 150
    }
    
    
    // MARK: - Properties

    private var collectionView: UICollectionView!
    private var bookModels: [BookModel] = [] {
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
        
        let safeArea = view.safeAreaLayoutGuide
        
        let flowLayout = UICollectionViewFlowLayout ()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor), collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor), collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: Locals.cellID)
    }

    private func loadData() {
        
        bookModels = [BookModel(name: "one"), BookModel(name: "two"), BookModel(name: "three"), BookModel(name: "four"), BookModel(name: "five"), BookModel(name: "six"), BookModel(name: "seven"), BookModel(name: "eight"), BookModel(name: "nine"),BookModel(name: "ten"), BookModel(name: "un"), BookModel(name: "deux"),BookModel(name: "trois"), BookModel(name: "quatre"), BookModel(name: "cinq"),BookModel(name: "six"), BookModel(name: "sept"), BookModel(name: "huit"),BookModel(name: "neuf"), BookModel(name: "dix"), BookModel(name: "один"), BookModel(name: "два"),BookModel(name: "три"), BookModel(name: "четыре"), BookModel(name: "пять"),BookModel(name: "шесть"), BookModel(name: "семь"), BookModel(name: "восемь"),BookModel(name: "девять"), BookModel(name: "десять")]
    }
}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension LibraryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Locals.cellID, for: indexPath) as? BookCollectionViewCell {
            cell.viewModel = bookModels[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: Locals.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension LibraryViewController: ViewControllerInput {
    
    func dataLoaded() {
        // Do something
    }
}
