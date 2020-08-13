//
//  JSONStructure.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 15.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

struct TranslateTextResponseTranslation: Codable {
    let detectedSourceLanguage: String
    let model: String?
    let translatedText: String
}

struct TranslationData: Codable {
    let translations: [TranslateTextResponseTranslation]
}

struct TranslationResponse: Codable {
    let data: TranslationData
}
