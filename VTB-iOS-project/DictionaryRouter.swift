//
//  DictionaryRouter.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 04.08.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

protocol DictionaryRoutingLogic {
    func navigateToWordDetailsViewController (word: WordModel)
}

class DictionaryRouter: DictionaryRoutingLogic {
    weak var viewController: UIViewController?
    
    func navigateToWordDetailsViewController(word: WordModel) {
        let wordVC = WordDetailsViewController()
        wordVC.setWord(word)
        viewController?.navigationController?.pushViewController(wordVC, animated: true)
    }
}
