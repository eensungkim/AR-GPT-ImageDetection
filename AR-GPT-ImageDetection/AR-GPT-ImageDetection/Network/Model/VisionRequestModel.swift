//
//  VisionRequestModel.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import Foundation

// MARK: - VisionRequestModel
struct VisionRequestModel: Codable {
    let model: String
    let messages: [RequestMessage]
    let maxTokens: Int

    enum CodingKeys: String, CodingKey {
        case model, messages
        case maxTokens = "max_tokens"
    }
}

// MARK: - RequestMessage
struct RequestMessage: Codable {
    let role: String
    let content: [Content]
}

// MARK: - Content
struct Content: Codable {
    let type: ContentType
    let text: String?
    let imageURL: ImageURL?

    enum CodingKeys: String, CodingKey {
        case type, text
        case imageURL = "image_url"
    }
    
    enum ContentType: String, Codable {
        case text = "text"
        case image_url = "image_url"
    }
    
    init(type: ContentType, text: String?, imageURL: ImageURL?) {
        self.type = type
        self.text = text
        self.imageURL = imageURL
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            type = try container.decode(ContentType.self, forKey: .type)
            switch type {
            case .text:
                text = try container.decode(String.self, forKey: .text)
                imageURL = nil
            case .image_url:
                imageURL = try container.decode(ImageURL.self, forKey: .imageURL)
                text = nil
            }
        }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            switch type {
            case .text:
                try container.encode(text, forKey: .text)
            case .image_url:
                try container.encode(imageURL, forKey: .imageURL)
            }
        }
}

// MARK: - ImageURL
struct ImageURL: Codable {
    let url: String
}
