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
    private var textView: UITextView!
    private var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        self.navigationController!.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(editTranslation))
        
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
        
        textView = UITextView()
        textView.isHidden = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = word.translation
        textView.font = translationLabel.font
        textView.backgroundColor = .black
        textView.textColor = .white
        button = UIButton()
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(updateTranslation), for: .touchUpInside)
        view.addSubview(textView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            translationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 10),
            translationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            translationLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 30),
            textView.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),
            textView.heightAnchor.constraint(equalToConstant: 300),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setWord (_ word: WordModel) {
        self.word = word
    }
    
    @objc private func editTranslation() {
        textView.isHidden = false
        button.isHidden = false
    }
    
    @objc private func updateTranslation() {
        DictionaryDataManager.shared.update(wordModel: word, newTranslation: textView.text)
        translationLabel.text = textView.text
        textView.isHidden = true
        button.isHidden = true
    }
}
