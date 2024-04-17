//
//  MarkerProvider.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import ARKit
import Foundation

struct MarkerProvider {
    static func loadMarkerImages() -> Set<ARReferenceImage> {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "MarkerImages", bundle: nil) else {
            return []
        }
        
        return referenceImages
    }
}
