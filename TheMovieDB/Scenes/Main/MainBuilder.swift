//
//  MainBuilder.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class MainBuilder: BaseBuilder {
    func main() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(delegate: view)
        let interactor = MainInteractor(delegate: presenter)
        let router = MainRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        router.presenter = presenter
        router.view = view
        
        return UINavigationController(rootViewController: view)
    }
}
