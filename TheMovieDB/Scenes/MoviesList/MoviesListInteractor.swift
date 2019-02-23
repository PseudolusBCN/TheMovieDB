//
//  MoviesListInteractor.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 23/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class MoviesListInteractor: InterfaceMoviesListInteractor {
    weak var presenter: InterfaceMoviesListPresenter?
    
    unowned var delegate: InterfaceMoviesListInteractorOutput
    
    // MARK: - Init
    init(delegate: InterfaceMoviesListInteractorOutput) {
        self.delegate = delegate
    }
    
    // MAR: - Public methods
}
