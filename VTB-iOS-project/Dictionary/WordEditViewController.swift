//
//  WordEditViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская on 13.07.2022.
//  Copyright © 2022 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class WordEditViewController: UIViewController {
    
    private var word = WordModel(word: "", translation: "")
    
    private var textView: UITextView!
    private var okButton: UIButton!
    private var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        
        textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = word.translation
        textView.backgroundColor = .black
        textView.textColor = .white
        
        okButton = UIButton()
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle("OK", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.layer.cornerRadius = 5
        okButton.addTarget(self, action: #selector(updateTranslation), for: .touchUpInside)
        
        cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius = 5
        cancelButton.addTarget(self, action: #selector(endEdit), for: .touchUpInside)
        view.addSubview(textView)
        view.addSubview(okButton)
        view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
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
    
    @objc private func updateTranslation() {
        DictionaryDataManager.shared.update(wordModel: word, newTranslation: textView.text)
        endEdit()
    
    }
    
    @objc private func endEdit() {
        self.dismiss(animated: true, completion: nil)
    }
}
