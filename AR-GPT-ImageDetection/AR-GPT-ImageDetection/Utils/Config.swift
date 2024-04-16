//
//  Config.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import Foundation

enum Config {
    static var openAIAPIKey: String {
        guard let key = Bundle.main.infoDictionary?["OPENAI_API_KEY"] as? String else {
            assertionFailure("OPENAI_API_KEY could not found.")
            return ""
        }
        return key
    }
}
