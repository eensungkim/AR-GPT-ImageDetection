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
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "MarkerImages", bundle: nil) else {
            return []
        }
        
        return referenceImages
    }
    
    static func getMetaData(by name: String) -> MarkerImage? {
        return markerImageSet[name]
    }
}
