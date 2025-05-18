//
//  API.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/8/25.
//

import Foundation

protocol API {
    var baseUrl: String { get }
    var path: String { get }
    var method: String { get }
    var header: [String: String] { get }
    var body: Data? { get }
    var query: [URLQueryItem] { get }
}
