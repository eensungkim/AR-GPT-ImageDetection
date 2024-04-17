//
//  VisionCommonModel.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/17/24.
//

import Foundation

// MARK: - Message
struct Message: Codable {
    let role: String
    let content: [Content]
}
