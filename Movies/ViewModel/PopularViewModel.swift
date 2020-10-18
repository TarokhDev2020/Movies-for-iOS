//
//  PopularViewModel.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation

class PopularViewModel {
    
    // define some variables
    fileprivate let service = MovieDataService()
    var popularItems = [PopularResult]()
    
    // define some functions
    func getPopularMovies(completion: @escaping (ViewModelState) -> Void) {
        service.getPopularMovie { (popular, err) in
            if let error = err {
                print(error.localizedDescription)
                completion(.failure)
                return
            }
            for popularResultItems in popular!.results {
                self.popularItems.append(popularResultItems)
            }
            completion(.success)
        }
    }
    
}
