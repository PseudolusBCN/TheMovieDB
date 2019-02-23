//
//  URLDataManager.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import ObjectMapper

class URLDataManager: NSObject {
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: - Public methods
    func getMovies(_ page: Int, query: String, completion: @escaping(_ responseData: APIMovies?, _ error: NSError?) -> Void) {
        var url: String
        var params: [String : Any]
        if query.isEmpty {
            url = "https://api.themoviedb.org/3/movie/popular"
            params = ["api_key" : tmdbAPIKey,
                      "page" : page,
                      "include_adult": "false"]
        } else {
            url = "https://api.themoviedb.org/3/search/movie"
            params = ["api_key" : tmdbAPIKey,
                      "page" : page,
                      "include_adult": "false",
                      "query": query]
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        processServiceRequest(.get, url: url, params: params) { (response, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            let mappedResponse = Mapper<APIMovies>().map(JSONObject: response)
            completion(mappedResponse, nil)
        }
    }
    
    func getMovieImage(_ imagePath: String, completion: @escaping(_ responseData: UIImage) -> Void) {
        let url = "https://image.tmdb.org/t/p/original/"
        let imageRequest = "\(url)\(imagePath)"

        Alamofire.request(imageRequest).responseImage { response in
            if let image = response.result.value {
                completion(image)
            } else {
                completion(UIImage())
            }
        }
    }
    
    // MARK: - Private methods
    private func processServiceRequest(_ method: HTTPMethod, url: String, params: [String: Any], completion: @escaping(_ responseData: Any?, _ error: NSError?) -> Void) {
        cancellAllRequests()
        
        print("URL REQUEST: \(url)")
        print("\(params)")

        Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    let error = NSError(domain: "NSURLErrorDomain", code: 500, userInfo: [NSLocalizedDescriptionKey: response.result.error?.localizedDescription as Any])
                    completion(nil, error)
                    return
                }
                print("URL RESPONSE:")
                print("\(response.result.value!)")
                completion(response.result.value!, nil)
        }
    }
    
    private func cancellAllRequests() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
}
