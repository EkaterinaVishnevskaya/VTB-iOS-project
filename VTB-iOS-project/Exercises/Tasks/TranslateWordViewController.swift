//
//  TranslateWordViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская on 14.07.2022.
//  Copyright © 2022 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class TranslateWordViewController: UIViewController {
    
    private var task : [WordModel] = []
    private var answers: [String] = []
    
    private let model = TaskManager()

    private let headerLabel = UILabel()
    private let wordLabel = UILabel()
    private let answerTextField = UITextField()
    private let button = UIButton()
    
    private var i = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.font = UIFont(name:headerLabel.font.fontName, size: 20.0)
        headerLabel.textColor = .white
        wordLabel.textColor = .white
        answerTextField.placeholder = "Answer"
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(nextTask), for: .touchUpInside)
        
        
        view.addSubview(answerTextField)
        view.addSubview(headerLabel)
        view.addSubview(wordLabel)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
        ])
        
        task = model.setOpenTask()
        setTaskView(i: 1)
    }
    
    func setTaskView(i: Int) {
        headerLabel.text = "Translate word \(i)/10"
        wordLabel.text = task[i].translation
        answerTextField.text = ""
        if i==10 {
            button.setTitle("Finish", for: .normal)
            button.addTarget(self, action: #selector(finish), for: .touchUpInside)
        }
    }
    
    @objc func nextTask(){
        answers[i-1] = answerTextField.text ?? ""
        i+=1
        setTaskView(i: i)
    }
    
    @objc func finish() {
    }
}
