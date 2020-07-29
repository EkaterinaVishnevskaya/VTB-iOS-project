//
//  TRanslationAPIManager.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 15.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class TranslationAPIManager {
    
    static let translationAPIManager = TranslationAPIManager()
    
    func translateFromEngToRus(word: String, completion: ((String?) -> Void)?) {

        let url = "https://translation.googleapis.com/language/translate/v2"
            NetworkManager.networkManager.requestGet(urlString: url) { result in
                switch result {
                case .success(let data):
                    guard let data = data else {
                        return
                    }
                    do{
                        let jsonResult = try JSONDecoder().decode(JSONStructure.self, from: data)
                        let translation = jsonResult.translate[0].translatedText
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
