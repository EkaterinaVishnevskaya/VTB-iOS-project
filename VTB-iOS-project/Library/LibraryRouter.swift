//
//  LibraryRouter.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 19.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

protocol LibraryRouterInput {
    func closeModule()
}

final class LibraryRouter {
    
    // MARK: - Properties
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}


// MARK: - LoginRouterInput
extension LibraryRouter: LibraryRouterInput {
    
    func closeModule() {
        view.dismiss(animated: true, completion: nil)
    }
}
