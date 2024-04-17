//
//  MarkerProvider.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import ARKit
import Foundation

struct MarkerProvider {
    static var markerImageSet: [String: MarkerImage] = [
        "qrCode": MarkerImage(
            name: "qrCode",
            type: .qrCode,
            data: nil,
            description: "AGI 깃헙 레포지토리로 연결되는 QR코드입니다.",
            additionalInformation: "https://me-qr.com/ko/qr-code-generator 를 활용했습니다."
        ),
        "text": MarkerImage(
            name: "text",
            type: .text,
            data: nil,
            description: "Connect",
            additionalInformation: "연결한다는 의미를 담은 영단어입니다."
        )
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
