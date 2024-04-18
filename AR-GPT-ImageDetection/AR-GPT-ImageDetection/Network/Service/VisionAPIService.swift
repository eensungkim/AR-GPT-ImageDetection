//
//  VisionAPIService.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/17/24.
//

import Foundation

final class VisionAPIService {
    private let manager = NetworkManager(session: URLSession.shared)
    
    func requestInformation(base64EncodedImage: String) async throws -> VisionResponseModel {
        let request = try VisionAPI.base64.asURLRequest(with: base64EncodedImage)
        let response: VisionResponseModel = try await manager.request(request)
        return response
    }
    
    func requestInformation(imageURL: String) async throws -> VisionResponseModel {
        let request = try VisionAPI.base64.asURLRequest(with: imageURL)
        let response: VisionResponseModel = try await manager.request(request)
        return response
    }
}
