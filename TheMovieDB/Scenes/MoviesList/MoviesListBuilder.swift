//
//  MoviesListBuilder.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 23/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class MoviesListBuilder: BaseBuilder {
    func main() -> UIViewController {
        let view = MoviesListViewController()
        let presenter = MoviesListPresenter(delegate: view)
        let interactor = MoviesListInteractor(delegate: presenter)
        let router = MoviesListRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        router.presenter = presenter
        router.view = view
        
        return UINavigationController(rootViewController: view)
    }
}
