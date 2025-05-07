//
//  MovieListAPI.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/8/25.
//

import Foundation

enum MovieListAPI: API {
    case fetchMovieList
}

extension MovieListAPI {
    var baseUrl: String {
        return "\(Secret.url)"
    }
    
    var path: String {
        switch self {
        case .fetchMovieList:
            return "\(baseUrl)/movie/searchMovieList.json"
        }
    }
    
    var method: String {
        switch self {
        case .fetchMovieList:
            return "GET"
        }
    }
    
    var header: [String : String] {
        switch self {
        default:
            return ["Content-Type":"application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .fetchMovieList:
            return nil
        }
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .fetchMovieList:
            return [URLQueryItem(name: "key", value: Secret.apiKey)]
        }
    }
}
