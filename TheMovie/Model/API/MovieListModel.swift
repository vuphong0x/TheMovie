//
//  MovieListModel.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation

struct MovieListModel: Decodable {
    let page: Int
    let results: [MovieModel]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieModel: Decodable {
    let id: Int
    let adult: Bool
    var title: String
    var overview: String
    var voteAverage: Float
    let posterPath: String?
    let backdropPath: String?
    let originalTitle: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, adult
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case releaseDate = "release_date"
    }
}
