//
//  LibraryInteractor.swift
//  VTB-iOS-project
//
//  Created by Екатерина Вишневская - ВТБ on 19.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

protocol LibraryInteractorInput {
    func loadInfo()
}

protocol LibraryInteractorOutput: AnyObject {
    func infoLoaded()
}

final class LibraryInteractor {
    
    weak var presenter: LibraryInteractorOutput?
}


// MARK: - LibraryInteractorInput
extension LibraryInteractor: LibraryInteractorInput {
    
    func loadInfo() {
        presenter?.infoLoaded()
    }
}
