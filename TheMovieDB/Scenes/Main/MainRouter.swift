//
//  MainRouter.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class MainRouter: InterfaceMainRouter {
    weak var presenter: InterfaceMainPresenter?
    weak var view: UIViewController?
    
    func gotoMoviesListScene() {
        let viewController = MoviesListBuilder().main()
        view?.navigationController?.present(viewController, animated: true)
    }
}
