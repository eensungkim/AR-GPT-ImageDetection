//
//  VisionRequestModel.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import Foundation

// MARK: -
struct VisionRequestModel: Codable {
    let model: String
    let messages: [Message]
    let maxTokens: Int

    enum CodingKeys: String, CodingKey {
        case model
        case messages
        case maxTokens = "max_tokens"
    }
}

// MARK: - Message
struct Message: Codable {
    let role: String
    let content: [Content]
}

// MARK: - Content
struct Content: Codable {
    let type: String
    let text: String?
    let imageURL: ImageURL?

    enum CodingKeys: String, CodingKey {
        case type
        case text
        case imageURL = "image_url"
    }
}

// MARK: - ImageURL
struct ImageURL: Codable {
    let url: String
}
