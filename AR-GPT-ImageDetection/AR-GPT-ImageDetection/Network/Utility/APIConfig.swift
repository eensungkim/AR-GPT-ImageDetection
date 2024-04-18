//
//  APIConfig.swift
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
    첫 번째로 전달한 이미지는 마커(Marker) 이미지이고, 두 번째로 전달한 이미지는 마커를 인식해서 캡쳐한 이미지야.
    마커 이미지를 기준으로 캡쳐한 이미지의 유사도를 판별해서 '정확도' 라는 개념으로 답변해줘.
    이때 '정확도' 는 백분율로 표시해주면 되고 소수점 3자리까지만 기록해줘.
    
    그리고 캡쳐한 이미지를 분석한 정의와 설명을 작성해주고, 마지막으로 캡쳐한 이미지와 유사한 이미지 3개를 답변에 포함해줘.
    양식은 아래와 같이 구성되면 좋겠어.
    아래 [] 로 감싼 부분에 답변을 포함하면 돼.

    정확도 : [답변]
    정의 : [답변]
    설명 : [답변]
    유사이미지 :
    [링크]
    [링크]
    [링크]
    """
    }
    
    static var model: String {
        return "gpt-4-turbo"
    }
}
