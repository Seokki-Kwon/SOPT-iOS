//
//  NetworkService.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/8/25.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    private let configuration = URLSessionConfiguration.default
    private lazy var session = URLSession(configuration: configuration)
    private init() {}
    
    // 네트워크 요청 함수
    func request<T: Decodable>(_ endpoint: API) async throws -> T {
        do {
            // 요청 정보 구성
            var request = try configureRequest(endpoint)
            
            // body가 존재한다면 추가
            if let body = endpoint.body {
                request.httpBody = body
            }
            
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.responseError
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw configureHTTPError(errorCode: httpResponse.statusCode)
            }
            
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw error
        }
    }
    
    // URLRequest 설정
    private func configureRequest(_ endpoint: API) throws -> URLRequest {
        guard var components = URLComponents(string: endpoint.path) else {
            throw NetworkError.urlError
        }
        components.queryItems = endpoint.query.map { $0 }
        guard let url = components.url else {
            throw NetworkError.urlError
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        endpoint.header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode) ?? NetworkError.unknownError
    }
}
