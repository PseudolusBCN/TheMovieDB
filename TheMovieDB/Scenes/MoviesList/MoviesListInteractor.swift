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
    
    private let moviesManager = MoviesManager.sharedInstance()
    
    
    // MARK: - Init
    init(delegate: InterfaceMoviesListInteractorOutput) {
        self.delegate = delegate
    }
    
    // MAR: - Public methods
    func numberOfMovies() -> Int {
        return moviesManager.moviesList().count
    }

    func movie(_ index: NSInteger) -> APIResult {
        return moviesManager.movie(index: index)
    }

    func movieDate(_ index: NSInteger) -> String {
        return moviesManager.movieDate(index: index)
    }
    
    func movieImage(_ index: NSInteger, completion: @escaping(_ responseData: UIImage) -> Void) {
        moviesManager.movieImage(index: index) { (image) in
            completion(image)
        }
    }

    func moviesPending() -> Bool {
        return moviesManager.moviesPending()
    }

    func firstRequest() -> Bool {
        return moviesManager.firstRequest()
    }

    func downloadData(_ searchText: String) {
        moviesManager.downloadData(query: searchText, success: {
            self.delegate.dataDownloaded()
        }, failure: { (error) in
            self.delegate.dataFailure()
        })
    }
}
