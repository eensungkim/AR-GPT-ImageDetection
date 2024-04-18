//
//  ImageDetectionViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import ARKit
import UIKit

/// AGI 앱의 이미지 인식 탭을 담당하는 컨트롤러
final class ImageDetectionViewController: UIViewController {
    private let session = ARSession()
    private let imageDetectionView = ARSCNView()
    private let service = VisionAPIService()
    private let snapshotGenerator = SnapshotGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        configureSession()
        configureImageDetectionView()
        addGesture()
    }
    
    override func loadView() {
        view = imageDetectionView
    }
}

// MARK: - Configuration
extension ImageDetectionViewController: ARSessionDelegate {
    private func configureSession() {
        session.delegate = self
        let configuration = ARWorldTrackingConfiguration()
        configuration.maximumNumberOfTrackedImages = 4
        configuration.detectionImages = MarkerProvider.loadMarkerImages()
        session.run(configuration)
    }
    
    private func configureImageDetectionView() {
        imageDetectionView.delegate = self
        imageDetectionView.session = session
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.imageDetectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let location = gestureRecognize.location(in: imageDetectionView)
        let hitResults = imageDetectionView.hitTest(location, options: [:])
        if let firstHit = hitResults.first {
            let node = firstHit.node
            Task {
                let snapshot = imageDetectionView.snapshot()
                guard let data = snapshotGenerator.generateSnapshotData(snapshot, in: imageDetectionView, of: node) else {
                    return
                }
                
                let gptInformationViewController = GPTInformationViewController()
                gptInformationViewController.modalPresentationStyle = .pageSheet
                
                if let sheet = gptInformationViewController.sheetPresentationController {
                    sheet.detents = [.medium()]
                    sheet.delegate = self
                }
                
                present(gptInformationViewController, animated: true)
                
                let result = try await service.requestInformation(base64EncodedImage: data.base64EncodedString())
                print(result)
                
                let content = result.choices[0].message.content
                gptInformationViewController.setText(content)
            }
        }
    }
}

// MARK: - ARSCNViewDelegate
extension ImageDetectionViewController: ARSCNViewDelegate {
    func renderer(_ renderer: any SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor {
            let overlayNode = createOverlayNode(for: imageAnchor.referenceImage)
            let descriptionNode = createDescriptionNode(for: imageAnchor.referenceImage)
            node.addChildNode(overlayNode)
            node.addChildNode(descriptionNode)
        }
    }
    
    private func createOverlayNode(for referenceImage: ARReferenceImage) -> SCNNode {
        let plane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
        plane.firstMaterial?.isDoubleSided = true
        
        let overlayNode = SCNNode(geometry: plane)
        overlayNode.eulerAngles.x = -.pi / 2
        overlayNode.opacity = 0.3
        return overlayNode
    }
    
    private func createDescriptionNode(for referenceImage: ARReferenceImage) -> SCNNode {
        let plane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
        plane.firstMaterial?.isDoubleSided = true
        
        guard let name = referenceImage.name,
              let metaData = MarkerProvider.markerImageSet[name] else { return SCNNode() }
        let text = """
            이미지명: \(metaData.name)
            정의: \(metaData.description)
            설명: \(metaData.additionalInformation)
            """
        let textImage = textToImage(drawText: text, inImage: CGSize(width: 1024, height: 512))
        plane.firstMaterial?.diffuse.contents = textImage
        
        let descriptionNode = SCNNode(geometry: plane)
        descriptionNode.eulerAngles.x = -.pi / 2
        descriptionNode.opacity = 1
        descriptionNode.worldPosition = .init(referenceImage.physicalSize.width, 0, 0)
        return descriptionNode
    }
    
    private func textToImage(drawText text: String, inImage imageSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let image = renderer.image { context in
            UIColor.white.setFill()
            context.fill(CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 30),
                .paragraphStyle: paragraphStyle
            ]
            
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            attributedText.draw(with: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height), options: .usesLineFragmentOrigin, context: nil)
        }
        return image
    }
}

extension ImageDetectionViewController: UISheetPresentationControllerDelegate { }
