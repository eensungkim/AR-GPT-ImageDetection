//
//  MarkerProvider.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import ARKit

struct MarkerProvider {
    static var markerImageSet: [String: MarkerImage] = [
        "qrCode": MarkerImage(
            id: UUID(),
            name: "qrCode",
            data: nil,
            description: "AGI 깃헙 레포지토리로 연결되는 QR코드입니다.",
            additionalInformation: "https://me-qr.com/ko/qr-code-generator 를 활용했습니다."
        ),
        "text": MarkerImage(
            id: UUID(),
            name: "text",
            data: nil,
            description: "Connect",
            additionalInformation: "연결한다는 의미를 담은 영단어입니다."
        ),
        "googleLogo": MarkerImage(
            id: UUID(),
            name: "googleLogo",
            data: nil,
            description: "구글 로고",
            additionalInformation: "원형의 구글 로고입니다.")
    ]
    
    static func loadMarkerImages() -> Set<ARReferenceImage> {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "MarkerImages", bundle: nil) else {
            return []
        }
        
        return referenceImages
    }
    
    static func getMetaData(by name: String) -> MarkerImage? {
        return markerImageSet[name]
    }
}
