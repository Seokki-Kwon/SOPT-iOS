//
//  NetworkError.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/8/25.
//

import Foundation

enum NetworkError: Int, Error, CustomStringConvertible {
    var description: String { self.errorDescription }
    case requestEncodingError
    case responseDecodingError
    case responseError
    case unknownError
    case loginFailed = 400
    case internalServerError = 500
    case notFoundError = 404
    case urlError
    
    var errorDescription: String {
        switch self {
        case .loginFailed: return "로그인에 실패하였습니다."
        case .requestEncodingError: return "REQUEST_ENCODING_ERROR"
        case .responseError: return "RESPONSE_ERROR"
        case .responseDecodingError: return "RESPONSE_DECODING_ERROR"
        case .unknownError: return "UNKNOWN_ERROR"
        case .internalServerError: return "500:INTERNAL_SERVER_ERROR"
        case .notFoundError: return "404:NOT_FOUND_ERROR"
        case .urlError: return "REQUEST_URL_NOT_EXIST "
        }
    }
}
