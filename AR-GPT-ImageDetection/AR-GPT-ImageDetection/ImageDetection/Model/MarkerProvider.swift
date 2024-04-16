//
//  MarkerProvider.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import ARKit
import Foundation

struct MarkerProvider {
    func loadMarkerImages() -> Set<ARReferenceImage> {
        guard let image = UIImage(named: "MarkerImage"),
              let cgImage = image.cgImage else {
            print("이미지 생성이 제대로 완료되지 않음")
            return []
        }
        
        return [ARReferenceImage(cgImage, orientation: .up, physicalWidth: 0.05)]
    }
}
