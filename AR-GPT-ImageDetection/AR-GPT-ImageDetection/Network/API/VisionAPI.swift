//
//  VisionAPI.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import Foundation

/// ChatGPT Vision API 요청을 위한 API 설정
enum VisionAPI {
    case base64
}

extension VisionAPI {
    var headerFields: [String: String] {
        switch self {
        case .base64:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(Config.openAIAPIKey)"
            ]
        }
    }
    
    var url: String {
        switch self {
        case .base64:
            return "https://api.openai.com/v1/chat/completions"
        }
    }
    
    var method: String {
        switch self {
        case .base64:
            return "POST"
        }
    }
}

extension VisionAPI {
    func asURLRequest(with base64EncodedImage: String) throws -> URLRequest {
        var request = try URLRequest(url: self.asURL())
        request.httpMethod = self.method
        request.allHTTPHeaderFields = self.headerFields
        let data = VisionRequestModel(
            model: "gpt-4-turbo",
            messages: [
                RequestMessage(role: "user", content: [
                    Content(type: .text, text: "이 이미지는 어떤 정보를 담고 있지?", imageURL: nil),
                    Content(type: .image_url, text: nil, imageURL: ImageURL(url: base64EncodedImage))
                ])
            ],
            maxTokens: 2000
        )
        request.httpBody = try JSONEncoder().encode(data)
        return request
    }
    
    private func asURL() throws -> URL {
        guard let url = URL(string: self.url) else {
            throw NetworkError.invalidURL
        }
        return url
    }
}
