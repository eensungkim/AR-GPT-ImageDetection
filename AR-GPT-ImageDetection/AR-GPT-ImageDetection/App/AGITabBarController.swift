//
//  AGITabBarController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import UIKit

/// AGI 앱의 탭바를 관리하는 컨트롤러
final class AGITabBarController: UITabBarController {
    enum Tab: Int {
        case registration
        case detection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: - Configuration
extension AGITabBarController {
    private func configureViewControllers() {
        
    }
}

// MARK: - AGITabBarController.Tab
extension AGITabBarController.Tab {
    fileprivate var tabBarItem: UITabBarItem {
        switch self {
        case .registration:
            return UITabBarItem(
                title: "이미지 등록",
                image: UIImage(systemName: "photo.stack.fill"),
                tag: self.rawValue
            )
        case .detection:
            return UITabBarItem(
                title: "이미지 인식",
                image: UIImage(systemName: "camera.viewfinder"),
                tag: self.rawValue
            )
        }
    }
}
