//
//  TranslateWordModel.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская on 15.07.2022.
//  Copyright © 2022 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class TaskManager: NSObject {
    
    func setOpenTask()->[WordModel] {
        let dataManager : DictionaryDataManager = DictionaryDataManager()
        var allWords = dataManager.read()
        var task: [WordModel] = []
        let n = allWords.count
        for t in 0...9 {
            let j = Int.random(in: 0...n-t-1)
            task.append(allWords[j])
            allWords.remove(at: j)
        }
        return task
    }
    
    func setTestTask() -> [TestTaskModel] {
        return []
    }

}
