//
//  BookModel.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 05.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

struct BookModel {
    
    var title: String
    var author: String
    var cover: UIImage
    
    init(title: String) {
        self.title = title
        self.cover = UIImage(named: "Book")!
        self.author = "Unknown"
    }
}
