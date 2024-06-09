//
//  BaseFetcher.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation
import Alamofire

protocol BaseFetcherProtocol {
    func url() -> String
}

class BaseFetcher: BaseFetcherProtocol {
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: HTTPHeaders {
        return ["Authorization": "Bearer \(URLConstant.accessToken)"]
    }
    
    func url() -> String {
        return ""
    }
    
    public func getRequest<T: Decodable>(url: String, parameters: Parameters? = nil, successHandler: @escaping (T) -> Void, failureHandler: @escaping (AFError) -> Void) {
        AF.request(url, method: .get, parameters: parameters, encoding: encoding, headers: headers).responseDecodable(of: T.self, completionHandler: { data in
            switch data.result {
            case .success(let model):
                successHandler(model)
            case .failure(let error):
                failureHandler(error)
            }
        })
    }
    
    public func postRequest<T: Decodable>(url: String, parameters: Parameters, success: @escaping (T) -> Void, failure: @escaping (AFError) -> Void) {
        AF.request(url, method: .post, parameters: parameters, encoding: encoding, headers: headers).responseDecodable(of: T.self, completionHandler: { data in
            switch data.result {
            case .success(let model):
                success(model)
            case .failure(let error):
                failure(error)
            }
        })
    }
}
