//
//  MarkerImageManageable.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/23/24.
//

import CoreData

protocol MarkerImageManageable {
    var persistentContainer: NSPersistentContainer { get }
    func fetch(by id: UUID) -> MarkerImageMO?
    func fetchAll() -> [MarkerImage]
    func update(with markerImage: MarkerImage)
    func save()
    func delete(item: MarkerImageMO)
}
