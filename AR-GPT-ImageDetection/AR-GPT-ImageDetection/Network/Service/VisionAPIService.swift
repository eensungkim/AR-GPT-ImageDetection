//
//  VisionAPIService.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/17/24.
//

import Foundation

final class VisionAPIService {
    private let manager = NetworkManager(session: URLSession.shared)
    
    func requestInformation(with data: Data) async throws -> VisionResponseModel {
        let request = try VisionAPI.base64.asURLRequest(data: data)
        let response: VisionResponseModel = try await manager.request(request)
        return response
    }
}
