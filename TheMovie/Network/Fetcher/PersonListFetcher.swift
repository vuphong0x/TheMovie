//
//  PersonListFetcher.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation
import Alamofire

class PersonListFetcher: BaseFetcher {
    
    func fetchPersonListFromAPI(page: Int, successHandler: @escaping ( PersonListModel) -> Void, failureHandler: @escaping (AFError) -> Void) {
        let parameters: Parameters = ["page": page]
        
        getRequest(url: url(), parameters: parameters) { (entity:  PersonListModel) in
            successHandler(entity)
        } failureHandler: { error in
            failureHandler(error)
        }
    }
    
    override func url() -> String {
        return URLConstant.baseUrl + URLConstant.peopleList
    }
}
