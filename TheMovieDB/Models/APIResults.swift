//
//  APIResults.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit
import ObjectMapper

class APIResults: Mappable {
    var id: Int?
    var adult: Bool?
    var backdropPath: String?
    var genreIds: [Int]?
    var originalLanguage : String?
    var originalTitle : String?
    var overview: String?
    var popularity: Float?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Float?
    var voteCount: Int?
    
    // MARK: - Init
    required init?(map: Map) {
    }
    
    // MARK: - Mapping
    func mapping(map: Map) {
        id <- map["id"]
        adult <- map["adult"]
        backdropPath <- map["backdrop_path"]
        genreIds <- map["genre_ids"]
        originalLanguage <- map["original_language"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        releaseDate <- map["release_date"]
        title <- map["title"]
        video <- map["video"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
    }
}
