//
//  MarkerImageManageable.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/23/24.
//

import CoreData

protocol MarkerImageManageable {
    var container: NSPersistentContainer { get }
    func fetchMarkerImage() -> [MarkerImage]
}
