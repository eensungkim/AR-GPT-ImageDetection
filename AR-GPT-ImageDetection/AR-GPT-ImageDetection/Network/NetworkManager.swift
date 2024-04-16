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

final class NetworkManager {
    let session: Requestable
    
    init(session: Requestable) {
        self.session = session
    }
}
