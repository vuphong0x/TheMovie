//
//  MoviesRealmModel.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation
import RealmSwift

class MoviesRealmModel: Object {
    @objc dynamic var _id = UUID().uuidString
    @objc dynamic var idMovie: Double = 0
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}
