//
//  AGIImageDetectionViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import ARKit
import UIKit

/// AGI 앱의 이미지 인식 탭을 담당하는 컨트롤러
final class AGIImageDetectionViewController: UIViewController {
    private let session = ARSession()
    private let imageDetectionView = ARSCNView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        configureSession()
        configureImageDetectionView()
    }
    
    override func loadView() {
        view = imageDetectionView
    }
}

// MARK: - Configuration
extension AGIImageDetectionViewController: ARSessionDelegate {
    private func configureSession() {
        session.delegate = self
        let configuration = ARWorldTrackingConfiguration()
        configuration.maximumNumberOfTrackedImages = 4
        session.run(configuration)
    }
    
    private func configureImageDetectionView() {
        imageDetectionView.delegate = self
        imageDetectionView.session = session
    }
}

// MARK: - ARSCNViewDelegate
extension AGIImageDetectionViewController: ARSCNViewDelegate {
    func renderer(_ renderer: any SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor {
            let overlayNode = createOverlayNode(for: imageAnchor.referenceImage)
            node.addChildNode(overlayNode)
        }
    }
    
    private func createOverlayNode(for referenceImage: ARReferenceImage) -> SCNNode {
        let plane: SCNPlane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
        
        let overlayNode = SCNNode(geometry: plane)
        overlayNode.name = referenceImage.name
        overlayNode.eulerAngles.x = -.pi / 2
        overlayNode.opacity = 0.25
        
        return overlayNode
    }
}
