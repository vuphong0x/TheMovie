//
//  PersonListModel.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation

struct PersonListModel: Decodable {
    let page: Int
    let results: [PersonModel]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct PersonModel: Decodable {
    let id: Int
    let adult: Bool
    var gender: Int
    var knownForDepartment: String
    var name: String
    let originalName: String
    let popularity: Double
    let profilePath: String
    
    enum CodingKeys: String, CodingKey {
        case id, adult, gender, name, popularity
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}
