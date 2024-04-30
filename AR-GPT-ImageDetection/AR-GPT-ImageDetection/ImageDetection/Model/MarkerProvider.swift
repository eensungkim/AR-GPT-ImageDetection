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
                let orientation = orientation(from: markerImage.data)
                
                if orientation == .right {
                    finalImage = image.rotateImage90Degrees(image: image)
                } else {
                    finalImage = image
                }
                
                if let cgImage = finalImage?.cgImage {
                    let referenceImage = ARReferenceImage(cgImage, orientation: orientation, physicalWidth: 0.2)
                    referenceImage.name = markerImage.id.uuidString  // 중복되지 않는 값인 UUID 로 식별
                    referenceImages.insert(referenceImage)
                }
            }
        }
        return referenceImages
    }
    
    static func orientation(from data: Data) -> CGImagePropertyOrientation {
        let options = [kCGImageSourceShouldCache as String: false] // 메모리 사용을 최소화하기 위해 캐시하지 않음
        guard let source = CGImageSourceCreateWithData(data as CFData, options as CFDictionary) else {
            return .up // 기본 방향
        }
        
        let propertiesOptions = [kCGImageSourceTypeIdentifierHint as String: true]
        guard
            let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions as CFDictionary) as? Dictionary<String, Any>,
            let orientationValue = properties[kCGImagePropertyOrientation as String] as? UInt32,
            let orientation = CGImagePropertyOrientation(rawValue: orientationValue)
        else {
            return .up
        }
        
        print(orientation.rawValue)
        return orientation
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
