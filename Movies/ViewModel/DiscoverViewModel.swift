//
//  DiscoverViewModel.swift
//  Movies
//
//  Created by Tarokh on 9/6/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation

class DiscoverViewModel {
    
    // define some variables
    fileprivate let service = DiscoverDataService()
    var discoverItems = [DiscoverResult]()
    
    func getDiscoverMovie(completion: @escaping (ViewModelState) -> Void) {
        service.getDiscoverMovie { (discover, err) in
            if let error = err {
                print(error.localizedDescription)
                completion(.failure)
                return
            }
            for discoverResultItems in discover!.results! {
                self.discoverItems.append(discoverResultItems)
            }
            completion(.success)
        }
    }
    
}
