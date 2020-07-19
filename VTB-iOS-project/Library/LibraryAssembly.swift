//
//  Assembly.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 19.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

final class LibraryAssembly {

    static func assembly() -> UIViewController {
        
        let view = LibraryViewController()
        let presenter = LibraryPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        let interactor = LibraryInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router = LibraryRouter(view: view)
        presenter.router = router
        
        return view
    }
}
