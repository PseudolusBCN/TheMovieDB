//
//  MoviesListPresenter.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 23/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class MoviesListPresenter: InterfaceMoviesListPresenter {
    var router: InterfaceMoviesListRouter?
    var interactor: InterfaceMoviesListInteractor?
    weak var view: InterfaceMoviesListViewController?

    unowned var delegate: InterfaceMoviesListPresenterOutput
    
    // MARK: - Init
    init(delegate: InterfaceMoviesListPresenterOutput) {
        self.delegate = delegate
    }
    
    // MARK: - Public methods
 }

extension MoviesListPresenter: InterfaceMoviesListInteractorOutput {
}
