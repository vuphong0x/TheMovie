//
//  TVListFetcher.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation
import Alamofire

class TVListFetcher: BaseFetcher {
    
    func fetchAPITVList(page: Int, successHandler: @escaping ( TVListModel) -> Void, failureHandler: @escaping (AFError) -> Void) {
        let parameters: Parameters = ["page": page]
        
        getRequest(url: url(), parameters: parameters) { (entity: TVListModel) in
            successHandler(entity)
        } failureHandler: { error in
            failureHandler(error)
        }
    }
    
    override func url() -> String {
        return URLConstant.baseUrl + URLConstant.tvList
    }
}
