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
    
    static let shared = DictionaryDataManager()
    private let appdelegate = UIApplication.shared.delegate as? AppDelegate
    
    //MARK: - Create
    func add(word: String) {
        TranslationAPIManager.shared.translateFromEngToRus(word: word) {translation in
            if let translation = translation {
                self.add(wordModel: WordModel(word: word, translation: translation))
            } else {
                return
            }
        }
    }
    
    func add(wordModel: WordModel) {
        guard let context = self.appdelegate?.persistentContainer.viewContext else {
            return
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Dictionary", in: context) else {
            return
        }
        
        let word = wordModel.word
        let translation = wordModel.translation
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Dictionary")
        fetchRequest.predicate = NSPredicate(format: "(word == %@) && (translation == %@)", word, translation)
        do {
            let words = try context.fetch(fetchRequest)
            guard words.isEmpty else {
                print("\(word) - \(translation) have been added earlier")
                return
            }
        } catch let error as NSError {
            print("FetchRequesr Error: \(error.userInfo)")
        }
        
        let wordEntity = NSManagedObject(entity: entity, insertInto: context)
        wordEntity.setValue(word, forKey: "word")
        wordEntity.setValue(translation, forKey: "translation")
        
        do {
            try context.save()
            print("\(word) - \(translation) is added ")
        } catch  {
            print("Fail to save")
        }
        
    }
    
    //MARK: - Read
    func read() -> [WordModel] {
        guard let context = self.appdelegate?.persistentContainer.viewContext else {
            print("Data Error!")
            return []
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Dictionary")
        do {
            let words = try context.fetch(fetchRequest)
            var result:[WordModel] = []
            for data in words {
                guard let word = data.value(forKey: "word") as? String else {
                    return result
                }
                guard let translation = data.value(forKey: "translation") as? String else {
                    return result
                }
                let model = WordModel(word: word, translation: translation)
                result.append(model)
            }
            return result
        } catch let error as NSError {
            print("Data Error: \(error.userInfo)")
            return []
        }
    }
    
    //MARK: - Update
    func update(wordModel: WordModel, newTranslation: String) {
        guard let context = self.appdelegate?.persistentContainer.viewContext else {
            return
        }
        let word = wordModel.word
        let translation = wordModel.translation
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Dictionary")
        fetchRequest.predicate = NSPredicate(format: "(word == %@) && (translation == %@)", word, translation)
        do {
            let words = try context.fetch(fetchRequest)
            for data in words {
                data.setValue(newTranslation, forKey: "translation")
            }
        } catch let error as NSError {
            print("Data Error: \(error.userInfo)")
            return
        }
        do {
            try context.save()
            print("\(word) translation updated")
        } catch  {
            print("Fail to save")
        }
    }    
    
    //MARK: - Delete
    func delete(wordModel: WordModel) {
        guard let context = self.appdelegate?.persistentContainer.viewContext else {
            return
        }
        let word = wordModel.word
        let translation = wordModel.translation
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Dictionary")
        fetchRequest.predicate = NSPredicate(format: "(word == %@) && (translation == %@)", word, translation)
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
