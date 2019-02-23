//
//  MoviesManager.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

enum MovieSearch {
    case global
    case filtered
}

enum RequestType {
    case globalStart
    case globalContinue
    case filteredStart
    case filteredContinue
}

class MoviesManager: NSObject {
    private static var instance: MoviesManager?

    private var movies: [APIResult] = []

    private var currentPage = 0
    private var totalPages = 0
    private var movieSeachType: MovieSearch = .global

    private var previousSeachType: MovieSearch = .global
    private var previousQuery = ""
    
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
    func downloadData(query: String, success: @escaping() -> Void, failure: @escaping(_ error: NSError?) -> Void) {
        switch requestType(query) {
        case .globalStart:
            downloadDataFromFirstPage(success: {
                success()
            }) { (error) in
                failure(error)
            }
        case .globalContinue:
            downloadDataFromNextPage(success: {
                success()
            }) { (error) in
                failure(error)
            }
        case .filteredStart:
            downloadFilteredDataFromFirstPage(query: query, success: {
                success()
            }) { (error) in
                failure(error)
            }
        case .filteredContinue:
            downloadFilteredDataFromNextPage(query: query, success: {
                success()
            }) { (error) in
                failure(error)
            }
        }
    }

    func moviesList() -> [APIResult]{
        return movies
    }

    func movie(index: NSInteger) -> APIResult {
        return movies[index]
    }
    
    func movieDate(index: NSInteger) -> String {
        if let releaseDate = movies[index].releaseDate as String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let date = dateFormatter.date(from: releaseDate)
            dateFormatter.dateFormat = "yyyy"

            return dateFormatter.string(from: date!)
        }
        return ""
    }
    
    func movieImage(index: NSInteger, completion: @escaping(_ responseData: UIImage) -> Void) {
        if let moviePoster = movies[index].posterPath as String? {
            URLDataManager().getMovieImage(moviePoster) { (image) in
                completion(image)
            }
        }
        completion(UIImage())
    }
    
    func moviesPending() -> Bool {
        return currentPage < totalPages
    }
    
    func firstRequest() -> Bool {
        return currentPage == 1
    }

    // MARK: - Private methods
    private func requestType(_ query: String) -> RequestType {
        if movies.isEmpty {
            return .globalStart
        } else {
            if query.isEmpty {
                return (previousSeachType == .global) ? .globalContinue : .globalStart
            } else {
                if query != previousQuery {
                    return .filteredStart
                } else {
                    return (previousSeachType == .global) ? .filteredStart : .filteredContinue
                }
            }
        }
    }

    private func downloadDataFromFirstPage(success: @escaping() -> Void, failure: @escaping(_ error: NSError?) -> Void) {
        movies = []
        movieSeachType = .global
        
        getMovies(page: 1, query: "", success: {
            success()
        }) { (error) in
            failure(error)
        }
    }
    
    private func downloadDataFromNextPage(success: @escaping() -> Void, failure: @escaping(_ error: NSError?) -> Void) {
        movieSeachType = .global
        
        getMovies(page: currentPage + 1, query: "", success: {
            success()
        }) { (error) in
            failure(error)
        }
    }
    
    private func downloadFilteredDataFromFirstPage(query: String, success: @escaping() -> Void, failure: @escaping(_ error: NSError?) -> Void) {
        movies = []
        movieSeachType = .filtered
        
        getMovies(page: 1, query: query, success: {
            success()
        }) { (error) in
            failure(error)
        }
    }
    
    private func downloadFilteredDataFromNextPage(query: String, success: @escaping() -> Void, failure: @escaping(_ error: NSError?) -> Void) {
        movieSeachType = .filtered
        
        getMovies(page: currentPage + 1, query: query, success: {
            success()
        }) { (error) in
            failure(error)
        }
    }

    private func getMovies(page: Int, query: String, success: @escaping() -> Void, failure: @escaping(_ error: NSError?) -> Void) {
        previousSeachType = movieSeachType
        previousQuery = query
        URLDataManager().getMovies(page, query: query) { (response, error) in
            guard response != nil, error == nil else {
                failure(error)
                return
            }
            
            self.currentPage = response!.page!
            self.totalPages = response!.totalPages!
            if let downloadedMovies = response!.results {
                self.movies.append(contentsOf: downloadedMovies)
            }
            success()
        }
    }
}
