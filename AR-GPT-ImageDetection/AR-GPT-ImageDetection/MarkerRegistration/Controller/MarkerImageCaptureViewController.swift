//
//  MarkerImageCaptureViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/29/24.
//

import AVFoundation
import UIKit

/// MarkerImage 촬영용 카메라 뷰컨트롤러
final class MarkerImageCaptureViewController: UIViewController {
    private let captureSession = AVCaptureSession()
    private let captureOutput = AVCapturePhotoOutput()
    weak var delegate: MarkerRegistrationViewControllerDelegate?
    
    private lazy var cameraPreviewView: CameraPreviewView = {
        let cameraPreviewView = CameraPreviewView()
        cameraPreviewView.videoPreviewLayer.session = self.captureSession
        return cameraPreviewView
    }()
    private lazy var overlayView: UIView = {
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        overlayView.layer.masksToBounds = true
        return overlayView
    }()
    private lazy var cancelButton: UIButton = {
        var configuration = UIButton.Configuration.borderless()
        configuration.title = "취소"
        let cancelButton = UIButton(configuration: configuration)
        cancelButton.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        return cancelButton
    }()
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = """
원하는 대상을
하단 프레임에 맞춰
촬영해 주세요.
"""
        textLabel.numberOfLines = 0
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.font = .preferredFont(forTextStyle: .title2)
        return textLabel
    }()
    private lazy var captureButton: UIButton = {
        let captureButton = UIButton(configuration: .borderless())
        let configuration = UIImage.SymbolConfiguration(pointSize: 50, weight: .light, scale: .large)
        let image = UIImage(systemName: "circle.inset.filled", withConfiguration: configuration)
        captureButton.setImage(image, for: .normal)
        captureButton.addTarget(self, action: #selector(tapCaptureButton), for: .touchUpInside)
        return captureButton
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSession()
        DispatchQueue.global().async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        setupOverlay()
    }
}

// MARK: - @objc Methods
extension MarkerImageCaptureViewController {
    @objc private func tapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func tapCaptureButton() {
        let settings = AVCapturePhotoSettings()
        captureOutput.capturePhoto(with: settings, delegate: self)
    }
}

// MARK: - Configuration
extension MarkerImageCaptureViewController {
    private func configureSession() {
        // captureSession 설정 시작
        captureSession.beginConfiguration()
        
        // 입력 카메라 설정
        guard
            let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
            captureSession.canAddInput(videoDeviceInput)
        else {
            return
        }
        captureSession.addInput(videoDeviceInput)
        
        // 출력 미디어 타입 설정
        guard captureSession.canAddOutput(captureOutput) else {
            return
        }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(captureOutput)
        
        captureSession.commitConfiguration()
    }
    
    private func setupOverlay() {
        let frame = view.frame
        
        let targetSize = CGSize(width: frame.width * 0.9, height: frame.width * 0.559)
        let targetOrigin = CGPoint(
            x: (frame.width - targetSize.width) / 2,
            y: (frame.height - targetSize.height) / 2
        )
        let targetArea = UIView(frame: CGRect(origin: targetOrigin, size: targetSize))
        targetArea.backgroundColor = .clear
        
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        path.addRect(frame)
        path.addRect(CGRect(origin: targetOrigin, size: targetSize))
        maskLayer.path = path
        maskLayer.fillRule = .evenOdd
        
        overlayView.layer.mask = maskLayer
        overlayView.addSubview(targetArea)
    }
}
   
// MARK: - UI
extension MarkerImageCaptureViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(cameraPreviewView)
        view.addSubview(overlayView)
        view.addSubview(cancelButton)
        view.addSubview(textLabel)
        view.addSubview(captureButton)

        cameraPreviewView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cameraPreviewView.topAnchor.constraint(equalTo: view.topAnchor),
            cameraPreviewView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cameraPreviewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraPreviewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: cameraPreviewView.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: cameraPreviewView.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: cameraPreviewView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: cameraPreviewView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 100),
            textLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            captureButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            captureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension MarkerImageCaptureViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        guard
            let data = photo.fileDataRepresentation(),
            let image = UIImage(data: data),
            let cgImage = image.cgImage
        else { return }
        
        let imageWidth = CGFloat(cgImage.height)
        let imageHeight = CGFloat(cgImage.width)
        
        let cameraPreviewViewWidth = cameraPreviewView.bounds.width
        let scale = imageWidth / cameraPreviewViewWidth
        
        guard let maskLayerFrame = overlayView.subviews.first?.frame else { return }
        
        let realCropX = (imageHeight / 2) - (maskLayerFrame.size.height * scale / 2)
        let realCropY = maskLayerFrame.origin.x * scale
        let realCropWidth = maskLayerFrame.size.height * scale
        let realCropHeight = maskLayerFrame.size.width * scale
        let realCropRect = CGRect(x: realCropX, y: realCropY, width: realCropWidth, height: realCropHeight)
        
        guard let croppedCGImage = cgImage.cropping(to: realCropRect) else {
            print("크롭 실패")
            return
        }
        
        let croppedImage = UIImage(cgImage: croppedCGImage, scale: 1.0, orientation: image.imageOrientation)
        delegate?.setImage(croppedImage)
        dismiss(animated: true)
    }
}
