//
//  Popular.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation

struct Popular: Codable {
    let page, total_results, total_pages: Int
    let results: [PopularResult]

    enum CodingKeys: String, CodingKey {
        case page
        case total_results = "total_results"
        case total_pages = "total_pages"
        case results
    }
}

// MARK: - Result
struct PopularResult: Codable {
    let popularity: Double
    let vote_count: Int
    let video: Bool
    let poster_path: String
    let id: Int
    let adult: Bool
    let backdrop_path: String
    let original_title: String
    let genre_ids: [Int]
    let title: String
    let vote_average: Double
    let overview, release_date: String

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
