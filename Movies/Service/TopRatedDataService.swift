//
//  TopRatedDataService.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation
import Moya

class TopRatedDataService {
    
    fileprivate let provider = MoyaProvider<MovieService>(endpointClosure: { (target: MovieService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Content-Type" : "charset=UTF-8"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    })
    
    func getTopRatedMovie(completion: @escaping (TopRated?, Error?) -> Void) {
        provider.request(.topRated) { topRatedResponse in
            switch topRatedResponse {
            case .success(let response):
                do {
                    let topRated = try JSONDecoder().decode(TopRated.self, from: response.data)
                    completion(topRated, nil)
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
