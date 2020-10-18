//
//  TopRatedViewModel.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation

class TopRatedViewModel {
    
    // define some variables
    fileprivate let service = TopRatedDataService()
    var topRatedItems = [TopRatedResult]()
    
    // define some functions
    func getTopRatedMovies(completion: @escaping (ViewModelState) -> Void) {
        service.getTopRatedMovie { (topRated, err) in
            if let error = err {
                print(error.localizedDescription)
                completion(.failure)
                return
            }
            for topRatedResultItems in topRated!.results {
                self.topRatedItems.append(topRatedResultItems)
            }
            completion(.success)
        }
    }
    
}
