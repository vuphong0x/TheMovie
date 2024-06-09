//
//  URLConstant.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import Foundation

class URLConstant {
    static let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYjA5MjcwMjc4NzQ5NWNmZjVlN2I0ZjdkZWE3MGUzNyIsInN1YiI6IjY1MjJiZjY3ZWE4NGM3MDBjYTBjNzFjYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.iQJ9R8Qjtnh0QSFDRY46r2Mu_x5UnlcU5qiJGDkFHuw"
    static let baseUrl = "https://api.themoviedb.org/"
    static let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    
    static let configuration = "3/authentication"
    static let movieList = "3/movie/popular"
    static let peopleList = "3/person/popular"
    static let tvList = "3/tv/popular"
    static let movieDetail = "3/movie/"
    static let tvDetail = "3/tv/"
}
