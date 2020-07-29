//
//  BookModel.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 05.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

// REVIEW: - Почему не используешь для модели структуру? Для моделей обычно используют структуры. И конструктор не придется писать
class BookModel {
    
    var name: String
    var cover: UIImage
    
    init(name: String) {
        self.name = name
        self.cover = UIImage(named: "Book")!
    }
    
}
