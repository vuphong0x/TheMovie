//
//  ConfigurationModel.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation

struct ConfigurationModel: Decodable {
    var success: Bool
    var statusCode: Int
    var statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
