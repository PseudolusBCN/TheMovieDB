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

    private var movies: [APIResult] = []

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
    
//    func movieImage(index: NSInteger) -> UIImage {
//        if let moviePoster = movies[index].posterPath as String? {
//            URLDataManager().getMovieImage(moviePoster) { (image) in
//                return image
//            }
//        }
//        return UIImage()
//    }
}
