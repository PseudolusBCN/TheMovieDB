//
//  MainInterfaces.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

protocol InterfaceMainViewController: class {
    var presenter: InterfaceMainPresenter? { get set }
}

protocol InterfaceMainPresenter: class {
    var router: InterfaceMainRouter? { get set }
    var interactor: InterfaceMainInteractor? { get set }
    var view: InterfaceMainViewController? { get set }
    
    func downloadData()
}

protocol InterfaceMainPresenterOutput: class {
    func dataFailure()
}

protocol InterfaceMainInteractor: class {
    var presenter: InterfaceMainPresenter? { get set }
    
    func downloadData()
}

protocol InterfaceMainInteractorOutput: class {
    func dataDownloaded()
    func dataFailure()
}

protocol InterfaceMainRouter: class {
    var presenter: InterfaceMainPresenter? { get set }
    
    func gotoMainScene()
}
