//
//  TVModel.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation

struct TVModel: Decodable {
    let id: Int
    let adult: Bool
    let originalName: String
    let popularity: Float
    let backdropPath: String
    let posterPath: String
    let name: String
    let firstAirDate: String
    let overview: String
    
    
    enum CodingKeys: String, CodingKey {
        case id, adult, name, popularity, overview
        case originalName = "original_name"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
    }
}
