//
//  WordViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 01.08.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class WordViewController: UIViewController {
    
    private var wordLabel: UILabel!
    private var translationLabel: UILabel!
    var word: WordModel
    
    /*init(word: WordModel) {
        //super.init()
        self.word = word
    }*/
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        wordLabel = UILabel()
        wordLabel.text = word.word
        wordLabel.textColor = .white
        wordLabel.backgroundColor = .black
        wordLabel.font = UIFont.boldSystemFont(ofSize: 32.0)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        translationLabel = UILabel()
        translationLabel.text = word.translation
        translationLabel.textColor = .white
        translationLabel.backgroundColor = .black
        translationLabel.numberOfLines = 0
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
    }

}
