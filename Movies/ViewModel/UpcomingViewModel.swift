//
//  UpcomingViewModel.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation

class UpcomingViewModel {
    
    // define some variables
    fileprivate let service = UpcomingDataService()
    var upcomingItems = [UpcomingResult]()
    
    // define some functions
    func getUpcomingMovies(completion: @escaping (ViewModelState) -> Void) {
        service.getUpcomingMovie { (upcoming, err) in
            if let error = err {
                print(error.localizedDescription)
                completion(.failure)
                return
            }
            for upcomingResultItems in upcoming!.results {
                self.upcomingItems.append(upcomingResultItems)
            }
            completion(.success)
        }
    }
    
}
