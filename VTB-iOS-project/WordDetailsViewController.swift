//
//  WordViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 01.08.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class WordDetailsViewController: UIViewController {
    
    private var wordLabel: UILabel!
    private var translationLabel: UILabel!
    private var word = WordModel(word: "", translation: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        self.navigationController!.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(startEdit))
        
        wordLabel = UILabel()
        wordLabel.text = word.word
        wordLabel.textColor = .white
        wordLabel.font = UIFont.boldSystemFont(ofSize: 32.0)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wordLabel)
        
        translationLabel = UILabel()
        translationLabel.text = word.translation
        translationLabel.textColor = .white
        translationLabel.numberOfLines = 0
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(translationLabel)
        
       
        
        NSLayoutConstraint.activate([
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            translationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 10),
            translationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            translationLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 30),
        ])
    }
    
    func setWord (_ word: WordModel) {
        self.word = word
    }
    
    @objc private func startEdit() {
        let controller = WordEditViewController()
        controller.setWord(word)
        self.present(controller, animated:true, completion:nil)
    }
    
    
}
