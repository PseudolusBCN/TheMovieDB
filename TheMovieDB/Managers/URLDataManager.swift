//
//  URLDataManager.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class URLDataManager: NSObject {
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: - Public methods
    func getMovies(_ page: Int, completion: @escaping(_ responseData: APIMovies?, _ error: NSError?) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/popular"
        let params: [String : Any] = ["page" : page,
                                      "api_key" : tmdbAPIKey]

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
        print("Cancelling previous requests")
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
}
