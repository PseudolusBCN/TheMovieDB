//
//  APIMovies.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit
import ObjectMapper

class APIMovies: Mappable {
    var page: Int!
    var totalPages: Int?
    var totalResults: Int?
    var results: [APIResults]?

    // MARK: - Init
    required init?(map: Map) {
    }
    
    // MARK: - Mapping
    func mapping(map: Map) {
        page <- map["page"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
        results <- map["results"]
    }
}
