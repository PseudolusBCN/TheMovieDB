//
//  MainPresenter.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class MainPresenter: InterfaceMainPresenter {
    var router: InterfaceMainRouter?
    var interactor: InterfaceMainInteractor?
    weak var view: InterfaceMainViewController?

    unowned var delegate: InterfaceMainPresenterOutput

    // MARK: - Init
    init(delegate: InterfaceMainPresenterOutput) {
        self.delegate = delegate
    }

    // MARK: - Public methods
    func downloadData() {
        interactor?.downloadData()
    }
}

extension MainPresenter: InterfaceMainInteractorOutput {
    func dataDownloaded() {
        router?.gotoMainScene()
    }
    
    func dataFailure() {
        delegate.dataFailure()
    }
}
