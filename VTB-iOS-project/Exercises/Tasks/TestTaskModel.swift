//
//  TestTaskModel.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская on 16.07.2022.
//  Copyright © 2022 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

enum Direction {
    static let EngRus = 1
    static let RusEng = 2
}

struct TestTaskModel {
    let taskWord: WordModel
    var direction: Int
    var variants: [String] = ["", "", "", ""]
    var correctAnswer: Int {
        get {
            if direction==Direction.EngRus {
                for i in 0...3 {
                    if variants[i]==taskWord.translation{return i}
                }
            }else {
                    for i in 0...3 {
                        if variants[i]==taskWord.word {return i}
                    }
            }
            return 0
        }
    }
}
    
