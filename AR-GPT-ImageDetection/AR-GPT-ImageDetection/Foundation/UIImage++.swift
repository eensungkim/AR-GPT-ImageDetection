//
//  UIImage++.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/24/24.
//

import UIKit

// MARK: - 이미지 사이즈 조절
extension UIImage {
    func resizeImage(toWidth width: CGFloat) -> UIImage? {
        let originalSize = self.size
        let scale = width / originalSize.width
        let newHeight = originalSize.height * scale
        let newSize = CGSize(width: width, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
