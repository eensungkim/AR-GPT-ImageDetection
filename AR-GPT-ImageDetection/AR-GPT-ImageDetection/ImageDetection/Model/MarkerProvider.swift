//
//  MarkerProvider.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import ARKit
import ImageIO

struct MarkerProvider {
    static var markerImageSet: [String: MarkerImage] = [:]
    
    static func loadMarkerImages() -> Set<ARReferenceImage> {
        let manager = MarkerImageManager.shared
        var referenceImages = Set<ARReferenceImage>()
        
        manager.fetchAll().forEach { markerImage in
            markerImageSet[markerImage.id.uuidString] = markerImage
            var finalImage: UIImage?
            
            if let image = UIImage(data: markerImage.data) {
                if image.imageOrientation == .right {
                    finalImage = image.rotateImage90Degrees(image: image)
                } else {
                    finalImage = image
                }
                
                if let cgImage = finalImage?.cgImage {
                    let referenceImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation(image.imageOrientation), physicalWidth: 0.2)
                    referenceImage.name = markerImage.id.uuidString  // 중복되지 않는 값인 UUID 로 식별
                    referenceImages.insert(referenceImage)
                }
            }
        }
        return referenceImages
    }

    static func getMetaData(by id: String) -> MarkerImage? {
        return markerImageSet[id]
    }
}

extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
            case .up: self = .up
            case .upMirrored: self = .upMirrored
            case .down: self = .down
            case .downMirrored: self = .downMirrored
            case .left: self = .left
            case .leftMirrored: self = .leftMirrored
            case .right: self = .right
            case .rightMirrored: self = .rightMirrored
        @unknown default:
            fatalError()
        }
    }
}
extension UIImage.Orientation {
    init(_ cgOrientation: UIImage.Orientation) {
        switch cgOrientation {
            case .up: self = .up
            case .upMirrored: self = .upMirrored
            case .down: self = .down
            case .downMirrored: self = .downMirrored
            case .left: self = .left
            case .leftMirrored: self = .leftMirrored
            case .right: self = .right
            case .rightMirrored: self = .rightMirrored
        @unknown default:
            fatalError()
        }
    }
}
