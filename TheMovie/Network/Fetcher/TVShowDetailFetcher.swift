//
//  TVShowDetailFetcher.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation
import Alamofire

class TVShowDetailFetcher: BaseFetcher {
    
    private var id:Int = 0
    
    func fetchAPITVWith(id: Int, successHandler: @escaping ( TVModel) -> Void, failureHandler: @escaping (AFError) -> Void) {
        let parameters: Parameters = ["series_id": id]
        self.id = id
        getRequest(url: url(), parameters: parameters) { (entity: TVModel) in
            successHandler(entity)
        } failureHandler: { error in
            failureHandler(error)
        }
    }
    
    override func url() -> String {
        return URLConstant.baseUrl + URLConstant.tvDetail + String(id)
    }
}

