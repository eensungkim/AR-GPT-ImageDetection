//
//  MarkerImageManager.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//

import CoreData

/// 마커 이미지를 Core Data 와 연동해 저장하고 로드하는 매니저 클래스
final class MarkerImageManager {
    static let shared = MarkerImageManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MarkerImageModel")
        
        container.loadPersistentStores { _, error in
            if let error {
                // TODO: 추후 에러 처리 필요, fatalError 대체
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    private init() { }
}

// MARK: - MarkerImageManageable 프로토콜 구현부
extension MarkerImageManager: MarkerImageManageable {
    // Core Data 에 저장된 데이터를 불러와 [MarkerImage] 로 변환
    func fetchAll() -> [MarkerImage] {
        do {
            let markerImage = try persistentContainer.viewContext.fetch(MarkerImageMO.fetchRequest())
            let result: [MarkerImage] = markerImage.compactMap { $0.toDomain() }
            return result
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    // Core Data에 마커 저장
    func save() {
        guard persistentContainer.viewContext.hasChanges else { return }
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
    
    // 마커 삭제
    func delete(item: MarkerImageMO) {
        persistentContainer.viewContext.delete(item)
        save()
    }
}
