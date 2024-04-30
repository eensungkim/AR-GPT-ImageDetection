//
//  CameraPreviewView.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/29/24.
//

import AVFoundation
import UIKit

final class CameraPreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    /// Convenience wrapper to get layer as its statically known type.
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
