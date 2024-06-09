//
//  RealmService.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    func getDataFromDB <T: Object> (_: T.Type) ->  Results<T>
    func addData<T: Object>(object: T, update: Realm.UpdatePolicy)
}

class RealmService: RealmServiceProtocol {
    
    var database:Realm
    static let shared = RealmService()

    init() {
        database = try! Realm()
    }

    func getDataFromDB <T: Object> (_: T.Type) ->  Results<T> {
        let results: Results<T> =  database.objects(T.self)
        return results
    }
    
    func addData<T: Object>(object: T, update: Realm.UpdatePolicy = .error) {
        do {
            try database.write {
                database.add(object, update: update)
            }
        } catch {
        }
    }
}
