//
//  ExercisesRouter.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская on 14.07.2022.
//  Copyright © 2022 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

 protocol ExerciseRoutingLogic {
    func navigateToStartExerciseViewController (type: String)
}

class ExercisesRouter: ExerciseRoutingLogic {
    weak var viewController: UIViewController?
    
    func navigateToStartExerciseViewController(type: String) {
        let exerciseVC = StartExerciseViewController()
        exerciseVC.setExercise(type: type)
        viewController?.navigationController?.pushViewController(exerciseVC, animated: true)
    }
}
