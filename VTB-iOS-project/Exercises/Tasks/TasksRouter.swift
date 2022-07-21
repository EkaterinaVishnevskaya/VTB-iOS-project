//
//  TasksRouter.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская on 14.07.2022.
//  Copyright © 2022 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

protocol TaskRoutingLogic {
   func navigateToTaskViewController (type: String)
}

class TasksRouter: TaskRoutingLogic {
   weak var viewController: UIViewController?
   
   func navigateToTaskViewController(type: String) {
    let dataManager : DictionaryDataManager = DictionaryDataManager()
    let allWords = dataManager.read()
    guard allWords.count>=10 else {
        let alert = UIAlertController(title: "Need 10 or more words!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true)
        return
    }
    var vc = UIViewController()
    switch type {
    case ExercisesViewController.Exercises.TestEngRus:
        vc = TestEngRusViewController()
    case ExercisesViewController.Exercises.TestRusEng:
        vc = TestRusEngViewController()
    case ExercisesViewController.Exercises.InsertLetter:
        vc = InsertLetterViewController()
    case ExercisesViewController.Exercises.TranslateWord:
        vc = TranslateWordViewController()
    default: break
    }
    viewController?.navigationController?.pushViewController(vc, animated: true)
   }
}
