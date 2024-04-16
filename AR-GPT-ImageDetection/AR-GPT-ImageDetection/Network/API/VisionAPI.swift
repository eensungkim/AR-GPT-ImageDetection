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
