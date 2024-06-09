//
//  MovieDetailFetcher.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation
import Alamofire

class MovieDetailFetcher: BaseFetcher {
    
    private var id: Int = 0
    
    func fetchAPIMovieWith(id: Int, successHandler: @escaping ( MovieDetailModel) -> Void, failureHandler: @escaping (AFError) -> Void) {
        let parameters: Parameters = ["movie_id": id]
        self.id = id
        getRequest(url: url(), parameters: parameters) { (entity:  MovieDetailModel) in
            successHandler(entity)
        } failureHandler: { error in
            failureHandler(error)
        }
    }
    
    override func url() -> String {
        return URLConstant.baseUrl + URLConstant.movieDetail + String(id)
    }
}

