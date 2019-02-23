//
//  MoviesListInterfaces.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 23/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

protocol InterfaceMoviesListViewController: class {
    var presenter: InterfaceMoviesListPresenter? { get set }
}

protocol InterfaceMoviesListPresenter: class {
    var router: InterfaceMoviesListRouter? { get set }
    var interactor: InterfaceMoviesListInteractor? { get set }
    var view: InterfaceMoviesListViewController? { get set }
}

protocol InterfaceMoviesListPresenterOutput: class {
}

protocol InterfaceMoviesListInteractor: class {
    var presenter: InterfaceMoviesListPresenter? { get set }
}

protocol InterfaceMoviesListInteractorOutput: class {
}

protocol InterfaceMoviesListRouter: class {
    var presenter: InterfaceMoviesListPresenter? { get set }
}
