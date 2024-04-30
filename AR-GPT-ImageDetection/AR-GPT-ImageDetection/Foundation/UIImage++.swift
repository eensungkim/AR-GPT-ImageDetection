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
    
    func rotateImage90Degrees(image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        let size = CGSize(width: cgImage.height, height: cgImage.width)
        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // 좌표계 변환
        context.translateBy(x: size.width / 2, y: size.height / 2)
        context.rotate(by: .pi)
        context.scaleBy(x: 1.0, y: -1.0)

        // 회전된 이미지 그리기
        context.draw(cgImage, in: CGRect(x: -image.size.height / 2, y: -image.size.width / 2, width: image.size.height, height: image.size.width))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
