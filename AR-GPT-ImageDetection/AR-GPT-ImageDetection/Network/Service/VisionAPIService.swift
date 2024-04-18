//
//  VisionAPIService.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/17/24.
//

import Foundation

final class VisionAPIService {
    private let manager = NetworkManager(session: URLSession.shared)
    
    func requestInformation(with base64EncodedImages: [String]) async throws -> VisionResponseModel {
        let data = createVisionRequestModel(with: base64EncodedImages)
        let request = try VisionAPI.base64.asURLRequest(with: data)
        let response: VisionResponseModel = try await manager.request(request)
        return response
    }
    
    private func createVisionRequestModel(with images: [String]) -> VisionRequestModel {
        var contents: [Content] = [
            Content(
                type: .text,
                text: APIConfig.prompt,
                imageURL: nil
            )
        ]
        let images: [Content] = images.map { encoded in
            let imageURI = "data:image/jpeg;base64,\(encoded)"
            return Content(type: .image_url, text: nil, imageURL: ImageURL(url: imageURI))
            
        }
        contents.append(contentsOf: images)
        let requestMessage = RequestMessage(role: "user", content: contents)
        let result: VisionRequestModel = .init(messages: [requestMessage])
        
        return result
    }
}
