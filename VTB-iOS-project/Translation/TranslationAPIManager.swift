//
//  TRanslationAPIManager.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 15.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class TranslationAPIManager {
    
    enum Constants {
        static let APIKey = "AIzaSyCZ0ZYon-YUkQhr8AyCvLe5QklgeurodJU"
    }
    static let translationAPIManager = TranslationAPIManager()
    
    func translateFromEngToRus(word: String, completion: ((String?) -> Void)?) {

        let url = "https://translation.googleapis.com/language/translate/v2?q=\(word)&sourse=EN&target=RU&key=\(Constants.APIKey)"
        NetworkManager.networkManager.requestGet(urlString: url) { result in
            switch result {
                case .success(let data):
                    guard let data = data else {
                        return
                    }
                    do{
                        let jsonResult = try JSONDecoder().decode(JSONStructure.self, from: data)
                        var translation = ""
                        for i in 0 ..< jsonResult.translate.count {
                            translation += "\(i+1). \(jsonResult.translate[i].translatedText)\n"
                        }
                        completion?(translation)
                    } catch {
                        completion?(nil)
                    }
                case .failure:
                    completion?(nil)
                }

            }
    }
}

