//
//  LibraryPresenter.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 19.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

typealias LibraryInputInfo = (name: String, lastName: String)

final class LibraryPresenter {
    
    // MARK: - Properties
    
    weak var view: LibraryViewInput?
    var interactor: LibraryInteractorInput?
    var router: LibraryRouterInput?

}

// MARK: - LibraryViewOutput
extension LibraryPresenter: LibraryViewOutput {
    func viewIsReady() {
        // Do some logic
        interactor?.loadInfo()
        
    }
    
    func closePage() {
        router?.closeModule()
    }
}

// MARK: - LibraryInteractorOutput
extension LibraryPresenter: LibraryInteractorOutput {
    func infoLoaded() {
        view?.updateView()
    }
}
