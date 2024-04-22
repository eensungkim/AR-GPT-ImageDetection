//
//  SnapshotGenerator.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/17/24.
//

import ARKit
import SceneKit

final class SnapshotGenerator: SnapshotCreatable {
    func generateSnapshotData(_ image: UIImage, in view: ARSCNView, of node: SCNNode) -> Data? {
        let nodeFrame = calculateFrame(in: view, of: node)
        if let croppedImage = cropImage(to: nodeFrame, from: image) {
            return croppedImage.pngData()
        }
        return nil
    }
    
    private func calculateFrame(in view: ARSCNView, of node: SCNNode) -> CGRect {
        let scale = UIScreen.main.scale
        let (min, max) = node.boundingBox
        let minVec = SCNVector3(min.x, min.y, min.z)
        let maxVec = SCNVector3(max.x, max.y, max.z)
        
        let minScreenPoint = view.projectPoint(node.convertPosition(minVec, to: nil))
        let maxScreenPoint = view.projectPoint(node.convertPosition(maxVec, to: nil))
        
        let x = CGFloat(minScreenPoint.x) * scale
        let y = CGFloat(minScreenPoint.y) * scale
        let width = CGFloat(maxScreenPoint.x - minScreenPoint.x) * scale
        let height = CGFloat(maxScreenPoint.y - minScreenPoint.y) * scale
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func cropImage(to rect: CGRect, from originalImage: UIImage) -> UIImage? {
        guard let cgImage = originalImage.cgImage else { return nil }
        let contextImage = UIImage(cgImage: cgImage)
        let newCropRect = CGRect(x: rect.minX,
                                 y: rect.minY,
                                 width: rect.width,
                                 height: rect.height)

        guard let croppedCgImage = contextImage.cgImage?.cropping(to: newCropRect) else { return nil }
        let croppedImage = UIImage(cgImage: croppedCgImage)
        
        return croppedImage
    }
}
