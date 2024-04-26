//
//  MarkerProvider.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import ARKit

struct MarkerProvider {
    static var markerImageSet: [String: MarkerImage] = [:]
    
    static func loadMarkerImages() -> Set<ARReferenceImage> {
        let manager = MarkerImageManager.shared
        let referenceImages: Set<ARReferenceImage> = Set(manager.fetchAll().compactMap { markerImage in
            markerImageSet[markerImage.id.uuidString] = markerImage
            guard let image = UIImage(data: markerImage.data)?.cgImage else {
                return nil
            }
            let referenceImage = ARReferenceImage(image, orientation: .up, physicalWidth: 0.2)
            referenceImage.name = markerImage.id.uuidString  // 중복되지 않는 값인 UUID 로 식별
            return referenceImage
        })
        
        return referenceImages
    }
    
    static func getMetaData(by id: String) -> MarkerImage? {
        return markerImageSet[id]
    }
}
