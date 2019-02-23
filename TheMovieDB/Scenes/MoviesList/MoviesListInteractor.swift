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
    func numberOfMovies() -> Int {
        let moviesManager = MoviesManager.sharedInstance()
        return moviesManager.moviesList().count
    }

    func movie(_ index: NSInteger) -> APIResult {
        let moviesManager = MoviesManager.sharedInstance()
        return moviesManager.movie(index: index)
    }

    func movieDate(_ index: NSInteger) -> String {
        let moviesManager = MoviesManager.sharedInstance()
        return moviesManager.movieDate(index: index)
    }
    
    func movieImage(_ index: NSInteger, completion: @escaping(_ responseData: UIImage) -> Void) {
        let moviesManager = MoviesManager.sharedInstance()
        moviesManager.movieImage(index: index) { (image) in
            completion(image)
        }
    }
}
