//
//  SnapshotGenerator.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/17/24.
//

import ARKit

final class SnapshotGenerator: SnapshotCreatable {
    func generateSnapshotData(_ image: UIImage, in view: ARSCNView, of node: SCNNode) throws -> Data? {
        let nodeFrame = calculateFrame(in: view, of: node)
        let croppedImage = try cropImage(to: nodeFrame, from: image)
        return croppedImage?.pngData()
    }
    
    private func calculateFrame(in view: ARSCNView, of node: SCNNode) -> CGRect {
        let scale = UIScreen.main.scale
        let (minVec, maxVec) = node.boundingBox
        
        let minScreenPoint = view.projectPoint(node.convertPosition(minVec, to: nil))
        let maxScreenPoint = view.projectPoint(node.convertPosition(maxVec, to: nil))
        
        let x = CGFloat(minScreenPoint.x) * scale
        let y = CGFloat(minScreenPoint.y) * scale
        let width = CGFloat(maxScreenPoint.x - minScreenPoint.x) * scale
        let height = CGFloat(maxScreenPoint.y - minScreenPoint.y) * scale
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func cropImage(to rect: CGRect, from originalImage: UIImage) throws -> UIImage? {
        guard let cgImage = originalImage.cgImage else {
            throw SnapshotError.cgImageConversionFailure
        }
        guard let croppedCgImage = cgImage.cropping(to: rect) else {
            throw SnapshotError.cropFailure
        }
        let croppedImage = UIImage(cgImage: croppedCgImage)
        
        return croppedImage
    }
}
