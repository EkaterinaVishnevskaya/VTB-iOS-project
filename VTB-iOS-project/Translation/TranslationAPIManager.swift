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
    
    func translateFromEngToRus(word: String) -> String? {
        
        let translation: String
        let url = "https://translation.googleapis.com/language/translate/v2"
        
        
        do{
            guard let data = NetworkManager.networkManager.requestGet(urlString: url) else {
                return nil
            }
            let jsonResult = try! JSONDecoder().decode(JSONStructure.self, from: data)
            translation = jsonResult.translate[0].translatedText
        } catch {
            print("JSON Error")
        }
        return translation
    }
    
}
