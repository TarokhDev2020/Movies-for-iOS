//
//  UpcomingDataService.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation
import Moya

class UpcomingDataService {
    
    fileprivate let provider = MoyaProvider<MovieService>(endpointClosure: { (target: MovieService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Content-Type" : "charset=UTF-8"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    })
    
    func getUpcomingMovie(completion: @escaping (Upcoming?, Error?) -> Void) {
        provider.request(.upcoming) { upcomingResponse in
            switch upcomingResponse {
            case .success(let response):
                do {
                    let upcoming = try JSONDecoder().decode(Upcoming.self, from: response.data)
                    completion(upcoming, nil)
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
