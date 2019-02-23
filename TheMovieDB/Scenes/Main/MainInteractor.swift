//
//  MainInteractor.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class MainInteractor: InterfaceMainInteractor {
    weak var presenter: InterfaceMainPresenter?
    
    unowned var delegate: InterfaceMainInteractorOutput
    
    // MARK: - Init
    init(delegate: InterfaceMainInteractorOutput) {
        self.delegate = delegate
    }
    
    // MAR: - Public methods
    func downloadData() {
        let moviesManager = MoviesManager.sharedInstance()
        moviesManager.downloadDataFromFirstPage(success: {
            self.delegate.dataDownloaded()
        }) { (error) in
            self.delegate.dataFailure()
        }
    }
}
