//
//  SnapshotCreatable.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//

import ARKit

protocol SnapshotCreatable {
    func generateSnapshotData(_ image: UIImage, in view: ARSCNView, of node: SCNNode) throws -> Data?
}
