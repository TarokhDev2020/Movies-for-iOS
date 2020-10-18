//
//  MovieDataService.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation
import Moya

class MovieDataService {
    
    fileprivate let provider = MoyaProvider<MovieService>(endpointClosure: { (target: MovieService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Content-Type" : "charset=UTF-8"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    })
    
    func getPopularMovie(completion: @escaping (Popular?, Error?) -> Void) {
        provider.request(.popular) { popularResponse in
            switch popularResponse {
            case .success(let response):
                do {
                    let popular = try JSONDecoder().decode(Popular.self, from: response.data)
                    completion(popular, nil)
                }
                catch let jsonError as NSError {
                    print(jsonError.localizedDescription)
                    completion(nil, jsonError)
                }
            case .failure(let moyaError):
                print(moyaError.localizedDescription)
                completion(nil, moyaError)
            }
        }
    }
    
}
