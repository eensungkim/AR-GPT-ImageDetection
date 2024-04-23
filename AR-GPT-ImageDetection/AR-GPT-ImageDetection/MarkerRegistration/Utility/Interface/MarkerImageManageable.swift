//
//  MarkerImageManageable.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/23/24.
//

import Foundation

protocol MarkerImageManageable {
    func fetchMarkerImage() -> [MarkerImage]
    func saveMarkerImage(_ marker: MarkerImage)
}
