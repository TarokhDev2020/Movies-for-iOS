//
//  MovieService.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation
import Moya

enum MovieService {
    case popular
    case upcoming
    case topRated
    case discover
}

extension MovieService: TargetType {
    
    
    var baseURL: URL {
        switch self {
        case .popular:
            return URL(string: "https://api.themoviedb.org/3/movie/")!
        case .upcoming:
            return URL(string: "https://api.themoviedb.org/3/movie/")!
        case .topRated:
            return URL(string: "https://api.themoviedb.org/3/movie/")!
        case .discover:
            return URL(string: "https://api.themoviedb.org/3/discover/")!
        }
    }
    
    var path: String {
        switch self {
        case .popular:
            return "popular"
        case .upcoming:
            return "upcoming"
        case .topRated:
            return "top_rated"
        case .discover:
            return "movie/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popular:
            return .get
        case .upcoming:
            return .get
        case .topRated:
            return .get
        case .discover:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .popular:
            return Data()
        case .upcoming:
            return Data()
        case .topRated:
            return Data()
        case .discover:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .popular:
            return .requestParameters(parameters: ["api_key": "661290a964f218a732bf3fd1ccf856aa", "language": "en-US", "page": "1"], encoding: URLEncoding.queryString)
        case .upcoming:
            return .requestParameters(parameters: ["api_key": "661290a964f218a732bf3fd1ccf856aa", "language": "en-US", "page": "1"], encoding: URLEncoding.queryString)
        case .topRated:
            return .requestParameters(parameters: ["api_key": "661290a964f218a732bf3fd1ccf856aa", "language": "en-US", "page": "1"], encoding: URLEncoding.queryString)
        case .discover:
            return .requestParameters(parameters: ["api_key": "661290a964f218a732bf3fd1ccf856aa", "language": "en-US", "page": "1", "sort_by": "popularity.desc", "include_adult": "true", "include_video" : "false"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
