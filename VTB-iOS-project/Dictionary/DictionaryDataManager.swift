//
//  DictionaryDataManager.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 05.08.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit
import CoreData

class DictionaryDataManager {
    
    static let dataManager = DictionaryDataManager()
    private let appdelegate = UIApplication.shared.delegate as? AppDelegate
    
    func add(word: String) {
        TranslationAPIManager.translationAPIManager.translateFromEngToRus(word: word, completion: {translation in
            if let translation = translation {
                self.add(wordModel: WordModel(word: word, translation: translation))
            } else {
                return
            }
        })
    }
    
    func add(wordModel: WordModel) {
        let queue = DispatchQueue.main
        queue.async {
            
            guard let context = self.appdelegate?.persistentContainer.viewContext else {
                return
            }
            
            guard let entity = NSEntityDescription.entity(forEntityName: "Word", in: context) else {
                return
            }
            
            let wordEntity = NSManagedObject(entity: entity, insertInto: context)
            wordEntity.setValue(wordModel.word, forKey: "word")
            wordEntity.setValue(wordModel.translation, forKey: "translation")
            
            do {
                try context.save()
                print("\(wordModel.word) - \(wordModel.translation) is added ")
            } catch  {
                print("Fail to save")
            }
        }
        
    }
    
    func read() -> [WordModel] {
        guard let context = self.appdelegate?.persistentContainer.viewContext else {
            print("Data Error!")
            return []
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Word")
        do {
            let words = try context.fetch(fetchRequest)
            var result:[WordModel] = []
            for data in words {
                guard let word = data.value(forKey: "word") as? String else { return result }
                guard let translation = data.value(forKey: "translation") as? String else { return result }
                let model = WordModel(word: word, translation: translation)
                result.append(model)
            }
            return result
        } catch let error as NSError {
            print("Data Error: \(error.userInfo)")
            return []
        }
    }
    
    func delete(word: String) {
        guard let context = self.appdelegate?.persistentContainer.viewContext else {
            return
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Word")
        fetchRequest.predicate = NSPredicate(format: "word == \(word)")
        do {
            let words = try context.fetch(fetchRequest)
            for data in words {
                context.delete(data)
            }
        } catch let error as NSError {
            print("Data Error: \(error.userInfo)")
            return
        }
        do {
            try context.save()
            print("\(word) is deleted")
        } catch  {
            print("Fail to save")
        }
    }
}
