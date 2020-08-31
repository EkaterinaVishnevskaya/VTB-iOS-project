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
    private var okButton: UIButton!
    private var cancelButton: UIButton!
    
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
        
        textView = UITextView()
        textView.isHidden = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = word.translation
        textView.font = translationLabel.font
        textView.backgroundColor = .black
        textView.textColor = .white
        
        okButton = UIButton()
        okButton.isHidden = true
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle("OK", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.layer.cornerRadius = 5
        okButton.addTarget(self, action: #selector(updateTranslation), for: .touchUpInside)
        
        cancelButton = UIButton()
        cancelButton.isHidden = true
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius = 5
        cancelButton.addTarget(self, action: #selector(endEdit), for: .touchUpInside)
        view.addSubview(textView)
        view.addSubview(okButton)
        view.addSubview(cancelButton)
        
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
            okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            okButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setWord (_ word: WordModel) {
        self.word = word
    }
    
    @objc private func startEdit() {
        textView.isHidden = false
        okButton.isHidden = false
        cancelButton.isHidden = false
    }
    
    @objc private func updateTranslation() {
        DictionaryDataManager.shared.update(wordModel: word, newTranslation: textView.text)
        translationLabel.text = textView.text
        endEdit()
    }
    @objc private func endEdit() {
        textView.isHidden = true
        okButton.isHidden = true
        cancelButton.isHidden = true
    }
}
