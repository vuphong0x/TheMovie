//
//  ConfigurationFetcher.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation
import Alamofire

class ConfigurationFetcher: BaseFetcher {
    
    func fetchAPIConfiguration(page: Int, successHandler: @escaping ( ConfigurationModel) -> Void, failureHandler: @escaping (AFError) -> Void) {
        getRequest(url: url()) { (entity: ConfigurationModel) in
            successHandler(entity)
        } failureHandler: { error in
            failureHandler(error)
        }
    }
    
    override func url() -> String {
        return URLConstant.baseUrl + URLConstant.configuration
    }
}
