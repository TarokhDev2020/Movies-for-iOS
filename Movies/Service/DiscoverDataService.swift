//
//  DiscoverDataService.swift
//  Movies
//
//  Created by Tarokh on 9/6/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation
import Moya


class DiscoverDataService {
    
    fileprivate let provider = MoyaProvider<MovieService>(endpointClosure: { (target: MovieService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Content-Type" : "charset=UTF-8"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    })
    
    func getDiscoverMovie(completion: @escaping (Discover?, Error?) -> Void) {
        provider.request(.discover) { discoverResponse in
            switch discoverResponse {
            case .success(let response):
                do {
                    let discover = try JSONDecoder().decode(Discover.self, from: response.data)
                    completion(discover, nil)
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

