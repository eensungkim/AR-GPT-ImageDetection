//
//  TextImageGenerator.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/18/24.
//

import UIKit

struct TextImageGenerator {
    static func textToImage(drawText text: String, inImage imageSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let image = renderer.image { context in
            UIColor.white.setFill()
            context.fill(CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 30),
                .paragraphStyle: paragraphStyle
            ]
            
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            attributedText.draw(with: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height), options: .usesLineFragmentOrigin, context: nil)
        }
        return image
    }
}
