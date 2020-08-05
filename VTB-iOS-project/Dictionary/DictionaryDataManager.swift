//
//  DictionaryDataManager.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 05.08.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class DictionaryDataManager {
    
    static let dataManager = DictionaryDataManager()
    
    func add(word: String) {
        TranslationAPIManager.translationAPIManager.translateFromEngToRus(word: word, completion: {translation in
            if let translation = translation {
                let model = WordModel(word: word, translation: translation)
                print("\(model.word) - \(model.translation) is added ")
            } else {
                return
            }
        })
    }
    
    func add(wordModel: WordModel) {
        print("\(wordModel.word) - \(wordModel.translation) is added ")
    }
    
    func read() -> [WordModel] {
        return [WordModel(word: "one", translation: "один1\nодин2\nодин3\nодин4\nодин5"), WordModel(word: "two", translation: "два"), WordModel(word: "three", translation: "три"), WordModel(word: "four", translation: "четыре"), WordModel(word: "five", translation: "пять"), WordModel(word: "six", translation: "шесть"), WordModel(word: "seven", translation: "семь"), WordModel(word: "eight", translation: "восемь"), WordModel(word: "nine", translation: "девять"), WordModel(word: "ten", translation: "десять")]
    }

    func delete(word: String) {
        print("\(word) is deleted")
    }
}
