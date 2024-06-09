//
//  MovieListFetcher.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation
import Alamofire

class MovieListFetcher: BaseFetcher {
    
    func fetchAPIMovieList(page: Int, successHandler: @escaping ( MovieListModel) -> Void, failureHandler: @escaping (AFError) -> Void) {
        let parameters: Parameters = ["page": page]
        
        getRequest(url: url(), parameters: parameters) { (entity:  MovieListModel) in
            successHandler(entity)
        } failureHandler: { error in
            failureHandler(error)
        }
    }
    
    override func url() -> String {
        return URLConstant.baseUrl + URLConstant.movieList
    }
}
