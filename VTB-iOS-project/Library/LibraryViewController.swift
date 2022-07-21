//
//  ViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 29.06.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
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
        
        self.navigationController!.navigationBar.backgroundColor = .white
        self.navigationController!.navigationBar.tintColor = .black
        
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
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.Locals.cellID)
    }
    
    private func loadData() {
        
        bookModels = [BookModel(title: "one"), BookModel(title: "two"), BookModel(title: "three"), BookModel(title: "four"), BookModel(title: "five"), BookModel(title: "six"), BookModel(title: "seven"), BookModel(title: "eight"), BookModel(title: "nine"),BookModel(title: "ten"), BookModel(title: "un"), BookModel(title: "deux"),BookModel(title: "trois"), BookModel(title: "quatre"), BookModel(title: "cinq"),BookModel(title: "six"), BookModel(title: "sept"), BookModel(title: "huit"),BookModel(title: "neuf"), BookModel(title: "dix"), BookModel(title: "один"), BookModel(title: "два"),BookModel(title: "три"), BookModel(title: "четыре"), BookModel(title: "пять"),BookModel(title: "шесть"), BookModel(title: "семь"), BookModel(title: "восемь"),BookModel(title: "девять"), BookModel(title: "десять")]
    }
}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension LibraryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.Locals.cellID, for: indexPath) as? BookCollectionViewCell else {
            fatalError()
        }
        cell.viewModel = bookModels[indexPath.row]
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: BookCollectionViewCell.Locals.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
