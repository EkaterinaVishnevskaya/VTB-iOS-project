//
//  StartExerciseViewController.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская on 14.07.2022.
//  Copyright © 2022 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class StartExerciseViewController: UIViewController {
    
    private var exercise = ""
    
    private var exerciseTitleLabel = UILabel()
    private var startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.tintColor = .black
        view.backgroundColor = .black
        
        exerciseTitleLabel.text = exercise
        exerciseTitleLabel.textColor = .white
        exerciseTitleLabel.backgroundColor = .black
        exerciseTitleLabel.font = .boldSystemFont(ofSize: 26)
        exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exerciseTitleLabel)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.addTarget(self, action: #selector(startExercise), for: .touchUpInside)
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            exerciseTitleLabel.topAnchor.constraint(equalTo: startButton.topAnchor, constant: -60),
            exerciseTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exerciseTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    }
    
    func setExercise(type: String) {
        self.exercise = type
    }
    
    @objc func startExercise(){
        let router = TasksRouter()
        router.viewController = self
        router.navigateToTaskViewController(type: exercise)
    }

}
