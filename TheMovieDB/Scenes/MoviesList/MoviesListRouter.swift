//
//  MoviesListRouter.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 23/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class MoviesListRouter: InterfaceMoviesListRouter {
    weak var presenter: InterfaceMoviesListPresenter?
    weak var view: UIViewController?
}
