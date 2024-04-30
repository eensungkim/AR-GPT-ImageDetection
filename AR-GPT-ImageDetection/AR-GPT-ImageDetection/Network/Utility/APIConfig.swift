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
    첫 번째로 전달한 이미지는 인식을 위한 레퍼런스 마커(Marker) 이미지이고, 두 번째로 전달한 이미지는 해당 마커를 인식했을 때 인식한 화면을 캡쳐한 이미지야.
    마커 이미지를 기준으로 캡쳐한 이미지의 유사도를 판별해서 '정확도' 라는 개념으로 답변해줘.
    이때 '정확도' 는 백분율로 표시해주면 되고 소수점 3자리까지만 기록해줘.
    
    그리고 캡쳐한 이미지를 분석해서 정확도와 마커 이미지에 관계 없이, 캡쳐한 이미지가 무엇에 해당하는 것으로 보이는지를 분석해서 정의와 설명을 작성해줘.
    양식은 아래와 같이 구성되면 좋겠어.
    리턴하는 텍스트 정보를 그대로 띄울 예정이기 때문에 마크다운은 넣지 않아도 좋아.

    정확도 :
    정의 :
    설명 :
    """
    }
    
    static var model: String {
        return "gpt-4-turbo"
    }
}
