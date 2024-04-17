//
//  SnapshotGenerator.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/17/24.
//

import Foundation
import SceneKit

final class SnapshotGenerator {
    func captureImage(of node: SCNNode) -> UIImage? {
        // 새 씬 생성
        let scene = SCNScene()
        scene.rootNode.addChildNode(node.clone()) // 노드 복제 및 추가

        // 렌더러 설정
        let renderer = SCNRenderer(device: MTLCreateSystemDefaultDevice(), options: nil)
        renderer.scene = scene
        renderer.pointOfView = setupCameraNode() // 적절한 카메라 노드 설정

        // 이미지 캡처
        let imageSize = CGSize(width: 640, height: 480) // 적당한 이미지 크기 설정
        let image = renderer.snapshot(atTime: 0, with: imageSize, antialiasingMode: .none)
        return image
    }

    func setupCameraNode() -> SCNNode {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15) // 카메라 위치 조정 필요
        return cameraNode
    }
}
