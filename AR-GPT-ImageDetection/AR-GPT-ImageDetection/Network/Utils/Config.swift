//
//  Config.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import Foundation

enum APIConfig {
    static var openAIAPIKey: String {
        guard let key = Bundle.main.infoDictionary?["OPENAI_API_KEY"] as? String else {
            assertionFailure("OPENAI_API_KEY could not found.")
            return ""
        }
        return key
    }
    
    static var prompt: String {
        return """
    이 이미지의 정의와 설명, 그리고 유사이미지를 3개를 답변으로 돌려줘.
    양식은 아래와 같이 구성되면 좋겠어.

    정의 : [답변]
    설명 : [답변]
    유사이미지 :
    링크
    링크
    링크
    """
    }
    
    static var model: String {
        return "gpt-4-turbo"
    }
}
