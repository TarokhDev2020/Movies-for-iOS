//
//  Discover.swift
//  Movies
//
//  Created by Tarokh on 9/6/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation

// MARK: - Discover
struct Discover: Codable {
    var page, total_results, total_pages: Int?
    var results: [DiscoverResult]?

    enum CodingKeys: String, CodingKey {
        case page
        case total_results = "total_results"
        case total_pages = "total_pages"
        case results
    }
}

// MARK: - Result
struct DiscoverResult: Codable {
    var popularity: Double?
    var vote_count: Int?
    var video: Bool?
    var poster_path: String?
    var id: Int?
    var adult: Bool?
    var backdrop_path: String?
    var original_title: String?
    var genre_ids: [Int]?
    var title: String?
    var vote_average: Double?
    var overview, release_date: String?

    enum CodingKeys: String, CodingKey {
        case popularity
        case vote_count = "vote_count"
        case video
        case poster_path = "poster_path"
        case id, adult
        case backdrop_path = "backdrop_path"
        case original_title = "original_title"
        case genre_ids = "genre_ids"
        case title
        case vote_average = "vote_average"
        case overview
        case release_date = "release_date"
    }
}
