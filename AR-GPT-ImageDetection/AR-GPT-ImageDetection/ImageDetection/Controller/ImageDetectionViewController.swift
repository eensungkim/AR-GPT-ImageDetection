//
//  ImageDetectionViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import ARKit

/// AGI 앱의 이미지 인식 탭을 담당하는 컨트롤러
final class ImageDetectionViewController: UIViewController {
    // MARK: - Properties
    private let imageDetectionView = ARSCNView()
    private let gptInformationViewController = GPTInformationViewController()
    private let service = VisionAPIService()
    private let snapshotGenerator: SnapshotCreatable
    private let textImageGenerator: TextImageCreatable
    private let coloredSymbolProvider: ColoredSymbolProtocol
    private var cacheData: [SCNNode: String] = [:]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageDetectionView()
        addGesture()
    }
    
    override func loadView() {
        view = imageDetectionView
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        configureImageDetectionView()
    }
    
    init(
        snapshotGenerator: SnapshotCreatable,
        textImageGenerator: TextImageCreatable,
        coloredSymbolProvider: ColoredSymbolProtocol
    ) {
        self.snapshotGenerator = snapshotGenerator
        self.textImageGenerator = textImageGenerator
        self.coloredSymbolProvider = coloredSymbolProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration
extension ImageDetectionViewController: ARSessionDelegate {
    private func configureImageDetectionView() {
        imageDetectionView.delegate = self
        imageDetectionView.session.delegate = self
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.maximumNumberOfTrackedImages = 4
        configuration.detectionImages = MarkerProvider.loadMarkerImages()
        
        imageDetectionView.session.run(configuration)
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
            presentInformation(node: node)
        }
    }
}

// MARK: - GPTInformationViewController 모달
extension ImageDetectionViewController {
    private func presentInformation(node: SCNNode) {
        gptInformationViewController.resetInformation()
        gptInformationViewController.setupModalBehavior(delegate: self)
        present(gptInformationViewController, animated: true)
        if let responseCache = cacheData[node] {
            gptInformationViewController.setText(responseCache)
        } else {
            requestGPTInformation(with: node)
        }
    }
    
    private func requestGPTInformation(with node: SCNNode) {
        var snapshotData: Data? = nil
        var referenceData: Data? = nil
        
        do {
            let snapshot = imageDetectionView.snapshot()
            snapshotData = try snapshotGenerator.generateSnapshotData(snapshot, in: imageDetectionView, of: node)
            guard
                let id = node.name,
                let marker = MarkerProvider.getMetaData(by: id)
            else {
                return
            }
            referenceData = marker.data
        } catch {
            makeAlert(message: error.localizedDescription, confirmAction: nil)
        }
        
        guard
            let validSnapshotData = snapshotData,
            let validReferenceData = referenceData
        else {
            return
        }
            
        Task {
            do {
                let result = try await service.requestInformation(with: [
                    validReferenceData.base64EncodedString(),
                    validSnapshotData.base64EncodedString()
                ])
                let content = result.choices[0].message.content
                cacheData[node] = content
                DispatchQueue.main.async { [weak self] in
                    self?.gptInformationViewController.setText(content)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.presentedViewController?.dismiss(animated: true) {
                        self?.makeAlert(message: error.localizedDescription, confirmAction: nil)
                    }
                }
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
        let scaleFactor: CGFloat = 1.3
        let plane = SCNPlane(width: referenceImage.physicalSize.width * scaleFactor, height: referenceImage.physicalSize.height * scaleFactor)
        if let image = coloredSymbolProvider.viewfinder {
            plane.firstMaterial?.diffuse.contents = image
        }
        plane.firstMaterial?.isDoubleSided = true
        
        let overlayNode = SCNNode(geometry: plane)
        overlayNode.name = referenceImage.name
        overlayNode.eulerAngles.x = -.pi / 2
        overlayNode.opacity = 1
        return overlayNode
    }
    
    private func createDescriptionNode(for referenceImage: ARReferenceImage) -> SCNNode {
        let plane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
        plane.firstMaterial?.isDoubleSided = true
        
        guard let name = referenceImage.name,
              let metaData = MarkerProvider.markerImageSet[name] else { return SCNNode() }
        let text = """
            이미지명: \(metaData.name)
            정의: \(metaData.information)
            설명: \(metaData.additionalInformation)
            """
        let textImage = textImageGenerator.textToImage(drawText: text, inImage: CGSize(width: 1024, height: 512))
        plane.firstMaterial?.diffuse.contents = textImage
        
        let descriptionNode = SCNNode(geometry: plane)
        descriptionNode.eulerAngles.x = -.pi / 2
        descriptionNode.opacity = 1
        descriptionNode.worldPosition = .init(referenceImage.physicalSize.width, 0, 0)
        return descriptionNode
    }
}

extension ImageDetectionViewController: UISheetPresentationControllerDelegate { }
