//
//  MoviesManager.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class MoviesManager: NSObject {
    private static var instance: MoviesManager?

    private var movies: [APIResults] = []

    private var page = 1
    private var filteredList = false
    
    // MARK: - Singleton
    class func sharedInstance() -> MoviesManager {
        guard let currentInstance = instance else {
            instance = MoviesManager()
            return instance!
        }
        return currentInstance
    }
    
    class func clearInstance() {
        instance = nil
    }
    
    // MARK: - Init
    override init() {
        super.init()
    }

    // MARK: - Public methods
    func downloadDataFromFirstPage(success: @escaping() -> Void, failure: @escaping(_ error: NSError?) -> Void) {
        page = 1
        movies.removeAll()
        URLDataManager().getMovies(page) { (response, error) in
            guard response != nil, error == nil else {
                failure(error)
                return
            }

            if let downloadedMovies = response!.results {
                self.movies.append(contentsOf: downloadedMovies)
            }
            success()
        }
    }

    func downloadDataFromNextPage(success: @escaping() -> Void, failure: @escaping(_ error: NSError?) -> Void) {
        page += 1
        URLDataManager().getMovies(page) { (response, error) in
            guard response != nil, error == nil else {
                failure(error)
                return
            }

            if let downloadedMovies = response!.results {
                self.movies.append(contentsOf: downloadedMovies)
            }
            success()
        }
    }

    func downloadFilteredDataFromFirstPage() {
        page = 1
    }

    func downloadFilteredDataFromNextPage() {
        page += 1
    }
}
