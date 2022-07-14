//
//  TRanslationAPIManager.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 15.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class TranslationAPIManager {
    
    private enum Constants {
        static let APIKey = "AIzaSyCZ0ZYon-YUkQhr8AyCvLe5QklgeurodJU"
    }
    static let shared = TranslationAPIManager()
    
    func translateFromEngToRus(word: String, completion: ((String?) -> Void)?) {
        let formatedWord = word.split(separator: " ").joined(separator: "+")
        let url = "https://translation.googleapis.com/language/translate/v2?q=\(formatedWord)&sourse=EN&target=RU&key=\(Constants.APIKey)"
        NetworkManager.networkManager.requestPost(urlString: url) { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                do{
                    let jsonResult = try JSONDecoder().decode(TranslationResponse.self, from: data)
                    let translation = jsonResult.data.translations[0].translatedText
                    print("Translation: \(word) -> \(translation)")
                    completion?(translation)
                } catch {
                    print ("JSON Error")
                    completion?(nil)
                }
            case .failure:
                print ("Network Error")
                completion?(nil)
            }
        }
    }
}
