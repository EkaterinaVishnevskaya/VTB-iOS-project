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
        
        let view = LoginViewController()
        let presenter = LoginPresenter(dataStore: dataStore)
        
        view.presenter = presenter
        presenter.view = view
        
        let interactor = LoginInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router = LoginRouter(view: view)
        presenter.router = router
        
        return view
    }
}
