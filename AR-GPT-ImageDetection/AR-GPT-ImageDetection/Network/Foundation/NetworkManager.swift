//
//  NetworkManager.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import Foundation

protocol Requestable {
    func data(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
}

extension URLSession: Requestable { }

final class NetworkManager {
    private let session: Requestable
    
    init(session: Requestable) {
        self.session = session
    }
}

extension NetworkManager {
    func request<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidURLResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return try JSONDecoder().decode(T.self, from: data)
        default:
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
    }
}
